package com.io.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.io.model.Criteria;
import com.io.model.ReplyVO;

public interface ReplyMapper {
	//등록
	public int insert(ReplyVO vo);
	//댓글목록 with paging. paramter가 2개이상일 경우 @Param 사용.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	//댓글갯수
	public int getCountByBno(Long bno);
	//댓글상세보기
	public ReplyVO read(Long rno);
	//수정
	public int update(ReplyVO reply);
	//삭제
	public int delete(Long rno);
}
