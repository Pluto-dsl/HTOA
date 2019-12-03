package com.publics.vo.assess;

import javax.persistence.*;

@Entity
@Table(name ="empAssessment")
public class EmpAssessmentVo {//员工考核各项得分详情表

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)

    private int empAssessId;//主键，标识列，自动生成
    private int aduitModelid;//考核指标关联考核指标表
    private Float scores;//得分
    private int empAssTotalId;//关联考核总表

    @Override
    public String toString() {
        return "EmpAssessmentVo{" +
                "empAssessId=" + empAssessId +
                ", aduitModelid=" + aduitModelid +
                ", scores=" + scores +
                ", empAssTotalId=" + empAssTotalId +
                '}';
    }

    public int getEmpAssessId() {
        return empAssessId;
    }

    public void setEmpAssessId(int empAssessId) {
        this.empAssessId = empAssessId;
    }

    public int getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(int aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public Float getScores() {
        return scores;
    }

    public void setScores(Float scores) {
        this.scores = scores;
    }

    public int getEmpAssTotalId() {
        return empAssTotalId;
    }

    public void setEmpAssTotalId(int empAssTotalId) {
        this.empAssTotalId = empAssTotalId;
    }
}
