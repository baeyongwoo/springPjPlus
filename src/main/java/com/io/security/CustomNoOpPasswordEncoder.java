package com.io.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {
	@Override
	public String encode(CharSequence rawPassword) {
		//여기에 비밀번호 암호화 코드 작성
		
		//더미데이터에 비밀번호가 암호화되어있지 않으므로 여기서는 암호화하지 않고 리턴
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		//사용자가 입력한 비밀번호를 암호화해서 테이블에 암호화되어 저장된 비밀번호와 비교
		
		// 더미데이터에 비밀번호가 암호화되어있지 않으므로 여기서는 그냥 같은지 비교
		return rawPassword.toString().equals(encodedPassword);
	}

	

}
