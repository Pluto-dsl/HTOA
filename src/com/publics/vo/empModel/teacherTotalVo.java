package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "headTeacher")
public class teacherTotalVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int TeachertotalId;
    private int classTeacher;
    private int classid;
    private int studentId;
    private Date Optime;
    private String sugges;
    private int evaluationType;

    @Override
    public String toString() {
        return "teacherTotalVo{" +
                "TeachertotalId=" + TeachertotalId +
                ", classTeacher=" + classTeacher +
                ", classid=" + classid +
                ", studentId=" + studentId +
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
