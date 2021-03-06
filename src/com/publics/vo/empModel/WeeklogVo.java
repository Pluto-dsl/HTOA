package com.publics.vo.empModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "weeklog")
public class WeeklogVo {//周报
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int weeklogid;//主键，标识列，自动生成
    private int Empid;//关联Emp表empid字段
    private Date Workday;//填写日期
    private String weekCur;//本周情况描述
    private String studentQuestion;//问题学生情况反馈
    private String Idea;//意见建议
    private String weekNext;//下周工作计划

    public int getWeeklogid() {
        return weeklogid;
    }

    public void setWeeklogid(int weeklogid) {
        this.weeklogid = weeklogid;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
    }

    public Date getWorkday() {
        return Workday;
    }

    public void setWorkday(Date workday) {
        Workday = workday;
    }

    public String getWeekCur() {
        return weekCur;
    }

    public void setWeekCur(String weekCur) {
        this.weekCur = weekCur;
    }

    public String getStudentQuestion() {
        return studentQuestion;
    }

    public void setStudentQuestion(String studentQuestion) {
        this.studentQuestion = studentQuestion;
    }

    public String getIdea() {
        return Idea;
    }

    public void setIdea(String idea) {
        Idea = idea;
    }

    public String getWeekNext() {
        return weekNext;
    }

    public void setWeekNext(String weekNext) {
        this.weekNext = weekNext;
    }

    @Override
    public String toString() {
        return "WeeklogVo{" +
                "worklogid=" + weeklogid +
                ", Empid=" + Empid +
                ", Workday=" + Workday +
                ", weekCur='" + weekCur + '\'' +
                ", studentQuestion='" + studentQuestion + '\'' +
                ", Idea='" + Idea + '\'' +
                ", weekNext='" + weekNext + '\'' +
                '}';
    }

    public WeeklogVo(int worklogid, int empid, Date workday, String weekCur, String studentQuestion, String idea, String weekNext) {
        this.weeklogid = worklogid;
        this.Empid = empid;
        this.Workday = workday;
        this.weekCur = weekCur;
        this.studentQuestion = studentQuestion;
        this.Idea = idea;
        this.weekNext = weekNext;
    }

    public WeeklogVo(){

    }
}
