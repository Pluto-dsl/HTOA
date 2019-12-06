package com.jack.service;

import com.publics.vo.empModel.AttendanceVo;

import java.util.List;

public interface AttService {
    List selAtt(String Aname, int currPage, int pageSize); //查询考勤表
    int selAttCount(String Aname); //查询总页数
    String selDepChairman(String AName); //查询部门负责人
    void insertAtt(AttendanceVo attVo); //插入未打卡说明
    void updataAtt(AttendanceVo attendanceVo); //审批修改
    List selApprover(String Aname,int state);

}
