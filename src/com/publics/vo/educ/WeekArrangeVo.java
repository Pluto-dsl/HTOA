package com.publics.vo.educ;

import javax.persistence.*;

/**
 * 值班管理
 *  员工值班安排主要实现新增，修改，删除和查询功能
 * */
@Entity
@Table(name="weekArrange")
public class WeekArrangeVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int weekArrangeId;//主键，标识列，自动生成
    private String weekArrangeName;//排班名称
    private String ranges;//值班要求
    private String week;//一个星期中的那一天
    private String empId;//关联Emp主键
    private int orderId;//排序
    private int duty;//总值班 1：是 2：否
    private String startTime;//开始时间
    private String endTime;//结束时间
    private String remark;//说明

    public WeekArrangeVo(){

    }

    public WeekArrangeVo(String weekArrangeName, String ranges, String week, String empId, int orderId, int duty, String startTime, String endTime, String remark) {
        this.weekArrangeName = weekArrangeName;
        this.ranges = ranges;
        this.week = week;
        this.empId = empId;
        this.orderId = orderId;
        this.duty = duty;
        this.startTime = startTime;
        this.endTime = endTime;
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "WeekArrangeVo{" +
                "weekArrangeId=" + weekArrangeId +
                ", weekArrangeName='" + weekArrangeName + '\'' +
                ", ranges='" + ranges + '\'' +
                ", week='" + week + '\'' +
                ", empId='" + empId + '\'' +
                ", orderId=" + orderId +
                ", duty=" + duty +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getWeekArrangeId() {
        return weekArrangeId;
    }

    public void setWeekArrangeId(int weekArrangeId) {
        this.weekArrangeId = weekArrangeId;
    }

    public String getWeekArrangeName() {
        return weekArrangeName;
    }

    public void setWeekArrangeName(String weekArrangeName) {
        this.weekArrangeName = weekArrangeName;
    }

    public String getRanges() {
        return ranges;
    }

    public void setRanges(String ranges) {
        this.ranges = ranges;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getDuty() {
        return duty;
    }

    public void setDuty(int duty) {
        this.duty = duty;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
