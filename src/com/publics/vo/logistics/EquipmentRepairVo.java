package com.publics.vo.logistics;

import org.joda.time.DateTime;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="equipmentRepair")
public class EquipmentRepairVo {//维修设备申请

    @Id
    @GeneratedValue(strategy= GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name="tableGenerator",initialValue=0,allocationSize=1)


    private int equipmentId;//主键，标识列，自动生成
    private String  equipmentType;//维修设备名称
    private int  status;//维修状态0未完成,1已完成
    private int Classes;//关联班级表主键
    private int Student;//关联学生表申请人
    private String remark;//备注
    private int depId;//部门
    private int userType;//1学生 2员工
    private Date startTime;//开始时间
    private Date endTime;

    @Override
    public String toString() {
        return "EquipmentRepair{" +
                "equipmentId=" + equipmentId +
                ", equipmentType='" + equipmentType + '\'' +
                ", status=" + status +
                ", Classes=" + Classes +
                ", Student=" + Student +
                ", remark='" + remark + '\'' +
                ", depId=" + depId +
                ", userType=" + userType +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClasses() {
        return Classes;
    }

    public void setClasses(int classes) {
        Classes = classes;
    }

    public int getStudent() {
        return Student;
    }

    public void setStudent(int student) {
        Student = student;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getDepId() {
        return depId;
    }

    public void setDepId(int depId) {
        this.depId = depId;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
