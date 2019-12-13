package com.publics.vo.studentModel;

import javax.persistence.*;
/**
 *   班级管理:
 *      在此菜单列出所有的班级信息，菜单导航位置添加一个分班按钮，
 *      点击按钮把所有未分班的学生以弹出窗口的形式列出(必须使用分页)，
 *      用户可以勾选一个或多个学生，点击确认按钮后，会把勾选的学生分配到相应的班级
 * */
@Entity
@Table(name = "studentClass")
public class StudentClassVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int classId;//主键
    private String classno;//班级编号
    private String className;//班级名称
    private int count;//班级人数
    private int teacher;//授课老师    员工表外键
    private int classTeacher;//班主任   员工表外键
    private int classType;//班级类别  关联班级类别表
    private String remark;//备注
    private int falled;//关联班级类别
    private int deptId;//关联系
    private int majorId;//关联专业表

    @Override
    public String toString() {
        return "StudentClassVo{" +
                "classId=" + classId +
                ", classno='" + classno + '\'' +
                ", className='" + className + '\'' +
                ", count=" + count +
                ", teacher='" + teacher + '\'' +
                ", classTeacher='" + classTeacher + '\'' +
                ", classType=" + classType +
                ", remark='" + remark + '\'' +
                ", falled=" + falled +
                ", deptId=" + deptId +
                ", majorId=" + majorId +
                '}';
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassno() {
        return classno;
    }

    public void setClassno(String classno) {
        this.classno = classno;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }



    public int getClassType() {
        return classType;
    }

    public void setClassType(int classType) {
        this.classType = classType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getFalled() {
        return falled;
    }

    public void setFalled(int falled) {
        this.falled = falled;
    }

    public int getDeptId() {
        return deptId;
    }

    public void setDeptId(int deptId) {
        this.deptId = deptId;
    }

    public int getMajorId() {
        return majorId;
    }

    public void setMajorId(int majorId) {
        this.majorId = majorId;
    }
}