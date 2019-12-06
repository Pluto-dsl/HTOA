package com.norman.service;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.ChatRecordVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;

import java.util.List;
import java.util.Map;

public interface Ljw_EmpService {
    List<ChatRecordVo> getChatRecordList(int page,int limit);//获取所有谈心记录
    int getChatRecordSize();//获取谈心记录的条数
    void delChatRecord(int id);//删除谈心记录
    void addChatRecord(ChatRecordVo vo);//添加谈心记录
    List<EmpVo> getEmpList();//获取员工列表
    List<StudentVo> getStudentList();//获取学生列表
    JSONArray getData(int page,int limit);//获取表格数据
    void setChatRecord(ChatRecordVo vo);
}
