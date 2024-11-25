package com.io.model;

import java.sql.Clob;
import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardDTO {
	//board
	private Long bno;
	private String title;
	private String bcontent;
	private Timestamp regdate;
	private String uemail;
	private String caid;
	private String uname;
	private String category;
	private Long tno;
	
	
	/* file */
	private String buuid;
	private String buploadpath;
	private String bfilename;
	private char bfiletype;
	
	//user
	private String dname;
	
	//postCount
	private int post_count;
	private int insert_count;
}
