package com.publics.vo.feedback;

import javax.persistence.*;
import java.util.Date;

/**
 * 问题反馈管理
 *  反馈管理主要功能有、学生可以对问题进行反馈
 *  部门领导或者指定的员工可以查看学生的问题反馈,并及时解决
 * */
@Entity
@Table(name = "feedback")
public class FeedbackVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int feedbackId;//主键，标识列，自动生成
    private int feedBackType;//1：员工，2学生
    private int empId;//学生编号
    private String empName;//获取session中学生班级及姓名或员工姓名
    private Date feedbackTime;//反馈时间，获取系统时间
    private String remark;//建议
    private String image;//图片
    private int status;//1 未处理 2 已处理
    private String depId;//部门
    private String opinion;//审批意见
    private String userid;//审批人

    public FeedbackVo() {

    }


    public FeedbackVo(int feedbackId,int feedBackType, int empId, String empName, Date feedbackTime, String remark, String image, int status, String depId, String opinion,String userid) {
        this.feedbackId = feedbackId;
        this.feedBackType = feedBackType;
        this.empId = empId;
        this.empName = empName;
        this.feedbackTime = feedbackTime;
        this.remark = remark;
        this.image = image;
        this.status = status;
        this.depId = depId;
        this.opinion = opinion;
        this.userid = userid;
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

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Date getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(Date feedbackTime) {
        this.feedbackTime = feedbackTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDepId() {
        return depId;
    }

    public void setDepId(String depId) {
        this.depId = depId;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "FeedbackVo{" +
                "feedbackId=" + feedbackId +
                ", feedBackType=" + feedBackType +
                ", empId=" + empId +
                ", empName='" + empName + '\'' +
                ", feedbackTime=" + feedbackTime +
                ", remark='" + remark + '\'' +
                ", image='" + image + '\'' +
                ", status=" + status +
                ", depId='" + depId + '\'' +
                ", opinion='" + opinion + '\'' +
                ", userid='" + userid + '\'' +
                '}';
    }
}