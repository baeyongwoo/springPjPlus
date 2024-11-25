package com.io.service;

import java.util.List;

import com.io.model.BoardAttachVO;
import com.io.model.TboardDTO;

public interface TboardService {
	public void changeCode(TboardDTO dto);

	// 기사 작성
	public void post(TboardDTO tboardDTO);

	// 게시글 수정 (제목과 내용만 업데이트)
	int updateTboard(TboardDTO tboard);

	// 게시글 삭제
	void deleteTboard(Long tno);

	// 게시글 상태를 'ready'로 변경
	void updateTboardToReady(Long tno);

	// 특정 게시글 조회
	TboardDTO getTboard(Long tno);

	// 첨부파일목록
	public List<BoardAttachVO> getAttachList(Long tno);
}
