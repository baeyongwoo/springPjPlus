package com.io.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.io.model.BoardAttachVO;
import com.io.model.BoardDTO;
import com.io.model.Criteria;
import com.io.model.TboardDTO;
import com.io.service.BoardService;
import com.io.service.TboardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class BoardController {

	private BoardService bs;
	private TboardService ts;

	@GetMapping("/list")
	public String list(HttpSession session, Model model) {
		String logoutMessage = (String) session.getAttribute("logoutMessage");
		if (logoutMessage != null) {
			model.addAttribute("logoutMessage", logoutMessage);
			session.removeAttribute("logoutMessage");
			session.removeAttribute("username");
		}

		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("loggedIn", session.getAttribute("username") != null); // 세션 상태 추가
		Map<String, List<BoardDTO>> boardMap = bs.listGetBoard();
		log.info("boardMap" + boardMap.get("최신순"));
		model.addAttribute("latestList", boardMap.get("최신순"));
		model.addAttribute("latestListName", "최신순");

		model.addAttribute("boardMap", boardMap);

		log.info("cateList" + bs.selectCateAll());
		model.addAttribute("cateList", bs.selectCateAll());
		return "board/list";
	}
	
	@GetMapping("/list/{caid}")
	public String lists(Model model, @PathVariable String caid, HttpSession session, Criteria criteria) {
		String logoutMessage = (String) session.getAttribute("logoutMessage");
		if (logoutMessage != null) {
			model.addAttribute("logoutMessage", logoutMessage);
			session.removeAttribute("logoutMessage");
			session.removeAttribute("username");
		}

		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("loggedIn", session.getAttribute("username") != null); // 세션 상태 추가

		BoardDTO dto = new BoardDTO();

		if (caid.equals("all")) {
			dto.setCaid(null);

		} else {
			dto.setCaid(caid);
		}

		// 페이징 처리를 위한 로직 추가
		int totalItems = bs.selectAllBoardOfCaid(dto).size(); // 전체 항목 수를 가져오는 메서드
		int totalPages = (int) Math.ceil((double) totalItems / criteria.getAmount());

		// 페이징 처리된 리스트를 가져오는 메서드

		model.addAttribute("boardList", bs.listGetBoardOfPaging(dto, criteria));
		model.addAttribute("currentPage", criteria.getPageNum());
		model.addAttribute("totalPages", totalPages);

		model.addAttribute("caid", caid);

		log.info("dto value + " + dto);
		log.info("해당 list 값들" + bs.selectAllBoardOfCaid(dto));

		// model.addAttribute("boardList", bs.selectAllBoardOfCaid(dto));
		model.addAttribute("cateList", bs.selectCateAll());

		return "/board/listView";

	}

	@GetMapping("/read")
	public void readBoard(@RequestParam("bno") long bno, Model model, HttpSession session) {
		// 게시글 정보를 조회
		BoardDTO boardDTO = bs.readBoard(bno);
		log.info("기사정보조회");
		model.addAttribute("board", boardDTO);
		String logoutMessage = (String) session.getAttribute("logoutMessage");
		if (logoutMessage != null) {
			model.addAttribute("logoutMessage", logoutMessage);
			session.removeAttribute("logoutMessage");
			session.removeAttribute("username");
		}
		model.addAttribute("caid", boardDTO.getCaid());
		model.addAttribute("cateList", bs.selectCateAll());
		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("loggedIn", session.getAttribute("username") != null); // 세션 상태 추가

	}
	
	// 이용자 글작성
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/post")
	public void postForm(Model model, HttpSession session) {
		String logoutMessage = (String) session.getAttribute("logoutMessage");
		if (logoutMessage != null) {
			model.addAttribute("logoutMessage", logoutMessage);
			session.removeAttribute("logoutMessage");
			session.removeAttribute("username");
		}

		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("loggedIn", session.getAttribute("username") != null); // 세션 상태 추가

		log.info("기사작성폼실행");
		model.addAttribute("cateList", bs.selectCateAll());
		
		// 게시글 작성 폼
	}

	// 로그인 구현시 풀기
	/*
	 * @PostMapping("/post") public String post(@ModelAttribute TboardDTO TDTO,
	 * HttpSession session) { // 로그인 세션에서 사용자 이메일을 가져옵니다 String uemail = (String)
	 * session.getAttribute("userEmail");
	 * 
	 * if (uemail == null) { // 로그인 상태가 아니면 로그인 페이지로 리다이렉트 return
	 * "redirect:/user/login"; }
	 * 
	 * // TboardDTO에 이메일을 설정 TDTO.setUemail(uemail);
	 * 
	 * int postResult = ts.postTboard(TDTO); if (postResult > 0) { return
	 * "redirect:/board/list"; } else { return "redirect:/board/post"; } }
	 */
	@PostMapping("/post")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	public String post(TboardDTO TboardDTO, HttpSession session, RedirectAttributes rttr) {
		log.info(" post 접근");
		// 임시 로그인 상태 설정

		String uemail = (String) session.getAttribute("username");
		TboardDTO.setUemail(uemail);
		ts.post(TboardDTO);
		rttr.addFlashAttribute("result", TboardDTO.getTno());
		
		return "redirect:/board/list";

	}

	// 게시글 수정 폼
	@GetMapping("/edit/{tno}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	public String edit(@PathVariable Long tno, Model model, HttpSession session) {
		String logoutMessage = (String) session.getAttribute("logoutMessage");
		if (logoutMessage != null) {
			model.addAttribute("logoutMessage", logoutMessage);
			session.removeAttribute("logoutMessage");
			session.removeAttribute("username");
		}

		model.addAttribute("username", session.getAttribute("username"));
		model.addAttribute("loggedIn", session.getAttribute("username") != null); // 세션 상태 추가

		log.info("기존 게시글 " + tno + " 수정");
		TboardDTO tboardDTO = ts.getTboard(tno);

		// 게시글 정보
		model.addAttribute("tboard", tboardDTO);

		// 카테고리 목록을 추가로 가져오기 (필요한 경우)
		model.addAttribute("cateList", bs.selectCateAll());
		
		log.info("기사수정페이지");
		return "/board/edit";
	}

	// 게시글 수정 처리
	@PostMapping("/edit")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	public String editTboard(@ModelAttribute TboardDTO tboardDTO, RedirectAttributes rttr) {
		log.info("수정 처리중 " + tboardDTO);

		
		int result= ts.updateTboard(tboardDTO);
		if(result==1) {
			rttr.addFlashAttribute("result", "success");
		}
		log.info("수정 완료 " + tboardDTO);
		return "redirect:/board/list";
	}

	// 게시글 삭제
	@PostMapping("/delete")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
    public String deleteTboard(@RequestParam("bno") Long bno, HttpSession session,RedirectAttributes rttr) {
        log.info("삭제 요청된 게시글 ID: " + bno);

        try {
            // 게시글 삭제 처리
            ts.deleteTboard(bno);
         // 첨부파일목록
    		List<BoardAttachVO> attachList = ts.getAttachList(bno);
    		
    			// 첨부파일삭제
    			deleteFiles(attachList);
    			rttr.addFlashAttribute("result", "success");
            // 성공적으로 삭제된 경우
            log.info("게시글 삭제 완료: " + bno);
        } catch (Exception e) {
            // 삭제 작업 중 오류 발생 시 로깅 및 예외 처리
            log.error("게시글 삭제 실패: " + bno, e);
            // 사용자에게 오류 메시지를 전달하거나, 에러 페이지로 리다이렉트할 수 있음
            return "redirect:/board/error"; // 또는 에러 처리 페이지로 리다이렉트
        }
        
        return "redirect:/board/list";
    }
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		// 첨부파일이 없으면 중지
		if (attachList == null || attachList.size() == 0) {

			return;
		}

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);// 원본파일삭제
				// 이미지이면
				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());
					Files.delete(thumbNail);// 썸네일삭제
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		});
	}

	// 첨부파일목록
	
		@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<List<com.io.model.BoardAttachVO>> getAttachList(Long tno) {
			return new ResponseEntity<>(bs.getAttachList(tno), HttpStatus.OK);
		}
}
