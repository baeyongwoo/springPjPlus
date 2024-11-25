package com.io.service;

import com.io.mapper.MypageMapper;
import com.io.model.MypageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MyPageService {

    @Autowired
    private MypageMapper mypageMapper;

    public List<MypageDTO> getMypagePosts(String uemail) {
        Map<String, Object> params = Map.of("uemail", uemail);
        return mypageMapper.selectMypage(params);
    }
}
