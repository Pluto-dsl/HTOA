package com.publics.vo.logistics;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="equipmentRepair")
public class EquipmentRepairVo {//维修设备申请

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int equipmentId;//主键，标识列，自动生成
    private String  equipmentType;//维修设备名称
    private int  status;//维修状态0未完成,1已完成
    private int userType;//1学生 2员工
    private int Classes;//关联班级表主键
    private int depId;//部门
    private int Student;//关联学生表申请人
    private String remark;//描述
    private Date startTime;//申请时间
    private Date endTime;//处理时间
    private int empId;//处理人
    private String result;//处理结果

    @Override
    public String toString() {
        return "EquipmentRepairVo{" +
                "equipmentId=" + equipmentId +
                ", equipmentType='" + equipmentType + '\'' +
                ", status=" + status +
                ", userType=" + userType +
                ", Classes=" + Classes +
                ", depId=" + depId +
                ", Student=" + Student +
                ", remark='" + remark + '\'' +
                ", empId=" + empId +
                ", result='" + result + '\'' +
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

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public int getClasses() {
        return Classes;
    }

    public void setClasses(int classes) {
        Classes = classes;
    }

    public int getDepId() {
        return depId;
    }

    public void setDepId(int depId) {
        this.depId = depId;
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

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
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
