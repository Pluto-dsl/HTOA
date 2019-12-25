package com.zero.service;


import com.publics.vo.educ.WeekArrangeVo;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.DepVo;

import java.util.List;
import java.util.Map;

public interface EmpsService {
    List<Map> selectEmp();//查找所有员工
    void addEmp(EmpVo empVo);//新增员工
    void update(EmpVo empVo);//修改员工
    List allDep();//查询所有部门
    void deleteEmp(EmpVo empVo);//删除员工
    Map toemp(int empId);//查找需要修改的员工
    void resetPwd(int empId);//重置员工密码
    List<Map> seekEmp(String sql);//条件搜索员工
    int statue(int empId);//查询当前员工状态
    void status(int state,int empId);//修改员工状态
    void updatePwd(int empId,String pwd);//修改密码

    int selDep(String name,String depName);//根据姓名和部门查询部门是否有职务
    int selStudentClass(int empId);//根据id查询班级表中的职务
    int selStuRepScore(int empId);//根据id查询答辩成绩是否有职务
    void deleteWeekLog(int empId);//删除周报
    void deleteWeekArrange(int empId);//删除值班管理
    void deleteChatRecord(int empId);//删除谈心记录
    void deleteAssTotal(int empId);//删除考核


}
