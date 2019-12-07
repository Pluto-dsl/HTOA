package com.norman.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.ChatRecordVo;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_EmpService {
    int getChatRecordSize();//获取谈心记录的条数
    void delChatRecord(int id);//删除谈心记录
    void addChatRecord(ChatRecordVo vo);//添加谈心记录
    List<EmpVo> getEmpList();//获取员工列表
    List<StudentVo> getStudentList();//获取学生列表
    JSONArray getData(int page,int limit);//获取表格数据
    void setChatRecord(ChatRecordVo vo);//获取谈心记录列表
    JSONArray getWeekLogData(HttpServletRequest request,int page, int limit);//获取周报列表
    int getWeekLogSize();//获取周报记录数
    JSONObject getWeekLog(int id);//获取谈心记录
    List<DepVo> getDepList();
}
