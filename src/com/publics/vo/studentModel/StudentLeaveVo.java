package com.publics.vo.studentModel;

import javax.persistence.*;
import java.util.Date;

/**
 * 学生请假管理
 *       学生如果有事外出，必须要向班主任和专业老师请假，并且根据请假的时间长短要进行审批的人数也不一样，
 *       对应在系统中就是要选定的流程模板不一样。学生请假流程又学生发起，流程审批完学生才能外出学生如果有事外出，必须要向班主任和专业老师请假，
 *       并且根据请假的时间长短要进行审批的人数也不一样，对应在系统中就是要选定的流程模板不一样。
 *       学生请假流程又学生发起，流程审批完学生才能外出
 * */

@Entity
@Table(name = "holidayStudent")
public class StudentLeaveVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int holidayid;//主键，标识列，自动生成
    private int StudentId;//关联学生表主键(请假人)
    private float holidayDay;//假期天数
    private Date startTime;//开始时间
    private Date endTime;//结束时间
    private String Title;//申请类型
    private String Remark;//内容
    private String Status;//审批中，审批通过，审批未通过

    public StudentLeaveVo(int studentId, float holidayDay, Date startTime, Date endTime, String title, String remark, String status) {
        this.StudentId = studentId;
        this.holidayDay = holidayDay;
        this.startTime = startTime;
        this.endTime = endTime;
        this.Title = title;
        this.Remark = remark;
        this.Status = status;
    }
    public StudentLeaveVo(){}

    @Override
    public String toString() {
        return "StudentLeaveVo{" +
                "holidayid=" + holidayid +
                ", StudentId=" + StudentId +
                ", holidayDay=" + holidayDay +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", Title='" + Title + '\'' +
                ", Remark='" + Remark + '\'' +
                ", Status='" + Status + '\'' +
                '}';
    }

    public int getHolidayid() {
        return holidayid;
    }

    public void setHolidayid(int holidayid) {
        this.holidayid = holidayid;
    }

    public int getStudentId() {
        return StudentId;
    }

    public void setStudentId(int studentId) {
        StudentId = studentId;
    }

    public float getHolidayDay() {
        return holidayDay;
    }

    public void setHolidayDay(float holidayDay) {
        this.holidayDay = holidayDay;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}