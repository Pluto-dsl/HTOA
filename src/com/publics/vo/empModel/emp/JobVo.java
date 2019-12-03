package com.publics.vo.empModel.emp;

import javax.persistence.*;
import java.util.Date;

/**
 *工作经历主要功能是实现员工的工作过的单位及岗位职责等描述，要求实现新增，修改，删除与查询操作；
 * */
@Entity
@Table(name = "job")
public class JobVo {//工作经历
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Jobid;//主键，标识列，自动生成
    private int Empid;//关联Emp表empid字段
    private String companyName;//公司名称
    private String  degree;//岗位
    private Date startDate;//入职时间
    private Date endDate;//离职时间
    private String reason;//离职原因
    private String  Remark;//说明

    public int getJobid() {
        return Jobid;
    }

    public void setJobid(int jobid) {
        Jobid = jobid;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }
}
