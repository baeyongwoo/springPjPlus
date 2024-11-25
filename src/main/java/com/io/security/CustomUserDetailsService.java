package com.io.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.io.mapper.UserMapper;
import com.io.model.UserDTO;
import com.io.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private UserMapper um;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);

		// userName means userid
		UserDTO dto = um.selectUser(userName);

		log.warn("queried by member mapper: " + dto);

		return dto == null ? null : new CustomUser(dto);
	} 

}