package com.publics.vo.file;

import javax.persistence.*;
import java.util.Date;

/**
 * 资料文档管理
 * */

@Entity
@Table(name = "dataDoc")
public class DataDocVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int docId;//主键，标识列，自动生成
    private String dataName;//资料名称
    private String url;//资料地址
    private Date opTime;//上传时间
    private String remark;//备注
    private int empId;//上传人员

    public DataDocVo(){

    }

    public DataDocVo(String dataName, String url, Date opTime, String remark, int empId) {
        this.dataName = dataName;
        this.url = url;
        this.opTime = opTime;
        this.remark = remark;
        this.empId = empId;
    }

    @Override
    public String toString() {
        return "DataDocVo{" +
                "docId=" + docId +
                ", dataName='" + dataName + '\'' +
                ", url='" + url + '\'' +
                ", opTime=" + opTime +
                ", remark='" + remark + '\'' +
                ", empId=" + empId +
                '}';
    }

    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
    }

    public String getDataName() {
        return dataName;
    }

    public void setDataName(String dataName) {
        this.dataName = dataName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }
}
