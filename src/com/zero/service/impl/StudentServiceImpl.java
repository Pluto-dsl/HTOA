package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.empModel.EnrollmentVo;
import com.publics.vo.studentModel.ClassCategoryVo;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentFallVo;
import com.publics.vo.sys.DeptVo;
import com.zero.service.StudentService;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;
@Service
public class StudentServiceImpl extends BaseDao implements StudentService {
    @Override
    public List<Map> allClas() {
        return super.listBySQL("select c.*,e1.empName as teacherName,e2.empName as classTeacherName,ct.classTypeName,sf.level,d.deptName,m.majorName ," +
                "(select count(*) from student where  clazz = c.classId) ren " +
                "from studentClass c " +
                "left join emp e1 on c.teacher = e1.empId " +
                "left join emp e2 on c.classTeacher = e2.empId " +
                "left join classType ct on c.classType = ct.classTypeId " +
                "left join studentFall sf on c.falled= sf.fallid " +
                "left join dept d on c.deptId = d.deptid " +
                "left join major m on m.majorid = c.majorId ");
    }

    @Override
    public List<Map> seek(int level,String grade,int ctype) {
        String sql = "select c.*,e1.empName as teacherName,e2.empName as classTeacherName,ct.classTypeName,sf.level,d.deptName,m.majorName ," +
                " (select count(*) from student where  clazz = c.classId) ren " +
                " from studentClass c " +
                " left join emp e1 on c.teacher = e1.empId " +
                " left join emp e2 on c.classTeacher = e2.empId " +
                " left join classType ct on c.classType = ct.classTypeId " +
                " left join studentFall sf on c.falled= sf.fallid " +
                " left join dept d on c.deptId = d.deptid " +
                " left join major m on m.majorid = c.majorId where 1=1 ";
        if(level!=0){
            sql += (" and sf.fallid = "+level);
        }
        if(!grade.equals("0")){
            sql+=(" and c.className like '%"+grade+"%'");
        }
        if (ctype!=0){
            sql+=(" and ct.classTypeId = "+ctype);
        }
        return super.listBySQL(sql);
    }

    @Override
    public List<StudentFallVo> allLevel() {
        return super.listByHql("from StudentFallVo");
    }

    @Override
    public List<Map> teacher() {
        return super.listBySQL("select empId,empName from emp");
    }

    @Override
    public List<ClassCategoryVo> classtype() {
        return super.listByHql("from ClassCategoryVo");
    }

    @Override
    public List<DeptVo> dept() {
        return super.listByHql("from DeptVo");

    }

    @Override
    public List<MajorVo> major() {
        return super.listByHql("from MajorVo");
    }

    @Override
    public void deleteClass(int classid) {
        StudentClassVo classVo = new StudentClassVo();
        classVo.setClassId(classid);
        super.delObject(classVo);
    }

    @Override
    public void addClass(StudentClassVo classVo) {
        if(classVo.getClassId()==0){//新增
            super.addObject(classVo);
        }else{
            super.updObject(classVo);
        }
    }

    @Override
    public void addFall(StudentFallVo fallVo) {
        if(fallVo.getFallid()==0){//新增
            super.addObject(fallVo);
        }else{
            super.updObject(fallVo);
        }
    }

    @Override
    public List<Map> classStudent(int classId) {
        return super.listBySQL("select c.className,s.stuname,s.sex,s.phone ,(select count(*) from student where  clazz = "+classId+")  ren from student s LEFT JOIN studentClass c on s.clazz = c.classId where c.classId = "+classId);
    }

    @Override
    public List<Map> enroStu() {
        return super.listBySQL("select t.enrollmentid,t.studName,t.card,t.sex,t.tell,t.school,t.classes,t.studType,c.classTypeName,t.empid,e.empName from enrollment t" +
                " left join emp e on e.empId = t.empid" +
                " left join classType c on  c.classTypeId = t.studType where  t.status BETWEEN 1 and 3");
    }

    @Override
    public List<Map> seekStu(String stuname, String Phone, int ctype) {
        String sql = "select t.enrollmentid,t.studName,t.card,t.sex,t.tell,t.school,t.classes,t.studType,c.classTypeName,t.empid,e.empName from enrollment t" +
                " left join emp e on e.empId = t.empid" +
                " left join classType c on  c.classTypeId = t.studType " +
                " where  t.status BETWEEN 1 and 3 and t.studName like '%"+stuname+"%' and t.tell like '%"+Phone+"%'";
        if(ctype!=0){
            sql+=("and t.studType = "+ctype);
        }
        return super.listBySQL(sql);
    }

    @Override
    public EnrollmentVo enStu(int sid) {
        EnrollmentVo en=  (EnrollmentVo) super.getObject(EnrollmentVo.class,sid);
        en.setStatus(4);
        super.updObject(en);//改变为在读学生
        return en;
    }

    @Override
    public MajorVo marjov(int marjorid) {
        return (MajorVo) super.getObject(MajorVo.class,marjorid);
    }
}
