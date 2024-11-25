package com.io.model;

import java.sql.Clob;
import java.sql.Timestamp;
import java.util.List;


import lombok.Data;

@Data
public class TboardDTO {
	private Long tno;
	private String tmptitle;
	private String tmpcontent;
	private Timestamp tmpregdate;
	
	private String uemail;
	private String uname;
	private String caid;
	private String code;
	private String category;
	
	private List<BoardAttachVO> attachList;
	
}
