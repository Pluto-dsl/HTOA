package com.publics.vo.empModel;


import javax.persistence.*;

@Entity
@Table(name = "headTeacher")
public class    headTeacherVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int headTeacherid;
    private int evaluationid;
    private String testScore;
    private int TeachertotalId;

    @Override
    public String toString() {
        return "headTeacherVo{" +
                "headTeacherid=" + headTeacherid +
                ", evaluationid=" + evaluationid +
                ", testScore='" + testScore + '\'' +
                ", totalId=" + TeachertotalId +
                '}';
    }

    public int getHeadTeacherid() {
        return headTeacherid;
    }

    public void setHeadTeacherid(int headTeacherid) {
        this.headTeacherid = headTeacherid;
    }

    public int getEvaluationid() {
        return evaluationid;
    }

    public void setEvaluationid(int evaluationid) {
        this.evaluationid = evaluationid;
    }

    public String getTestScore() {
        return testScore;
    }

    public void setTestScore(String testScore) {
        this.testScore = testScore;
    }

    public int getTotalId() {
        return TeachertotalId;
    }

    public void setTotalId(int totalId) {
        this.TeachertotalId  = totalId;
    }
}
