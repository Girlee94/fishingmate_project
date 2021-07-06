package com.ej.fishingmate.manager.controller;

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
import com.ej.fishingmate.manager.service.ManagerServiceImpl;
import com.ej.fishingmate.vo.EventImageVO;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.ManagerVO;

@Controller
@RequestMapping("/manager/*")
public class ManagerController {
   
   @Autowired
   private ManagerServiceImpl managerService;
   @Autowired
   private EventServiceImpl eventService;
   
   
   //관리자용 메인페이지-주빈
   @RequestMapping("managerIndexPage.do")
   public String managerIndexPage() {
      
      return "manager/managerIndexPage";
   }
   
   //관리자 등록 페이지-주빈
   @RequestMapping("joinManagerPage.do")
   public String joinManagerPage() {
      
      return "manager/joinManagerPage";
   }
   
   //관리자 등록-주빈
   @RequestMapping("joinManagerProcess.do")
   public String joinManagerProcess(ManagerVO managerVO) {
      //매니저 서비스에서 매니저VO갖고 있는 관리자등록 불러오기
      managerService.insertmanager(managerVO);
      
      //등록 성공하면 joinManagerSuccess페이지 출력
      return "manager/joinManagerSuccess";
   }
   
   //관리자 로그아웃-주빈
   @RequestMapping("logoutProcess.do")
   public String logoutProcess(HttpSession session) {
      session.invalidate();
      
      return "manager/managerIndexPage"; 
      
   }
   
   //관리자 등록 성공확인 페이지-주빈
   @RequestMapping("joinManagerSuccess.do")
   public String joinManagerSuccess() {
      return "manager/joinManagerSuccess";
   }
   
   //관리자 로그인 페이지-주빈
   @RequestMapping("managerLoginPage.do")
   public String managerLoginPage() {
                
      return "manager/managerLoginPage";
   }
   
   //관리자 로그인-주빈
   @RequestMapping("managerLoginProcess.do")
   public String managerLoginProcess(ManagerVO managerVO, HttpSession session) {
      //매니저서비스에서 매니저VO가 담긴 관리자로그인을 불러와서 ManagerVO에 담고 sessionAdmin 변수를 지정해준다
      ManagerVO sessionAdmin = managerService.managerLogin(managerVO);
      System.out.println("123");
      //세션어드민이 null이 아닐 때, 그러니까 관리자가 로그인을 했을 때!로그인 성공시!
      if(sessionAdmin != null) {
         //세션에 sessionAdmin 설정해주고?
         session.setAttribute("sessionAdmin", sessionAdmin);
         //관리자사이트 인덱스페이지 리다이렉트해준다~
         return "redirect:./managerEventList.do";
      //관리자가 로그인이 아닐 때, 로그인 실패시!
      }else {
         //매니저 로그인실패 페이지 리턴한다~
         return "manager/managerLoginFail";
      }
   }
      
   //관리자 로그인 실패 페이지-주빈
   @RequestMapping("managerLoginFail.do")
   public String LoginFail() {
      
      return "manager/managerLoginFail";
   }
            
   //관리자 이벤트 페이지(리스트출력)-주빈
   @RequestMapping("managerEventList.do")
   public String managerEventList(Model model, @RequestParam(defaultValue="1") int searchNo) {
      //이벤트서비스에서 이벤트게시판 전체불러오기를 불러와서 ArrayList<HashMap<K,v>>에 담아준다
      ArrayList<HashMap<String, Object>> freeboardList = eventService.getEventFreeboardList(searchNo);
      //jsp에 출력해야 하니까 model에 위에 꺼를 다시 담는다~
      model.addAttribute("freeboardList", freeboardList);
      //매니저이벤트페이지를 리턴한다~ 리스트 출력~
      model.addAttribute("num", searchNo);
      return "manager/managerEventList";
   }
   
   //관리자페이지 축제게시글 읽기페이지 -주빈 **
   @RequestMapping("managerReadPage.do")
   public String managerReadpage(Model model, @RequestParam(defaultValue="0") int event_freeboard_no, @RequestParam(defaultValue="1") int searchNo) {
      //관리자 승인이 되었는지 아닌지 판단-주빈
      String AdminApp = managerService.getAdminApprove(event_freeboard_no);
      
      //매니저서비스에서 관리자 축제게시글 읽기를 불러와서 해시맵에 담는다~
      HashMap<String, Object> map = managerService.getEventFreeboardContent(event_freeboard_no);
      //이거를 다시 모델에 담는다~ 왜냐면 jsp에 출력할 거니까~ request->model^_^
      model.addAttribute("list", map);
      
      model.addAttribute("AdminApp", AdminApp);
      model.addAttribute("num", searchNo);
      //그리고 매니저리드페이지 리턴~
      return "manager/managerReadPage";
   }
   
   //관리자페이지 축제게시글 수정페이지 -주빈
   @RequestMapping("managerUpdatePage.do")
   public String managerUpdatePage(Model model, @RequestParam(defaultValue="0") int event_freeboard_no) {
      //매니저서비스에서 관리자 축제게시글 읽기를 불러와서 해시맵에 담는다~(이거를 왜 또 불러오냐면 수정하려면 일단 원본이 필요하니까~!)
      HashMap<String, Object> map = managerService.getEventFreeboardContent(event_freeboard_no);
      //모델에 담는 거까지는 같은데 키값 다르게~ 얘는 수정할 것임!
      model.addAttribute("data", map);
      //매니저 업데이트 페이지 리턴~
      return "manager/managerUpdatePage";
   }
   
   //관리자페이지 축제게시글 수정하기 프로세스- 주빈
   @RequestMapping("managerUpdateProcess.do")
   public String managerUpdateProcess(EventVO eventVO, MultipartFile []upload_files) { 
      //**파일업로드는 이벤트랑 동일~~~^_^//
      
      //multifile 업로드시 파일 다중선택 가능
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
      
      managerService.updateEvent(eventVO, eventImageVOList);
      return "redirect:./managerReadPage.do?event_freeboard_no="+eventVO.getEvent_freeboard_no();
   }
   
   
   //관리자페이지 축제게시글 승인하기 -주빈
   @RequestMapping("managerEventApprove.do")
   public String managerEventApprove(@RequestParam(defaultValue="0") int event_freeboard_no, HttpSession session, EventVO eventVO) {
      //세션에서 sessionAdmin을 받아와서?? 매니저VO에 담는다
      ManagerVO managerVO = (ManagerVO)session.getAttribute("sessionAdmin");
      //매니저VO가 null이 아닐 때, 그러니까 세션어드민이 널이 아니고, 로그인을 한 상태일 때!+아직 관리자 승인 처리 전일 때,
      if(managerVO != null && eventVO.getEvent_freeboard_approve().equals("N")) {
         //매니저 서비스에서 관리자 축제글 승인을 불러오기 한다
         managerService.updateApproveY(event_freeboard_no);
         //그리고 관리자 이벤트리스트를 리다이렉트!
         return "redirect:./managerEventList.do";
         //매니저VO가 null이 아닐 때, 그러니까 세션어드민이 널이 아니고, 로그인을 한 상태일 때!+관리자 승인 된 글일 때,
      }else if(managerVO != null && eventVO.getEvent_freeboard_approve().equals("Y")){
         //매니저 서비스에서 관리자 축제글 승인을 불러오기 한다
         managerService.updateApproveN(event_freeboard_no);
         //관리자 이벤트리스트를 리다이렉트 한다.
         return "redirect:./managerEventList.do";
      //매니저VO가 널값일 때, =세션어드민이 널값이고, 관리자 로그인이 아닐 때!
      }else {
         //매니저로그인 페이지를 리다이렉트 한다!
         return "redirect:./managerLoginPage.do";
      }
   }
   
   
   
   
   
   
}

