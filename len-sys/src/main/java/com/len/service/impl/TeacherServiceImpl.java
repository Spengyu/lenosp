package com.len.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.len.base.BaseMapper;
import com.len.base.impl.BaseServiceImpl;
import com.len.entity.SysUser;
import com.len.entity.Teacher;
import com.len.mapper.TeacherMapper;
import com.len.service.TeacherService;
import com.len.util.ReType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by shangpengyu on 2019/4/24.
 */
@Service
public class TeacherServiceImpl extends BaseServiceImpl<Teacher, String> implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public ReType queryTeacher(Integer page, Integer limit) {
        if(page == null && limit == null || page == 0 && limit == 0){
            page = 1;
            limit=10;
        }

        Page<Teacher> page1 = PageHelper.startPage(page,limit);

        List<Teacher> list =  teacherMapper.queryTeacher();


        return new ReType(page1.getTotal(),list);
    }


    @Override
    public BaseMapper<Teacher, String> getMappser() {
        return teacherMapper;
    }
}
