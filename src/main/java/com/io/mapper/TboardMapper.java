package com.io.mapper;

import java.util.List;

import com.io.model.BoardDTO;
import com.io.model.TboardDTO;

public interface TboardMapper {

	public void updateCode(TboardDTO dto);

	// 기사작성
	public void insert(TboardDTO dto);

	// 등록 with select key
	public void postTboard(TboardDTO dto);

	// 게시글 수정 (제목과 내용만 업데이트)
	int editTboard(TboardDTO tboardDTO);

	// 게시글 삭제
	void deleteTboard(Long tno);

	// 게시글 상태를 'ready'로 변경
	void updateTboardToReady(Long tno);


	// 게시글 조회
	public TboardDTO selectTboardById(Long tno);
}
