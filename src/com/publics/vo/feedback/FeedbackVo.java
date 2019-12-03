package com.publics.vo.feedback;

import javax.persistence.*;
/**
 * 问题反馈管理
 *  反馈管理主要功能有、学生可以对问题进行反馈
 *  部门领导或者指定的员工可以查看学生的问题反馈,并及时解决
 * */
@Entity
@Table(name = "feedback")
public class FeedbackVo {
    @Id
    @GeneratedValue(strategy= GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name="tableGenerator",initialValue=1000,allocationSize=1)
    private int feedbackId;//主键，标识列，自动生成
    private int feedBackType;//1：员工，2学生
    private int empId;//部门编号
    private int empName;//获取session中学生班级及姓名或员工姓名
    private int feedbackTime;//反馈时间，获取系统时间
    private int remark;//建议
    private int image;//图片
    private int status;//1 未处理 2 已处理
    private int depId;//部门
    private int opinion;//审批意见

    public FeedbackVo() {
    }

    public FeedbackVo(int feedBackType, int empId, int empName, int feedbackTime, int remark, int image, int status, int depId, int opinion) {
        this.feedBackType = feedBackType;
        this.empId = empId;
        this.empName = empName;
        this.feedbackTime = feedbackTime;
        this.remark = remark;
        this.image = image;
        this.status = status;
        this.depId = depId;
        this.opinion = opinion;
    }

    @Override
    public String toString() {
        return "FeedbackVo{" +
                "feedbackId=" + feedbackId +
                ", feedBackType=" + feedBackType +
                ", empId=" + empId +
                ", empName=" + empName +
                ", feedbackTime=" + feedbackTime +
                ", remark=" + remark +
                ", image=" + image +
                ", status=" + status +
                ", depId=" + depId +
                ", opinion=" + opinion +
                '}';
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getFeedBackType() {
        return feedBackType;
    }

    public void setFeedBackType(int feedBackType) {
        this.feedBackType = feedBackType;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public int getEmpName() {
        return empName;
    }

    public void setEmpName(int empName) {
        this.empName = empName;
    }

    public int getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(int feedbackTime) {
        this.feedbackTime = feedbackTime;
    }

    public int getRemark() {
        return remark;
    }

    public void setRemark(int remark) {
        this.remark = remark;
    }

    public int getImage() {
        return image;
    }

    public void setImage(int image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getDepId() {
        return depId;
    }

    public void setDepId(int depId) {
        this.depId = depId;
    }

    public int getOpinion() {
        return opinion;
    }

    public void setOpinion(int opinion) {
        this.opinion = opinion;
    }
}
