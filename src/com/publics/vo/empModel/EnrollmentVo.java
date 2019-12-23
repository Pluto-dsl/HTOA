package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "enrollment")
public class EnrollmentVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int enrollmentid;
    private String studName;
    private String card;
    private String sex;
    private String tell;
    private String qq;
    private String school;
    private String classes;
    private float amount;
    private String computer;
    private Date testTime;
    private Date startTime;
    private Date signdate;
    private int empid;
    private int status;
    private String remark;
    private int studType;
    private Date paymentTime;
    private float score;
    private float enrollMoney;
    private Date enrollMoneyTime;
    private int reviewStatus;
    private String negativeName;
    private String reviewer;
    private Date reviewerTime;
    private int majorId;

    @Override
    public String toString() {
        return "EnrollmentVo{" +
                "enrollmentid=" + enrollmentid +
                ", studName='" + studName + '\'' +
                ", card='" + card + '\'' +
                ", sex='" + sex + '\'' +
                ", tell='" + tell + '\'' +
                ", qq='" + qq + '\'' +
                ", school='" + school + '\'' +
                ", classes='" + classes + '\'' +
                ", amount=" + amount +
                ", computer='" + computer + '\'' +
                ", testTime=" + testTime +
                ", startTime=" + startTime +
                ", signdate=" + signdate +
                ", empid=" + empid +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                ", studType=" + studType +
                ", paymentTime=" + paymentTime +
                ", score=" + score +
                ", enrollMoney=" + enrollMoney +
                ", enrollMoneyTime=" + enrollMoneyTime +
                ", reviewStatus=" + reviewStatus +
                ", negativeName='" + negativeName + '\'' +
                ", reviewer='" + reviewer + '\'' +
                ", reviewerTime=" + reviewerTime +
                ", majorId=" + majorId +
                '}';
    }

    public int getEnrollmentid() {
        return enrollmentid;
    }

    public void setEnrollmentid(int enrollmentid) {
        this.enrollmentid = enrollmentid;
    }

    public String getStudName() {
        return studName;
    }

    public void setStudName(String studName) {
        this.studName = studName;
    }

    public String getCard() {
        return card;
    }

    public void setCard(String card) {
        this.card = card;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTell() {
        return tell;
    }

    public void setTell(String tell) {
        this.tell = tell;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getComputer() {
        return computer;
    }

    public void setComputer(String computer) {
        this.computer = computer;
    }

    public Date getTestTime() {
        return testTime;
    }

    public void setTestTime(Date testTime) {
        this.testTime = testTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getSigndate() {
        return signdate;
    }

    public void setSigndate(Date signdate) {
        this.signdate = signdate;
    }

    public int getEmpid() {
        return empid;
    }

    public void setEmpid(int empid) {
        this.empid = empid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getStudType() {
        return studType;
    }

    public void setStudType(int studType) {
        this.studType = studType;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public float getEnrollMoney() {
        return enrollMoney;
    }

    public void setEnrollMoney(float enrollMoney) {
        this.enrollMoney = enrollMoney;
    }

    public Date getEnrollMoneyTime() {
        return enrollMoneyTime;
    }

    public void setEnrollMoneyTime(Date enrollMoneyTime) {
        this.enrollMoneyTime = enrollMoneyTime;
    }

    public int getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(int reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public String getNegativeName() {
        return negativeName;
    }

    public void setNegativeName(String negativeName) {
        this.negativeName = negativeName;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }

    public Date getReviewerTime() {
        return reviewerTime;
    }

    public void setReviewerTime(Date reviewerTime) {
        this.reviewerTime = reviewerTime;
    }

    public int getMajorId() {
        return majorId;
    }

    public void setMajorId(int majorId) {
        this.majorId = majorId;
    }
}
