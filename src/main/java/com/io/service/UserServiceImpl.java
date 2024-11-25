package com.io.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.io.mapper.UserMapper;
import com.io.model.UserDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper mapper;

	@Override
	public int join(UserDTO user) {
		log.info("가입: " + user.getUemail());
		return mapper.join(user);
	}

	@Override
	public void remove(String uemail) {
		log.info("delete email" + uemail);
		mapper.deleteUser(uemail);
	}

	@Override
	public int updateUser(UserDTO user) {
		log.info("정보 수정: " + user.getUemail());
		return mapper.updateUser(user);
	}

	@Override
	public UserDTO getUserByEmail(String uemail) {
		return mapper.selectUser(uemail);
	}
	
}
