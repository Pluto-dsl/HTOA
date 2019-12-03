package com.publics.vo.educ;

import javax.persistence.*;

/**
 * 课程类别管理
 *    类别管理主要功能有新增类别资料，修改类别资料，
 *    删除类别资料，查看类别资料,类别指的是课程类别
 * */
@Entity
@Table(name="courseType")
public class CourseTypeVo {
    @Id
    @GeneratedValue(strategy=GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name="tableGenerator",initialValue=10,allocationSize=1)
    private int courseTypeId;//主键，标识列，自动生成
    private String courseTypeName;//类别名称(公共课，专业课)
    private String remark;//说明

    public CourseTypeVo(){

    }

    public CourseTypeVo(int courseTypeId, String courseTypeName, String remark) {
        this.courseTypeId = courseTypeId;
        this.courseTypeName = courseTypeName;
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "courseType{" +
                "courseTypeId=" + courseTypeId +
                ", courseTypeName='" + courseTypeName + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getCourseTypeId() {
        return courseTypeId;
    }

    public void setCourseTypeId(int courseTypeId) {
        this.courseTypeId = courseTypeId;
    }

    public String getCourseTypeName() {
        return courseTypeName;
    }

    public void setCourseTypeName(String courseTypeName) {
        this.courseTypeName = courseTypeName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
