package com.wtt.service;

import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;

import java.util.List;

public interface Wtt_StudentService {
    List<StudentLeaveVo> studentleave(int currpage, int pagesize);

    StudentVo student(int id);
    //查询总页数
    int pagecounts();
}