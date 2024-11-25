package com.io.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.io.model.TboardDTO;
import com.io.service.BoardService;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
@Configuration
@EnableScheduling
public class PermitBoardInsertTask {

	@Autowired
	BoardService bs;
	
	
	@Scheduled(cron = "30 * * * * *")
	@Transactional
	public void permitCheckAndComplete() {
	    log.info("스케줄 실행");

	    TboardDTO dto = new TboardDTO();
	    dto.setCode("permit");

	    try {
	        // 첫 번째 작업 실행
	        bs.listPutBoard(dto);
	       
	        log.info("첫 번째 작업 완료");

	        // 두 번째 작업 실행 (50초 후)
	        Thread.sleep(20000); // 20초 대기
	        log.info("완료로 스케줄링");
	        bs.permitCodeChangeComplete();
	        // 두 번째 작업 로직 추가
	        // bs.permitCodeToComplete(); // 예시로 추가

	    } catch (Exception e) {
	        log.info("스케줄할 대상이 없음");
	    }
	}

}
