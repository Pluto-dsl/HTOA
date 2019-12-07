package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;
/**
 * 员工请假申请表
 * */
@Entity
@Table(name = "holiday")
public class HolidayVo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int holidayid;//主键，标识列，自动生成
    private int Empid;//关联Emp主键(请假人)
    private float holidayDay;//假期天数
    private Date startTime;//开始时间
    private Date endTime;//结束时间
    private int hour;//请假小时
    private String Title;//标题
    private int status;//状态 1:审批中 2：已完成 3：不批准
    private String Remark;//内容

    public int getHolidayid() {
        return holidayid;
    }

    public void setHolidayid(int holidayid) {
        this.holidayid = holidayid;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    @Override
    public String toString() {
        return "HolidayVo{" +
                "holidayid=" + holidayid +
                ", Empid=" + Empid +
                ", holidayDay=" + holidayDay +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", hour=" + hour +
                ", Title='" + Title + '\'' +
                ", status=" + status +
                ", Remark='" + Remark + '\'' +
                '}';
    }
}
