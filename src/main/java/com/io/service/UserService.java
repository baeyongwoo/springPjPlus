package com.io.service;

import com.io.model.UserDTO;

public interface UserService {

    // 가입
    int join(UserDTO user);

    // 탈퇴
    void remove(String uemail);

    // 회원정보수정
    int updateUser(UserDTO user);

	UserDTO getUserByEmail(String uemail);

    
}
