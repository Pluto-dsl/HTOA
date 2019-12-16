package com.publics.vo.feedback;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "collect_opinions")
public class Collect_OpinionsVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int wid;//哪条问题的id
    private String empname;//审批人 当前登录用户
    private String content;//审批意见
    private Date puttime;//提出时间

    public Collect_OpinionsVo(int wid, String empname, String content, Date puttime) {
        this.wid = wid;
        this.empname = empname;
        this.content = content;
        this.puttime = puttime;
    }

    public Collect_OpinionsVo(){}
    @Override
    public String toString() {
        return "Collect_OpinionsVo{" +
                "id=" + id +
                ", wid=" + wid +
                ", empname='" + empname + '\'' +
                ", content='" + content + '\'' +
                ", puttime=" + puttime +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWid() {
        return wid;
    }

    public void setWid(int wid) {
        this.wid = wid;
    }

    public String getEmpname() {
        return empname;
    }

    public void setEmpname(String empname) {
        this.empname = empname;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPuttime() {
        return puttime;
    }

    public void setPuttime(Date puttime) {
        this.puttime = puttime;
    }
}