package com.io.mapper;

import com.io.model.MypageDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MypageMapper {
    List<MypageDTO> selectMypage(Map<String, Object> params);
}
