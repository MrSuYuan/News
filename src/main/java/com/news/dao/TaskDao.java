package com.news.dao;

import com.news.vo.DividedVo;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository("taskDao")
public interface TaskDao {

    /**
     * 查询分润参数
     */
    DividedVo dividedVo(Map<String,Object> map);

}
