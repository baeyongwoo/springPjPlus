package com.io.model;

import java.util.List;


import lombok.Data;

@Data
public class UserDTO {
	private String uemail;
	private String upwd;
	private String uname;
	private String did;
	private String dname;
	private List<AuthVO> authList;
}
