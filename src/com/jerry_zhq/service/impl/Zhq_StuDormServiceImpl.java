package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_StuDormService;
import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.StudentDormitoryVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Zhq_StuDormServiceImpl extends BaseDao implements Zhq_StuDormService {
    //分页查询
    @Override
    public List selDorm(String hql, int page, int pageSize) {
        return pageByHql(hql,page,pageSize);
    }

    //查询总条数
    @Override
    public int selCount() {
        return selTotalRow("select count(*) from studentHuor");
    }

    //根据宿舍中的楼栋id查询楼栋名
    @Override
    public List<Map> selDormFloor(int id) {
        return listBySQL("select floorName from  studentFloor sf left join studentHuor sh on sf.floorId =sh.floorId where sf.floorId ="+id);
    }

    //删除
    @Override
    public void delStuDorm(StudentDormitoryVo studentDormitoryVo) {
        delObject(studentDormitoryVo);
    }

    //查询楼栋名称
    @Override
    public List selFloorName() {
        return  listByHql("from StudntBuildingVo");
    }

    //查询所有宿舍房号
    @Override
    public List selDormName() {
        return listByHql("from StudentDormitoryVo");
    }


    //添加
    @Override
    public void addDorm(StudentDormitoryVo studentDormitoryVo) {
        addObject(studentDormitoryVo);
    }

    //修改
    @Override
    public void update(StudentDormitoryVo studentDormitoryVo) {
        updObject(studentDormitoryVo);
    }


    //查询学生表
    @Override
    public List selStudent() {
        return listByHql("from StudentVo");
    }

    //查询班级表
    @Override
    public List sleStudentClass() {
        return listByHql("from StudentClassVo");
    }

    //根据id查询房号
    @Override
    public Object selIdHourName(Class vo, int id) {
        return getObject(vo,id);
    }




}
