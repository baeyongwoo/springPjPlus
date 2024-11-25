package com.io.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.io.model.BoardDTO;
import com.io.model.Criteria;
import com.io.model.DeptDTO;
import com.io.model.TboardDTO;

public interface BoardMapper {
	public List<BoardDTO> selectAllBoard(BoardDTO dto);

	// 기사상세페이지
	public BoardDTO readBoard(long bno);
	// 게시글 삭제
    void deleteBoard(Long bno);

	// 스케줄위한 메서드
	public List<TboardDTO> selectAllTempBoard(TboardDTO tdto);
	
	public List<TboardDTO> selectAllTempBoardOfPaging(@Param("dto") TboardDTO dto, @Param("cri") Criteria cri);
	
	public List<BoardDTO> selectAllBoardOfPaging(@Param("dto") BoardDTO dto, @Param("cri") Criteria cri);

	public void insertBoards(@Param("list") List<TboardDTO> tdto);

	public void updateBoardCode(TboardDTO tdto);

	public void updatePermitToComplete();
	// 스케줄 관련 메서드 끝

	// adminPage
	public List<Map<String, Object>> selectCodeCount();

	// UserMapper로 옮길것
	public List<BoardDTO> selectUserList();

	public List<BoardDTO> selectCateAll();

	public List<BoardDTO> selectAllBoardOfCaid(BoardDTO dto);
	
	public void insertCategory(BoardDTO dto);
	
	public List<DeptDTO> selectDept();
}
