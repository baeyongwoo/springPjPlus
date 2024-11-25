package com.io.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication auth) throws IOException, ServletException {

        log.info("여기오냐? 로그인 성공했을때");
        log.info("auth data?" + auth);

        // 역할이름 목록
        List<String> roleNames = new ArrayList<>();
        auth.getAuthorities().forEach(authority -> {
            roleNames.add(authority.getAuthority());
        });

        // 세션에 사용자 정보 저장
        HttpSession session = request.getSession();
        UserDetails userDetails = (UserDetails) auth.getPrincipal();
        session.setAttribute("username", userDetails.getUsername());
        session.setAttribute("authorities", userDetails.getAuthorities());

        // admin 권한이 있으면
        if (roleNames.contains("ROLE_ADMIN")) {
            response.sendRedirect("/admin/index"); // 관리자페이지로 이동
            return;
        }
        // member 권한이 있으면
        if (roleNames.contains("ROLE_MEMBER")) {
            response.sendRedirect("/board/list"); // member페이지로 이동
            return;
        }
        // 일반회원은 root로 이동
        response.sendRedirect("/");
    }
}
