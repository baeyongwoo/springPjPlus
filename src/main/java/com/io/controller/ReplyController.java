package com.io.controller;

import java.io.BufferedReader;
import java.io.FileReader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.io.model.Criteria;
import com.io.model.ReplyPageDTO;
import com.io.model.ReplyVO;
import com.io.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/*")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service; //자동주입.생성자의존성주입
	
	//등록
	@PostMapping(value="/new",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("555555555555555555555555555555555555555555555555555555");
		log.info("Creating reply: " + vo);
		vo.setRno(null); //새 댓글은 ID가 없음
		int insertCount=service.register(vo); //영향을 받은 행의 수 리턴
		//영향을 받은 행의 수가 1이면 정상적으로 insert된 것임.
		return insertCount==1 ? new ResponseEntity<>("success",HttpStatus.OK)
							  : new ResponseEntity<>("fail",HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	//목록 with paging
	@GetMapping(value="/pages/{bno}/{page}",produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		log.info("7777777777777777777777777777777777777777777");
		log.info("Fetching replies for board number: " + bno + " and page: " + page);
		Criteria cri=new Criteria(page,10);
		log.info("888888888888888888888888888888888888888888888888888"+service.getListPage(cri, bno));
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	//상세보기
	@GetMapping(value="/{rno}",produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("11111111111111111111111111111111111111111111");
		log.info("Fetching reply with ID: " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	//수정. put, patch 방식 모두 처리
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},
			value="/{rno}",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> update(@RequestBody ReplyVO vo,@PathVariable("rno") Long rno){
		log.info("888888888888888888888888888888888888888888888888888888888888888");
		log.info("Updating reply with ID: " + rno + " and data: " + vo);
		vo.setRno(rno); //댓글 ID 설정
		return service.edit(vo)==1 ? 	new ResponseEntity<>("success",HttpStatus.OK) : 
										new ResponseEntity<>("fail",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//삭제. delete방식
	@DeleteMapping(value="/{rno}",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
		log.info("9999999999999999999999999999999999999999999999999999999999999");
		log.info("Deleting reply with ID: " + rno);
		return service.delete(rno)==1 ? new ResponseEntity<>("success",HttpStatus.OK) :
										new ResponseEntity<>("fail",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//js파일 로딩
		@GetMapping(value="/js",produces= {MediaType.TEXT_PLAIN_VALUE})
		public String getJS(Long bno,HttpServletRequest request){
			BufferedReader reader = null;
			String script=""; 
			 try{
				   String filePath = request.getRealPath("/resources/js/board/reply.js"); 
				   reader = new BufferedReader(new FileReader(filePath));
				   //out.print("<script>\n");
				   script+="var bnoValue='"+bno+"'\n;";
				   while(true){
					   String str = reader.readLine();  
					   if(str==null)
					   	break;
					   
					   script+=str+"\n";  
				   }
				   //out.print("</script>");
			 }catch(Exception e){
				 e.printStackTrace();
			  	
			 }finally {
				  try 
				  {
				   reader.close();    
				  }
				  catch(Exception e){
					  e.printStackTrace();
				  }
			 }
			
			return script;
		}
}
