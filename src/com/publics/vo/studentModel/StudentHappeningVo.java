package com.publics.vo.studentModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "studentHappening")
public class StudentHappeningVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int happenid;       //键id
    private int stuid;          //学生表外键
    private String happening;   //情况记录
    private Date optime;        //记录时间
    private int Empid;          //记录人，session获取id

    @Override
    public String toString() {
        return "StudentHappeningVo{" +
                "happenid=" + happenid +
                ", stuid=" + stuid +
                ", happening='" + happening + '\'' +
                ", optime=" + optime +
                ", Empid=" + Empid +
                '}';
    }

    public int getHappenid() {
        return happenid;
    }

    public void setHappenid(int happenid) {
        this.happenid = happenid;
    }

    public int getStuid() {
        return stuid;
    }

    public void setStuid(int stuid) {
        this.stuid = stuid;
    }

    public String getHappening() {
        return happening;
    }

    public void setHappening(String happening) {
        this.happening = happening;
    }

    public Date getOptime() {
        return optime;
    }

    public void setOptime(Date optime) {
        this.optime = optime;
    }

    public int getEmpid() {
        return Empid;
    }

    public void setEmpid(int empid) {
        Empid = empid;
    }
}
