package com.io.mapper;


import com.io.model.UserDTO;

public interface UserMapper {
	public int join(UserDTO user); 
	
	public void insertUserAuth(UserDTO dto);
	
	public void deleteUser(String uemail);

	public UserDTO selectUser(String uemail);
	
	public int updateUser(UserDTO user);




}
