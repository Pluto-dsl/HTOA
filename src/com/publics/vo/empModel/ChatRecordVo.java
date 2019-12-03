package com.publics.vo.empModel;

import javax.persistence.*;

/**
 * 谈心记录，记录任课老师每个月跟学生谈心的情况，表名：chatRecord
 * */

@Entity
@Table(name = "chatRecord")
public class ChatRecordVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Chatid;//谈心主键id
    private int sayface;//学生表外键
    private int teacher;//员工表外键
    private String addr;//地址
    private String sayscon;//谈心内容

    public int getChatid() {
        return Chatid;
    }

    public void setChatid(int chatid) {
        Chatid = chatid;
    }

    public int getSayface() {
        return sayface;
    }

    public void setSayface(int sayface) {
        this.sayface = sayface;
    }

    public int getTeacher() {
        return teacher;
    }

    public void setTeacher(int teacher) {
        this.teacher = teacher;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getSayscon() {
        return sayscon;
    }

    public void setSayscon(String sayscon) {
        this.sayscon = sayscon;
    }

    @Override
    public String toString() {
        return "ChatRecordVo{" +
                "Chatid=" + Chatid +
                ", sayface=" + sayface +
                ", teacher=" + teacher +
                ", addr='" + addr + '\'' +
                ", sayscon='" + sayscon + '\'' +
                '}';
    }
}
