package com.publics.vo.empModel;

import javax.persistence.*;

@Entity
@Table(name = "evaluation")
public class evaluationVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int evaluationid; //考评标准id
    private int evaluationName; //考评名称
    private int Score; //考评分数
    private int evaluationType; //1、授课老师  2、班主任
    private String remark;

    @Override
    public String toString() {
        return "evaluationVo{" +
                "evaluationid=" + evaluationid +
                ", evaluationName=" + evaluationName +
                ", Score=" + Score +
                ", evaluationType=" + evaluationType +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getEvaluationid() {
        return evaluationid;
    }

    public void setEvaluationid(int evaluationid) {
        this.evaluationid = evaluationid;
    }

    public int getEvaluationName() {
        return evaluationName;
    }

    public void setEvaluationName(int evaluationName) {
        this.evaluationName = evaluationName;
    }

    public int getScore() {
        return Score;
    }

    public void setScore(int score) {
        Score = score;
    }

    public int getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(int evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
