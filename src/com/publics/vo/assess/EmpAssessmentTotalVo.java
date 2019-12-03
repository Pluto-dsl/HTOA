package com.publics.vo.assess;

import javax.persistence.*;

@Entity
@Table(name="empAssessmentTotal")
public class EmpAssessmentTotalVo {//员工考核总表

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)

    private int empAssTotalId;//主键，标识列，自动生成
    private int empId;//关联员工表
    private int totalScores;//总得分
    private String remark;//备注

    @Override
    public String toString() {
        return "EmpAssessmentTotalVo{" +
                "empAssTotalId=" + empAssTotalId +
                ", empId=" + empId +
                ", totalScores=" + totalScores +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getEmpAssTotalId() {
        return empAssTotalId;
    }

    public void setEmpAssTotalId(int empAssTotalId) {
        this.empAssTotalId = empAssTotalId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public int getTotalScores() {
        return totalScores;
    }

    public void setTotalScores(int totalScores) {
        this.totalScores = totalScores;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
