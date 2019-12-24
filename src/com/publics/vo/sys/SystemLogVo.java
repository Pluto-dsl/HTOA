package com.publics.vo.sys;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "systemLog")
public class SystemLogVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int logId;      //主键，标识列，自动生成
    int empId;      //关联员工表主键
    String ipAddr;      //Ip地址
    Date optime;        //操作时间
    String tables;      //操作的数据表
    String msg;     //操作内容

    @Override
    public String toString() {
        return "SystemLogVo{" +
                "logId=" + logId +
                ", empId=" + empId +
                ", ipAddr='" + ipAddr + '\'' +
                ", optime=" + optime +
                ", tables='" + tables + '\'' +
                ", msg='" + msg + '\'' +
                '}';
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getIpAddr() {
        return ipAddr;
    }

    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

    public Date getOptime() {
        return optime;
    }

    public void setOptime(Date optime) {
        this.optime = optime;
    }

    public String getTables() {
        return tables;
    }

    public void setTables(String tables) {
        this.tables = tables;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
