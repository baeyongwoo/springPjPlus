package com.io.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor  // 모든 필드를 parameter로 갖는 생성자를 구현해줌
public class ReplyPageDTO {
	private int replyCnt; //댓글갯수
	private List<ReplyVO> list; //댓글목록
}
