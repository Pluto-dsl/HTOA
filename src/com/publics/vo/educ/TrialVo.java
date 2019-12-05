package com.publics.vo.educ;

import javax.persistence.*;
import java.util.Date;

/**
 * 试讲与培训计划
 *  针对员工发起一个试讲与培训计划
 * */
@Entity
@Table(name="trial")
public class TrialVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int trialId;//主键，标识列，自动生成
    private Date date;//日期
    private String time;//时间(星期一---星期日)
    private int CourseId;//关联课程/章节id
    private int type;//授课类型(试讲/培训)
    private int empId;//员工id关联员工表(授课老师)
    private String remark;//备注(针对课程重要内容)

    public TrialVo(){

    }

    public TrialVo(Date date, String time, int courseId, int type, int empId, String remark) {
        this.date = date;
        this.time = time;
        CourseId = courseId;
        this.type = type;
        this.empId = empId;
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "TrialVo{" +
                "trialId=" + trialId +
                ", date=" + date +
                ", time='" + time + '\'' +
                ", CourseId=" + CourseId +
                ", type=" + type +
                ", empId=" + empId +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getTrialId() {
        return trialId;
    }

    public void setTrialId(int trialId) {
        this.trialId = trialId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getCourseId() {
        return CourseId;
    }

    public void setCourseId(int courseId) {
        CourseId = courseId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
