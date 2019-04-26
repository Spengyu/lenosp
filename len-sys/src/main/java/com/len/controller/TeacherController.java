package com.len.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.len.base.BaseController;
import com.len.entity.Teacher;
import com.len.service.TeacherService;
import com.len.util.JsonUtil;
import com.len.util.ReType;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by shangpengyu on 2019/4/24.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController extends BaseController<Teacher>{

    @Autowired
    private TeacherService teacherService;



    @GetMapping("/byId")
    public ModelAndView getTeacById(Integer id){
        Teacher teacher = teacherService.selectByPrimaryKey(id);
        ModelAndView mo = new ModelAndView();
        mo.addObject("teac",teacher);
        mo.setViewName("/teacher/update-teacher");

        return mo;
    }



    /*删除方法*/
    @PostMapping(value = "/delTeacher")
    @ResponseBody
    @RequiresPermissions("user:del")
    public JsonUtil delTeacher(Integer id){
        int i = teacherService.deleteByPrimaryKey(id);
        JsonUtil jsonUtil = new JsonUtil();
        if(i != 0){
            jsonUtil.setMsg("删除成功！");
            return jsonUtil;
        }
        jsonUtil.setMsg("操作失败！");
        return jsonUtil;
    }



    //打开新增页面
    @GetMapping("/showAddTeacher")
    public String getFtlAdd(){
        return "/teacher/add-teacher";
    }


    //打开查询页面
    @GetMapping("/listFtl")
    public String getFtlList(){
        return "/teacher/teacherList";
    }


    @PostMapping("/add")
    @ResponseBody
    public JsonUtil addTeacher(Teacher teacher){

       JsonUtil json =  new JsonUtil();

        int i = teacherService.insertSelective(teacher);
        if(i != 0){
            json.setMsg("保存成功！");
            return json;
        }
        json.setMsg("操作失败！");
        return json;
    }



    @GetMapping("/query")
    @ResponseBody
    public ReType queryTeacher(Integer page, Integer limit){
        return teacherService.queryTeacher(page,limit);

       /* ReType reType = new ReType();

        reType.setCode(0);
        reType.setCount(pageInfo.getTotal());
        reType.setPageNum(pageInfo.getPageNum());
        reType.setData(pageInfo.getList());*/

    }



}
