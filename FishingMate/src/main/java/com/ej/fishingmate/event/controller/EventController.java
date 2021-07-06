package com.ej.fishingmate.event.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ej.fishingmate.event.service.EventServiceImpl;
import com.ej.fishingmate.vo.EventImageVO;
import com.ej.fishingmate.vo.EventRecommendVO;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.EventWishlistVO;
import com.ej.fishingmate.vo.MemberVO;



@Controller
@RequestMapping("/event/*")
public class EventController {

   private static final String eventVO = null;
   @Autowired
   private EventServiceImpl eventService;
   
   //이벤트 페이지 메인(리스트 출력)-주빈
   @RequestMapping("eventPage.do")
   public String eventPage(Model model, @RequestParam(defaultValue="1") int searchNo) {
      //여기는 이벤트 페이지 시작 점.... 아 강사 짜증난다....<--선생님이 쓴 것임!!
      
      
      //타입이 다른 객체를 담아서(다형성) 반복시켜야 하기 때문에 ArrayList<HashMap<K,V>>를 선언해서 담아준다.
      //[과제] : 다형성 공부 하기
      //이벤트 게시판 글 전체 불러와서 리스트에 담기 
      ArrayList<HashMap<String, Object>> freeboardList = eventService.getEventFreeboardList(searchNo);
      //jsp에 보내야 하기 때문에 request에 담아서 보낼 거라서 model을 써준다.응응      
      model.addAttribute("freeboardList", freeboardList);
      model.addAttribute("num", searchNo);
      
      return "event/eventPage";
   }
   
   //이벤트 글 작성 페이지-주빈
   @RequestMapping("eventWritePage.do")
   public String eventWritePage(Model model, @RequestParam(defaultValue="1") int searchNo) {
         
      model.addAttribute("num", searchNo);
      
      return "event/eventWritePage";
   }
   
   //이벤트 글작성 프로세스-주빈
   @RequestMapping("eventWriteProcess.do")
   public String eventWriteProcess(EventVO eventVO, MultipartFile [] upload_files, HttpSession session) {
      
      //***파일 업로드 어려워****
      //multifile 업로드시 파일 다중선택 가능
      //이미지 여러개 업로드 가능해서 (같은 타입 여러개)ArrayList에 담을 거라서 어레이리스트 선언해준다.
      ArrayList<EventImageVO> eventImageVOList = new ArrayList<EventImageVO>();
      
      //***파일 업로드 어렵다 나중에 쓸게***
      //파일 업로드
      //업로드 파일이 있을 때,
      if(upload_files != null) {
         //upload_files가 끝날 때까지 upload_file 반복해준다,
         for(MultipartFile upload_file : upload_files) {
            //upload_file이 비었을 때, continue한다. 빠져나간다?? 그만돌고?? 그만반복하고??
            if(upload_file.isEmpty()) {
               continue;
            }
                  
            String oriFileName = upload_file.getOriginalFilename();
            //중복 배제 위해서 파일명 바꿔서 업로드, 랜덤+(밀리세컨드단위)시간+확장자
            long currentTime = System.currentTimeMillis();
            UUID uuid = UUID.randomUUID();
            String uuidName = uuid.toString();
            //확장자/oriFileName.뒤에,마지막 인덱스 "."뒤에 확장자로 지정
            String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
                  
            String randomFileName = uuidName + "_" + currentTime + ext;
                  
            //날짜별 폴더 자동 생성
            Date date = new Date();
            //날짜가 이상한 숫자(??)로 나와서 우리가 아는 형식으로 바꿔주고, 폴더로 경로 만들기 위해서 슬래시로 표시해줌.
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); 
            String newFolderName = sdf.format(date);
                  
            String uploadFolderName = "c:/upload_files/" + newFolderName;
                  
            File folder = new File(uploadFolderName);
            //날짜 경로(?)에 폴더가 없으면 새로 만들기!!      
            if(!folder.exists()) {
               folder.mkdirs();
            }
                  
            String eventImageFileLocation = uploadFolderName + "/" + randomFileName;
            //업로드 파일 보내질 경로가 eventImageFileLocation임      
            try {
               upload_file.transferTo(new File(eventImageFileLocation)); 
            }catch(Exception e) {
               e.printStackTrace();
            }
            
            //eventImageVO 빈 것 만들어서 담아주기.      
            EventImageVO eventImageVO = new EventImageVO();
            //eventImageVO에 Image_location이랑 Image_original_filename 세팅.      
            eventImageVO.setImage_location(newFolderName + "/" + randomFileName);
            eventImageVO.setImage_original_filename(oriFileName);
            //eventImageVO를 위에서 만든(?) 어레이 리스트에 담아주기.      
            eventImageVOList.add(eventImageVO);
                  
         }
      }
      //세션유저 불러와서 멤버VO에 담기
      MemberVO sessionUser = (MemberVO) session.getAttribute("sessionUser");
      //세션유저가 로그인 했을 때!
      if(sessionUser != null) {
         //로그인한 회원의 멤버No를 가져오기
         int sessionNo = sessionUser.getMember_no();
         //eventVO에 멤버No 세팅.
         eventVO.setMember_no(sessionNo);
         //이벤트게시판 업로드하기 eventService에서 불러오기      
         eventService.writeContent(eventVO, eventImageVOList);
      }else {//로그인하지 않았을 때는 로그인페이지로 리다이렉트하기
         return "redirect:../member/loginPage.do";
      }
      //로그인 상태일 때 업로드 후에 이벤트메인페이지로 리다이렉트하기
      return "redirect:./eventPage.do";
   }
   
   
   
   //이벤트 글 읽기 페이지-주빈
   @RequestMapping("readNewsPage.do")
   public String readNewsPage(int event_freeboard_no, Model model, HttpSession session,@RequestParam(defaultValue="1") int searchNo) {
      
      int num = 1;
      MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");//<--service에 sessionUser의 MemberNo넘겨주려고 만듦.
      if(memberVO != null) {//멤버VO가 null이 아닐 때, 로그인 했을 때,
         int sessionNo = memberVO.getMember_no();//멤버VO에서 멤버No불러오기
         //이벤트 좋아요 자기가 눌렀는지 확인하는 것-주빈
         int count = eventService.getMyRecommendCount(sessionNo, event_freeboard_no);

            //회원별 자기가 누른 좋아요 카운트를 int count에 담고
            //jsp에 출력해야 하기 때문에 request로 받기 위해서 다시 model에 담기.
         model.addAttribute("countMyFavorite", count);
         
         //이벤트 찜하기 자기가 눌렀는지 확인-주빈
            //위에 쓴 좋아요랑 마찬가지로 위시리스트도 int countMyWishlist에 담고
            //다시 model에 담기(jsp 출력하려고~!)
         int countMyWishlist = eventService.getMyWishlistCount(sessionNo, event_freeboard_no);
         model.addAttribute("countMyWishlist", countMyWishlist);
      }   
      
      //이벤트 게시글 조회수 업데이트-주빈   
      eventService.increaseEventReadCount(event_freeboard_no);
      
      //관리자가 승인한 축제글(1개씩) 불러오기(읽기 페이지)-주빈
      HashMap<String, Object> list = eventService.selectEventByApp(event_freeboard_no, true); 
      //이미지파일 -주빈 
      ArrayList<EventImageVO> image = eventService.imageList(event_freeboard_no);//여러개 올릴 수도 있어서 리스트임
         //model에 담자~!!jsp에 출력해야 하니까~~
      model.addAttribute("list", list);
      model.addAttribute("imageList", image);
      model.addAttribute("num",searchNo);
      
      return "event/readNewsPage";
   }
   
   //이벤트 글 수정 -주빈
   @RequestMapping("updateEventPage.do")
   public String updateEventPage(Model model, @RequestParam(defaultValue="0") int event_freeboard_no, @RequestParam(defaultValue="1") int searchNo) { //int값은 null로 안 넘어가서 디폴트값 지정해줌?
      //수정할 건데, 일단 썼던 거 그대로 불러와야 하니까, 쓴 내용을 다시 불러옴! 입력해둔 축제글 불러오기!->모델에 담기!      
      HashMap<String, Object> map = eventService.selectEventByApp(event_freeboard_no, false);
      model.addAttribute("data", map);
      model.addAttribute("num", searchNo);
            
      return "event/updateEventPage";
   }
   
   //이벤트 글 수정 프로세스-주빈
   @RequestMapping("updateEventProcess.do")
   public String updateEventProcess(EventVO eventVO, MultipartFile []upload_files) {
      //수정하면서 이미지파일도 새로 바꿔서 올릴 수 있기 때문에 위에 이미지 파일업로드 과정이랑 동일한 과정 반복,,
      ArrayList<EventImageVO> eventImageVOList = new ArrayList<EventImageVO>();
      
      //파일 업로드
            if(upload_files != null) {
               System.out.println("1111");
               for(MultipartFile upload_file : upload_files) {
                  System.out.println("2222");
                  if(upload_file.isEmpty()) {
                     System.out.println("3333");
                     continue;
                  }
                        
                  String oriFileName = upload_file.getOriginalFilename();
                  //중복 배제 위해서 파일명 바꿔서 업로드, 랜덤+(밀리세컨드단위)시간+확장자
                  long currentTime = System.currentTimeMillis();
                  UUID uuid = UUID.randomUUID();
                  String uuidName = uuid.toString();
                  String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
                        
                  String randomFileName = uuidName + "_" + currentTime + ext;
                        
                  //날짜별 폴더 자동 생성
                  Date date = new Date();
                  SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); 
                  String newFolderName = sdf.format(date);
                        
                  String uploadFolderName = "c:/upload_files/" + newFolderName;
                        
                  File folder = new File(uploadFolderName);
                        
                  if(!folder.exists()) {
                     folder.mkdirs();
                  }
                        
                  String eventImageFileLocation = uploadFolderName + "/" + randomFileName;
                        
                  try {
                     upload_file.transferTo(new File(eventImageFileLocation)); 
                  }catch(Exception e) {
                     e.printStackTrace();
                  }
                        
                  EventImageVO eventImageVO = new EventImageVO();
                        
                  eventImageVO.setImage_location(newFolderName + "/" + randomFileName);
                  eventImageVO.setImage_original_filename(oriFileName);
                        
                  eventImageVOList.add(eventImageVO);
                        
               }
            }
            eventService.updateEvent(eventVO, eventImageVOList);
            
      //등록되면 이벤트 메인 페이지 리다이렉트
      return "redirect:./eventPage.do";
   }
   
   //이벤트 좋아요 -주빈
   @RequestMapping("insertFavorite.do")
   public String insertFavorite(EventRecommendVO recommendVO) {
       
      eventService.Recommend(recommendVO);
      //읽기 페이지 + 프리보드No로 리다이렉트하기 (게시글 당 각각 좋아요가 있기 때문에~)
      return "redirect:./readNewsPage.do?event_freeboard_no=" + recommendVO.getEvent_freeboard_no();
   }
   
   //이벤트 좋아요 해제-주빈
   @RequestMapping("deleteFavorite.do")
   public String deleteFavorite(EventRecommendVO recommendVO) {
      
      eventService.deleteRecommend(recommendVO);
      //얘도 똑같이 읽기페이지로 리다이렉트~
      return "redirect:./readNewsPage.do?event_freeboard_no=" + recommendVO.getEvent_freeboard_no();
   }
   
   //이벤트 위시리스트(찜-마이페이지에도 저장됨)-주빈
   @RequestMapping("insertWishlist.do")
   public String insertWishlist(EventWishlistVO wishlistVO) {
      
      eventService.insertWishlist(wishlistVO);
      //읽기 페이지 리다이렉트 되고 찜표시 마이페이지에도 같이 저장됨~ wishlistVO에담아서 불러오기.
      return "redirect:./readNewsPage.do?event_freeboard_no=" + wishlistVO.getEvent_freeboard_no();
   }
   
   //이벤트 위시리스트(찜-마이페이지에서도 해제가능)-주빈
   /*
    * @RequestMapping("deleteWishlist.do") public String
    * deleteWishlist(EventWishlistVO wishlistVO) {
    * 
    * eventService.deleteWishlist(wishlistVO); //읽기 페이지 리다이렉트~ return
    * "redirect:./readNewsPage.do?event_freeboard_no=" +
    * wishlistVO.getEvent_freeboard_no(); }
    */
   
   
   
}