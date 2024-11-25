package com.io.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.io.mapper.BoardMapper;
import com.io.mapper.UserMapper;
import com.io.model.UserDTO;
import com.io.service.BoardServiceImpl;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class SecurityServiceImpl implements SecurityService{

	@Autowired
	private UserMapper um;
	
	@Override
	public int insertUser(UserDTO dto) {
		try {
		
		um.join(dto);
		um.insertUserAuth(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}
		return 0;
		
	
	}
}
