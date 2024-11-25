package com.io.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.io.mapper.BoardAttachMapper;
import com.io.mapper.BoardMapper;
import com.io.mapper.TboardMapper;
import com.io.model.BoardAttachVO;
import com.io.model.BoardDTO;
import com.io.model.TboardDTO;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ToardServiceImpl implements TboardService {

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private TboardMapper tm;

	@Override
	public void changeCode(TboardDTO dto) {
		tm.updateCode(dto);

		if (dto.getCode().equals("reject")) {

		}

	}@Transactional
	@Override
	public void post(TboardDTO tboardDTO) {
		log.info("post transactional" + tboardDTO);
		// 부모글 등록
		tm.postTboard(tboardDTO);

		log.info(tboardDTO.getAttachList() + "-------------------------------------------");
		// 첨부파일이 없으면 중지
		if (tboardDTO.getAttachList() == null || tboardDTO.getAttachList().size() <= 0) {
			log.info("첨부파일없음");

			return;
		}
		tboardDTO.getAttachList().forEach(attach -> {
			attach.setTno(tboardDTO.getTno());// 부모글번호저장
			log.info("post transactional" + tboardDTO);
			attachMapper.insert(attach); // 첨부파일등록
		});
	}

	@Transactional
	@Override
	public int updateTboard(TboardDTO tboardDTO) {
		int upadteResult=tm.editTboard(tboardDTO);

		log.info("수정");

		// 첨부파일 삭제
		attachMapper.deleteAll(tboardDTO.getTno());

		// 새 첨부파일 추가
		if (tboardDTO.getAttachList() != null && !tboardDTO.getAttachList().isEmpty()) {
			tboardDTO.getAttachList().forEach(attach -> {
				attach.setTno(tboardDTO.getTno());
				attachMapper.insert(attach);
			});
		}
		
		return upadteResult;

	}

	@Transactional
	@Override
	public void deleteTboard(Long tno) {
		attachMapper.deleteAll(tno);
		tm.deleteTboard(tno);
	}

	@Override
	public void updateTboardToReady(Long tno) {
		// Ensure this method exists in your TboardMapper if used
		tm.updateTboardToReady(tno);
	}

	@Override
	public TboardDTO getTboard(Long tno) {
		return tm.selectTboardById(tno);
	}

	public List<BoardAttachVO> getAttachList(Long tno) {
		return attachMapper.findByTno(tno);
	}


}
