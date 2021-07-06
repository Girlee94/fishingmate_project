package com.ej.fishingmate.qna.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.manager.mapper.ManagerSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.qna.mapper.QnaImageSQLMapper;
import com.ej.fishingmate.qna.mapper.QnaSQLMapper;
import com.ej.fishingmate.vo.InfoFreeboardCommentVO;
import com.ej.fishingmate.vo.ManagerVO;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.QnaCategoryVO;
import com.ej.fishingmate.vo.QnaCommentVO;
import com.ej.fishingmate.vo.QnaImageVO;
import com.ej.fishingmate.vo.QnaVO;

@Service
public class QnaServiceImpl {

   @Autowired
   private QnaSQLMapper qnaSQLMapper;

   @Autowired
   private QnaImageSQLMapper qnaImageSQLMapper;

   @Autowired
   private MemberSQLMapper memberSQLMapper;

   @Autowired
   private ManagerSQLMapper managerSQLMapper;

   // ----------------------------글 비밀번호
   public void password(QnaVO qnaVO) {

      qnaSQLMapper.contentpassword(qnaVO);

   }

   // ----------------------------글 작성

   public void writeContent(QnaVO qnaVO, ArrayList<QnaImageVO> qnaImageVOList) {
      int qna_freeboard_no = qnaSQLMapper.createFreeboardKey();
      qnaVO.setQna_freeboard_no(qna_freeboard_no);

      qnaSQLMapper.insert(qnaVO);

      for (QnaImageVO qnaImageVO : qnaImageVOList) {
         qnaImageVO.setQna_Freeboard_no(qna_freeboard_no);
         qnaImageSQLMapper.insert(qnaImageVO);
      }
   }

   // ----------------------------글 불러오기
   public HashMap<String, Object> getQnaContent(int qna_freeboard_no) {

      HashMap<String, Object> map = new HashMap<String, Object>();

      QnaVO qnaVO = qnaSQLMapper.selectContentByNo(qna_freeboard_no);
      MemberVO memberVO = memberSQLMapper.memberSelectByNo(qnaVO.getMember_no());

      ArrayList<QnaImageVO> qnaImageVOList = qnaImageSQLMapper.selectByqnaFreeboardNo(qna_freeboard_no);

      map.put("MemberVO", memberVO);
      map.put("QnaVO", qnaVO);
      map.put("qnaImageVOList", qnaImageVOList);

      return map;
   }

   // -------------전체 가져오기
   public ArrayList<HashMap<String, Object>> getallContent(String qna_category_no) {

      ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
      ArrayList<QnaVO> qnaNoList = null;
      if (qna_category_no == null) {
         qnaNoList = qnaSQLMapper.selectAll();
      } else {
         qnaNoList = qnaSQLMapper.selectByCategoryNo(qna_category_no);
      }

      for (QnaVO qnaVO : qnaNoList) {

         HashMap<String, Object> map = new HashMap<String, Object>();
         int qna_freeboard_no = qnaVO.getQna_freeboard_no();

         QnaCategoryVO qnaCategoryVO = qnaSQLMapper.selectQnaCategoryVO(qnaVO.getQna_category_no());
         MemberVO memberVO = memberSQLMapper.memberSelectByNo(qnaVO.getMember_no());
         int commentCount = qnaSQLMapper.selectCommentCountByNo(qna_freeboard_no);
         int commentAdminCount = qnaSQLMapper.selectCommentAdminCountByNo(qna_freeboard_no);

         ArrayList<QnaImageVO> qnaImageVO = qnaImageSQLMapper.selectByqnaFreeboardNo(qnaVO.getQna_freeboard_no());

         //ArrayList<QnaCommentVO> commentList = qnaSQLMapper.selectAllContentCommentByNo(qna_freeboard_no);
         ArrayList<QnaCommentVO> commentList = qnaSQLMapper.selectAllContentAdminCommentByNo(qna_freeboard_no);
         
         map.put("qnaVO", qnaVO);
         map.put("qnaImageVO", qnaImageVO);
         map.put("memberVO", memberVO);
         map.put("commentCount", commentCount);
         map.put("qnaCategoryVO", qnaCategoryVO);
         map.put("commentAdminCount", commentAdminCount);
         
         map.put("commentList", commentList);
         
         

         result.add(map);
      }

      return result;
   }


   public void updateContent(QnaVO qnaVO, ArrayList<QnaImageVO> qnaImageVOList) {
      qnaSQLMapper.updateContent(qnaVO);

      for (QnaImageVO qnaImageVO : qnaImageVOList) {
         qnaImageVO.setQna_Freeboard_no(qnaVO.getQna_freeboard_no());
         qnaImageSQLMapper.insert(qnaImageVO);
      }
   }

   public void deleteContent(int qna_freeboard_no) {
      qnaSQLMapper.deleteContent(qna_freeboard_no);

   }

   public void deleteContentImage(int qna_freeboard_no) {
      qnaImageSQLMapper.deleteContentImage(qna_freeboard_no);

   }

   public void increaseReadCount(int qna_freeboard_no) {
      qnaSQLMapper.updateReadCount(qna_freeboard_no);
   }

   public ArrayList<QnaCategoryVO> getQnaCategoryList() {
      ArrayList<QnaCategoryVO> list = qnaSQLMapper.selectQnaCategoryList();

      return list;
   }

   // ------------ 댓글
   public void writeComment(QnaCommentVO qnacommentVO) {
      qnaSQLMapper.insertComment(qnacommentVO);
   }

   // ------------ 댓글 리스트 불러오기
   public ArrayList<HashMap<String, Object>> getCommentList(int qna_freeboard_no) {

      ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

      ArrayList<QnaCommentVO> commentList = qnaSQLMapper.selectAllContentCommentByNo(qna_freeboard_no);
      System.out.println("+++" + commentList);

      for (QnaCommentVO qnaCommentVO : commentList) {
         HashMap<String, Object> map = new HashMap<String, Object>();

         MemberVO memberVO = memberSQLMapper.selectByNo(qnaCommentVO.getMember_no());
         ManagerVO managerVO = managerSQLMapper.selectByManagerNo(qnaCommentVO.getManager_no());
         
         System.out.println(memberVO);

         map.put("QnaCommentVO", qnaCommentVO);
         map.put("MemberVO", memberVO);
         map.put("ManagerVO", managerVO);

         result.add(map);
      }

      return result;
   }

   // ------------ 댓글 1개 불러오기
   public QnaCommentVO selectComment(int member_no, int qna_comment_no) {
      return qnaSQLMapper.selectCommentByMnoAndCno(member_no, qna_comment_no);
   }

//   ------------   댓글 수정
   public void modifyCommentByMnoAndCno(QnaCommentVO QnaCommentVO) {
      qnaSQLMapper.modifyCommentByMnoAndCno(QnaCommentVO);
   }

   // ----------------------------------댓글선택
   public QnaCommentVO getContentCommentBynO(int member_no, int qna_comment_no) {
      return qnaSQLMapper.selectCommentByMnoAndCno(member_no, qna_comment_no);
   }

//   ------------   댓글 지우기
   public void deleteCommentByMno(QnaCommentVO qna_comment_no) {
      qnaSQLMapper.deleteComment(qna_comment_no);
   }

   // ------------ 댓글 수
   public int getCommentCountByNo(int qna_freeboard_no) {
      return qnaSQLMapper.selectCommentCountByNo(qna_freeboard_no);
   }

   public QnaCommentVO getCommentByMnoAndCno(int member_no, int qna_comment_no) {
      return null;
   }

}   