package com.io.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.io.model.BoardDTO;
import com.io.model.Criteria;
import com.io.model.TboardDTO;
import com.io.service.BoardService;
import com.io.service.TboardService;
import com.io.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {

	@Autowired
	BoardService bs;

	@Autowired
	TboardService tbs;

	@Autowired
	UserService us;

	@GetMapping("/index")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public void index(Model model) {
		//기사들 갯수
		List<Map<String, Object>> codeCounts =bs.getsCountOfCode();
		Map<String, String> tboardCount = new HashMap<>();

		for (Map<String, Object> codeCount : codeCounts) {
			tboardCount.put((String) codeCount.get("code"), String.valueOf(codeCount.get("count")));
		}

		model.addAttribute("tboardCount", tboardCount);

		log.info("tcount code value : " + tboardCount);

		log.info("userlist log" + bs.listUserListOfPost());

		model.addAttribute("userList", bs.listUserListOfPost());
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
		authorities.forEach(authority -> {
		    log.info("auth check " + authority.getAuthority());
		});



	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/newsList")
	public void getCodeViewList(@RequestParam(value = "code", required = false) String code,Criteria criteria,
			Model model) {

		TboardDTO dto = new TboardDTO();
		dto.setCode(code);

		// 페이징 처리를 위한 로직 추가
		int totalItems = bs.listGetTBoard(dto).size(); // 전체 항목 수를 가져오는 메서드
		int totalPages = (int) Math.ceil((double) totalItems / criteria.getAmount());

		List<TboardDTO> tboardList = bs.listGetTBoardOfPaging(dto,criteria); // 페이징 처리된 리스트를 가져오는 메서드

		log.info("tboardList Row" + tboardList);
		model.addAttribute("tboardList", tboardList);
		model.addAttribute("currentPage", criteria.getPageNum());
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("code", code);

		log.info("boardList: " + tboardList);

		switch (code) {
		case "complete":
			model.addAttribute("code", "complete");
			break;
		case "permit":
			model.addAttribute("code", "permit");
			break;
		case "ready":
			model.addAttribute("code", "ready");
			break;
		case "reject":
			model.addAttribute("code", "reject");
			break;
		default:
			break;
		}
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value="/updateData", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void updateData(@RequestParam("tno") Long tno, @RequestParam("code") String code) {
	    log.info("tno value " + tno);
	    log.info("code value " + code);
	    TboardDTO dto = new TboardDTO();
	    dto.setTno(tno);
	    dto.setCode(code);

	    tbs.changeCode(dto);
	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/userList")
	public void getUserListPage(Model model) {
		log.info("userList");
		model.addAttribute("userList", bs.listUserListOfPost());
	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping(value="/deleteUser",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void userDelete(@RequestParam String email, @RequestParam String reason) {

		us.remove(email);
	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/category")
	public void getCatePage(Model model) {
		model.addAttribute("cate", bs.selectCateAll());
		
	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value="/saveCategory",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void getCatePage(Model model, String caid,String category) {
		log.info("test value" + caid + ", caid" + category);
		BoardDTO dto = new BoardDTO();
		dto.setCaid(caid);
		dto.setCategory(category);
		
		bs.putCategory(dto);
		
		
	}
	
	




}
