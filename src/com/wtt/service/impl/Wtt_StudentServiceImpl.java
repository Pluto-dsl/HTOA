package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_StudentService;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Wtt_StudentServiceImpl extends BaseDao implements Wtt_StudentService {

    @Override
    public List<StudentLeaveVo> studentleave(int currpage, int pagesize) {

        return pageByHql("from StudentLeaveVo",currpage,pagesize);
    }

    @Override
    public StudentVo student(int id) {
        return (StudentVo) getObject(new StudentVo().getClass(),id);
    }

    @Override
    public int pagecounts() {
        return selTotalRow("select count(*) from holidayStudent");
    }
}