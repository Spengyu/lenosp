package com.len.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.len.base.BaseService;
import com.len.entity.Teacher;
import com.len.util.ReType;

/**
 * Created by shangpengyu on 2019/4/24.
 */
public interface TeacherService extends BaseService<Teacher , String>{

    ReType queryTeacher(Integer page, Integer limit);
}
