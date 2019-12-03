package com.publics.vo.empModel.emp;

import javax.persistence.*;
import java.sql.Date;
@Entity
@Table(name = "education")
public class EducationVo {//教育背景
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int collegeid;//主键，标识列，自动生成
    private int Empid;//关联Emp表empid字段
    private String collegeName;//学校名称
    private String degree;//学历
    private Date startDate;//入校时间
    private Date endDate;//毕业时间
    private String Remark;//奖惩情况

    public int getCollegeid() {
        return collegeid;
    }

    public void setCollegeid(int collegeid) {
        this.collegeid = collegeid;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
    }

    public String getCollegeName() {
        return collegeName;
    }

    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }
}
