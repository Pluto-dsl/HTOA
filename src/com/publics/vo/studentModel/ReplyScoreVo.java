package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 *      答辩成绩
 *          在每个学期，学期结束会有一个项目答辩，学生在台上演示所做的项目，由教员进行打分，打分项包括若干项，
 * */
@Entity
@Table(name = "studentReplyScore")
public class ReplyScoreVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int replyId;//成绩主键id
    private int StudentId;//学生表外键
    private int projectId;//关联 答辩项目
    private int empId;//打分老师管理员工表外键
    private float score1;//功能完善50
    private float Score2;//技术难度10
    private float Score3;//界面完美10
    private float Score4;//回答问题10
    private float Score5;//演示方法10
    private float Score6;//语言表达10
    private float Score7;//总分100
    private String Remark;//备注

    public ReplyScoreVo(int replyId,int studentId, int projectId, int empId, float score1, float score2, float score3, float score4, float score5, float score6, float score7, String remark) {
        this.replyId = replyId;
        this.StudentId = studentId;
        this.projectId = projectId;
        this.empId = empId;
        this.score1 = score1;
        this.Score2 = score2;
        this.Score3 = score3;
        this.Score4 = score4;
        this.Score5 = score5;
        this.Score6 = score6;
        this.Score7 = score7;
        this.Remark = remark;
    }

    public ReplyScoreVo(){}

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getStudentId() {
        return StudentId;
    }

    public void setStudentId(int studentId) {
        StudentId = studentId;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public float getScore1() {
        return score1;
    }

    public void setScore1(float score1) {
        this.score1 = score1;
    }

    public float getScore2() {
        return Score2;
    }

    public void setScore2(float score2) {
        Score2 = score2;
    }

    public float getScore3() {
        return Score3;
    }

    public void setScore3(float score3) {
        Score3 = score3;
    }

    public float getScore4() {
        return Score4;
    }

    public void setScore4(float score4) {
        Score4 = score4;
    }

    public float getScore5() {
        return Score5;
    }

    public void setScore5(float score5) {
        Score5 = score5;
    }

    public float getScore6() {
        return Score6;
    }

    public void setScore6(float score6) {
        Score6 = score6;
    }

    public float getScore7() {
        return Score7;
    }

    public void setScore7(float score7) {
        Score7 = score7;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    @Override
    public String toString() {
        return "ReplyScoreVo{" +
                "replyId=" + replyId +
                ", StudentId=" + StudentId +
                ", projectId=" + projectId +
                ", empId=" + empId +
                ", score1=" + score1 +
                ", Score2=" + Score2 +
                ", Score3=" + Score3 +
                ", Score4=" + Score4 +
                ", Score5=" + Score5 +
                ", Score6=" + Score6 +
                ", Score7=" + Score7 +
                ", Remark='" + Remark + '\'' +
                '}';
    }
}