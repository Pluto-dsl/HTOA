package com.norman.service;

import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.sys.DeptVo;

import java.util.List;

public interface Ljw_sysSetService {
    /*
    * 院系设置
    * */
    List<DeptVo> selDeptList(int page,int limit);//获取院系数据
    int selDeptSize();//获取院系数据大小
    void insDept(DeptVo vo);//新增院系
    void updDept(DeptVo vo);//修改院系
    void delDept(int id);//删除院系

    /*
    * 专业设置
    * */
    List<MajorVo> selMajorList(int page,int limit);//获取专业数据
    int selMajorSize();//获取专业数据大小
    void insMajor(MajorVo vo);//新增专业
    void updMajor(MajorVo vo);//修改专业
    void delMajor(int id);//删除专业
}
