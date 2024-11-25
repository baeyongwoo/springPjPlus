package com.io.mapper;

import java.util.List;

import com.io.model.BoardAttachVO;

public interface BoardAttachMapper {
	// 등록
	public void insert(BoardAttachVO vo);

	// 목록
	public List<BoardAttachVO> findByTno(Long tno);

	// 첨부파일목록 모두삭제
	public void deleteAll(Long tno);

	// 어제날짜 첨부파일목록
	public List<BoardAttachVO> getOldFiles();

	
}
