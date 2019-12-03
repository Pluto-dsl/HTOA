package com.publics.vo.assess;

import javax.persistence.*;

@Entity
@Table(name="aduitModel")
public class AduitModelVo {//考核指标

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)


    private int aduitModelid;//主键，标识列，自动生成
    private String aduitName;//考核内容
    private int Scores;//考核分数
    private int Depid;//关联部门表
    private String Remark;//说明

    @Override
    public String toString() {
        return "aduitModelVo{" +
                "aduitModelid=" + aduitModelid +
                ", aduitName='" + aduitName + '\'' +
                ", Scores=" + Scores +
                ", Depid=" + Depid +
                ", Remark='" + Remark + '\'' +
                '}';
    }

    public int getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(int aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public String getAduitName() {
        return aduitName;
    }

    public void setAduitName(String aduitName) {
        this.aduitName = aduitName;
    }

    public int getScores() {
        return Scores;
    }

    public void setScores(int scores) {
        Scores = scores;
    }

    public int getDepid() {
        return Depid;
    }

    public void setDepid(int depid) {
        Depid = depid;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }
}
