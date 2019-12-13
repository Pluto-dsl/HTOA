package com.pluto.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Pluto_StudentMsgImpl extends BaseDao implements Pluto_StudentMsg {

    @Override
    public String getStudentList(String sql) {
        List list = super.listBySQL(sql);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","员工请假表");
        json.put("count",1000);
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public List getClassList(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public List getMajor(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public void addStudent(StudentVo s) {
        super.addObject(s);
    }
}
