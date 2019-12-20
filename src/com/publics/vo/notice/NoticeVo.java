package com.publics.vo.notice;

import javax.persistence.*;
import java.util.Date;

/**
 * 通知公告管理
 *  公告通知明细表
 * */
@Entity
@Table(name = "notice")
public class NoticeVo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int noticeId;//主键，标识列，自动生成
    private String title;//标题
    private String content;//通知内容
    private int noticeType;//类型;1:所有人，2员工 3学生
    private String empid;//发布人
    private Date noticeTime;//发布时间
    private int trueContent;//已读
    private int falseContent;//未读

    @Override
    public String toString() {
        return "NoticeVo{" +
                "noticeId=" + noticeId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", noticeType=" + noticeType +
                ", empid='" + empid + '\'' +
                ", noticeTime=" + noticeTime +
                ", trueContent=" + trueContent +
                ", falseContent=" + falseContent +
                '}';
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getNoticeType() {
        return noticeType;
    }

    public void setNoticeType(int noticeType) {
        this.noticeType = noticeType;
    }

    public String getEmpid() {
        return empid;
    }

    public void setEmpid(String empid) {
        this.empid = empid;
    }

    public Date getNoticeTime() {
        return noticeTime;
    }

    public void setNoticeTime(Date noticeTime) {
        this.noticeTime = noticeTime;
    }

    public int getTrueContent() {
        return trueContent;
    }

    public void setTrueContent(int trueContent) {
        this.trueContent = trueContent;
    }

    public int getFalseContent() {
        return falseContent;
    }

    public void setFalseContent(int falseContent) {
        this.falseContent = falseContent;
    }
}
