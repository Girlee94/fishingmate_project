package com.ej.fishingmate.qna.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.QnaCategoryVO;
import com.ej.fishingmate.vo.QnaCommentVO;
import com.ej.fishingmate.vo.QnaVO;


public interface QnaSQLMapper {
   
   //   ----------------   글 1개 불러오기
   public QnaVO selectContentByNo(int qna_freeboard_no);
   //   ----------------   
   public ArrayList<QnaVO> selectAll();
   public ArrayList<QnaVO> selectByCategoryNo(String qna_category_no);
   
   
   //   ----------------   
   public int createFreeboardKey();
   //   ----------------   글 입력
   public void insert(QnaVO QnaVO);
   //   ----------------   글 삭제
   public void deleteContent(int qna_freeboard_no);
   //   ----------------   글 수정
   public void updateContent(QnaVO QnaVO);
   //   ----------------   카테고리 목록
   public ArrayList<QnaCategoryVO> selectQnaCategoryList();
   //   ----------------   글 카테고리
   public QnaCategoryVO selectQnaCategoryVO(int qna_category_no);
   
   //   ----------------   댓글 입력
   public void insertComment(QnaCommentVO qnacommentVO);
   //   ----------------   댓글 전체 부르기
   public ArrayList<QnaCommentVO> selectAllContentCommentByNo(int qna_freeboard_no);
   
   public ArrayList<QnaCommentVO> selectAllContentAdminCommentByNo(int qna_freeboard_no);
   
   //   ----------------   댓글 수정
   public void modifyCommentByMnoAndCno(QnaCommentVO qnaCommentVO);
   //   ----------------   댓글 삭제
   public void deleteComment(QnaCommentVO qna_comment_no);

   //   ----------------   댓글 1개 부르기
   public QnaCommentVO selectCommentByMnoAndCno(
         @Param("member_no") int member_no,
         @Param("qna_comment_no") int qna_comment_no);
   //   ----------------   댓글 수
   public int selectCommentCountByNo(int no);
   //   ----------------   관리자 색깔
   public int selectCommentAdminCountByNo(int no);
   
   //   ----------------   조회수 수정
   public void updateReadCount(int qna_freeboard_no);
//   ----------------   게시글 비밀번호
   public void contentpassword(QnaVO QnaVO);
/*   
   //   ------------   페이징
   public ArrayList<QnaVO> selectFreeboardContent(
         @Param("searchWord") String searchWord , 
         @Param("searchType") String searchType ,
         @Param("pageNum") int pageNum 
         );
*/
}