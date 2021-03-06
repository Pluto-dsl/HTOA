package com.publics.vo.notice;

import javax.persistence.*;

@Entity
@Table(name = "recipient")
public class RecipientVo {//接收人


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int receiverId;//主键，标识列，自动生成
    private int noticeId;//关联管理通知公告
    private int receiver;//接收人
    private int isRead;//是否已读,1:已读,2:未读
    private int type;//1员工 2学生

    @Override
    public String toString() {
        return "RecipientVo{" +
                "receiverId=" + receiverId +
                ", noticeId=" + noticeId +
                ", receiver=" + receiver +
                ", isRead=" + isRead +
                ", type=" + type +
                '}';
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public int getReceiver() {
        return receiver;
    }

    public void setReceiver(int receiver) {
        this.receiver = receiver;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
