package com.publics.vo.assess;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "aduitLog")
public class AduitLogVo {//员工考核

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)

    private int aduitLogid;//主键，标识列，自动生成
    private int aduitModelid;//外键，考核指标id
    private int Empid;//员工id
    private int Scores;//考核分数,根据考核指标规定的分数进行扣分负数或者加分为正数
    private Date auditDate;//考核时间
    private String Remark;//说明
    private String auditPerson;//录入人员，从session取值
    private String Image;//图片

    @Override
    public String toString() {
        return "AduitLogVo{" +
                "aduitLogid=" + aduitLogid +
                ", aduitModelid=" + aduitModelid +
                ", Empid=" + Empid +
                ", Scores=" + Scores +
                ", auditDate=" + auditDate +
                ", Remark='" + Remark + '\'' +
                ", auditPerson='" + auditPerson + '\'' +
                ", Image='" + Image + '\'' +
                '}';
    }

    public int getAduitLogid() {
        return aduitLogid;
    }

    public void setAduitLogid(int aduitLogid) {
        this.aduitLogid = aduitLogid;
    }

    public int getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(int aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
    }

    public int getScores() {
        return Scores;
    }

    public void setScores(int scores) {
        Scores = scores;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    public String getAuditPerson() {
        return auditPerson;
    }

    public void setAuditPerson(String auditPerson) {
        this.auditPerson = auditPerson;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }
}
