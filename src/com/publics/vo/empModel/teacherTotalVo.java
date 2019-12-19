package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "teacherTotal")
public class teacherTotalVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int TeachertotalId; //教师考评编号
    private int classTeacher;   //老师/班主任的id
    private int classid;    //班级id
    private int studentId;  //学生id
    private int teacherScore;   //学生给老师的评分
    private int evaluationid;   //考评内容的主键id
    private Date Optime;    //考评的时间
    private String sugges;  //问题与意见
    private int evaluationType; //员工的教师职位

    @Override
    public String toString() {
        return "teacherTotalVo{" +
                "TeachertotalId=" + TeachertotalId +
                ", classTeacher=" + classTeacher +
                ", classid=" + classid +
                ", studentId=" + studentId +
                ", teacherScore=" + teacherScore +
                ", evaluationid=" + evaluationid +
                ", Optime=" + Optime +
                ", sugges='" + sugges + '\'' +
                ", evaluationType=" + evaluationType +
                '}';
    }

    public int getTeachertotalId() {
        return TeachertotalId;
    }

    public void setTeachertotalId(int teachertotalId) {
        TeachertotalId = teachertotalId;
    }

    public int getClassTeacher() {
        return classTeacher;
    }

    public void setClassTeacher(int classTeacher) {
        this.classTeacher = classTeacher;
    }

    public int getClassid() {
        return classid;
    }

    public void setClassid(int classid) {
        this.classid = classid;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getTeacherScore() {
        return teacherScore;
    }

    public void setTeacherScore(int teacherScore) {
        this.teacherScore = teacherScore;
    }

    public int getEvaluationid() {
        return evaluationid;
    }

    public void setEvaluationid(int evaluationid) {
        this.evaluationid = evaluationid;
    }

    public Date getOptime() {
        return Optime;
    }

    public void setOptime(Date optime) {
        Optime = optime;
    }

    public String getSugges() {
        return sugges;
    }

    public void setSugges(String sugges) {
        this.sugges = sugges;
    }

    public int getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(int evaluationType) {
        this.evaluationType = evaluationType;
    }
}
