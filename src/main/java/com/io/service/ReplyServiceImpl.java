package com.io.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.io.mapper.ReplyMapper;
import com.io.model.Criteria;
import com.io.model.ReplyPageDTO;
import com.io.model.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	private ReplyMapper mapper; //자동주입. 생성자의존성주입
	
//	private BoardMapper boardMapper; //자동주입. 생성자의존성주입

	@Transactional  // Transaction처리
	@Override
	public int register(ReplyVO vo) {
//		//댓글갯수 1증가
//		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri,bno));
	}

	@Override
	public ReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}

	@Override
	public int edit(ReplyVO vo) {
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int delete(Long rno) {
		
		ReplyVO vo=mapper.read(rno); // 부모글번호 bno가 필요해서 실행
		
//		//댓글갯수를 1감소
//		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}
	
	
}
