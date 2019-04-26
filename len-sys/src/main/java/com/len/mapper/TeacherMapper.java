package com.len.mapper;

import com.len.base.BaseMapper;
import com.len.entity.Teacher;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by shangpengyu on 2019/4/24.
 */
@Component
public interface TeacherMapper extends BaseMapper<Teacher,String>{

    List<Teacher> queryTeacher();

}
