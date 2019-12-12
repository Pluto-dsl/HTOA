package com.publics.vo.file;

import javax.persistence.*;
import java.util.Date;

/**
 * 附件表
 * */
@Entity
@Table(name = "annex")
public class AnnexVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int annexId;//主键，标识列，自动生成
    private int seName;//类型选择(1:员工,2:学生)
    private int seId;//关联员工或者学生ID
    private String  annexName;//附件名称
    private String annexPath;//上传附件路径
    private Date annexDate;//上传时间
    private String remark;//说明
    private String sessionName;//上传人


    public int getAnnexId() {
        return annexId;
    }

    public void setAnnexId(int annexId) {
        this.annexId = annexId;
    }

    public int getSeName() {
        return seName;
    }

    public void setSeName(int seName) {
        this.seName = seName;
    }

    public int getSeId() {
        return seId;
    }

    public void setSeId(int seId) {
        this.seId = seId;
    }

    public String getAnnexName() {
        return annexName;
    }

    public void setAnnexName(String annexName) {
        this.annexName = annexName;
    }

    public String getAnnexPath() {
        return annexPath;
    }

    public void setAnnexPath(String annexPath) {
        this.annexPath = annexPath;
    }

    public Date getAnnexDate() {
        return annexDate;
    }

    public void setAnnexDate(Date annexDate) {
        this.annexDate = annexDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    @Override
    public String toString() {
        return "AnnexVo{" +
                "annexId=" + annexId +
                ", seName='" + seName + '\'' +
                ", seId='" + seId + '\'' +
                ", annexName='" + annexName + '\'' +
                ", annexPath='" + annexPath + '\'' +
                ", annexDate=" + annexDate +
                ", remark='" + remark + '\'' +
                ", sessionName='" + sessionName + '\'' +
                '}';
    }
}
