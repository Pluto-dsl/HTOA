package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentFallVo;
import com.zero.service.StudentService;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;
@Service
public class StudentServiceImpl extends BaseDao implements StudentService {
    @Override
    public List<Map> allClas() {
        return super.listBySQL("select c.*,e1.empName as teacherName,e2.empName as classTeacherName,ct.classTypeName,sf.level,d.deptName,m.majorName " +
                "from studentClass c " +
                "left join emp e1 on c.teacher = e1.empId " +
                "left join emp e2 on c.classTeacher = e2.empId " +
                "left join classType ct on c.classType = ct.classTypeId " +
                "left join studentFall sf on c.falled= sf.fallid " +
                "left join dept d on c.deptId = d.deptid " +
                "left join major m on m.deptid = d.deptid ");
    }

    @Override
    public List<StudentFallVo> allLevel() {
        return super.listByHql("from StudentFallVo");
    }

    @Override
    public void deleteClass(int classid) {
        StudentClassVo classVo = new StudentClassVo();
        classVo.setClassId(classid);
        super.delObject(classVo);
    }
}
