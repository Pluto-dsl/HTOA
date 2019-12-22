package com.jerry_zhq.service;

import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import com.publics.vo.sys.DepVo;

import java.util.List;

public interface Zhq_StuFloorService {
    //查询
    List selFloor(String hql,int page,int pageSize);

    //查询总条数
    int selCount();

    //删除
    void deleteStuBiu(StudntBuildingVo studntBuildingVoId);

    //添加
    void  addStuBiu(StudntBuildingVo studntBuildingVo);

    //根据楼栋id查找该楼栋的宿舍
    List<StudentDormitoryVo> list(int florid);
}
