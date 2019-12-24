package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "enrollment")
public class EnrollmentVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int enrollmentid;       //主键，标识列，自动生成
    private String studName;        //姓名
    private String card;        //身份证
    private String sex;     //性别
    private String tell;        //手机号
    private String qq;      //QQ号码
    private String school;      //学校
    private String classes;     //班级
    private float amount;       //预定报名费
    private String computer;        //是否送电脑(是/否)
    private Date testTime;      //试学时间
    private Date startTime;     //入学时间
    private Date signdate;      //录入时间
    private int empid;      //员工id关联员工表
    private int status;     //关联学生状态表
    private String remark;      //备注
    private int studType;       //班级类别,关联班级类别表
    private Date paymentTime;       //缴预定报名费时间
    private float score;        //入学成绩
    private float enrollMoney;      //发放金额
    private Date enrollMoneyTime;       //发放时间
    private int reviewStatus;       //预定报名费审核
    private String negativeName;        //该字段用于招生老师没有账号时使用字段
    private String reviewer;        //审核人
    private Date reviewerTime;      //审核时间
    private int majorId;        //关联专业id

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
