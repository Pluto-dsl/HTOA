package com.publics.vo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.TableGenerator;

/**
 * 课程管理
 *      课程管理主要功能有新增课程资料，修改课程资料，删除课程资料，
 *      查看课程资料,专业学期课程对应,课程教员对应
 * */
public class CourseVo {
    @Id
    @GeneratedValue(strategy=GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name="tableGenerator",initialValue=100,allocationSize=1)
    private int courseId;//主键，标识列，自动生成
    private String courseName;//课程名称
    private String isobligatory;//是否必修
    private int courseTypeId;//课程类别id外键
    private String remark;//说明

    public CourseVo(){

    }

    public CourseVo(String courseName, String isobligatory, int courseTypeId, String remark) {
        this.courseName = courseName;
        this.isobligatory = isobligatory;
        this.courseTypeId = courseTypeId;
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "CourseVo{" +
                "courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", isobligatory='" + isobligatory + '\'' +
                ", courseTypeId=" + courseTypeId +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getIsobligatory() {
        return isobligatory;
    }

    public void setIsobligatory(String isobligatory) {
        this.isobligatory = isobligatory;
    }

    public int getCourseTypeId() {
        return courseTypeId;
    }

    public void setCourseTypeId(int courseTypeId) {
        this.courseTypeId = courseTypeId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
