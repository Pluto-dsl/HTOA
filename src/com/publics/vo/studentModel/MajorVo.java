package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 *      专业表
 *          专业设置(待定只有一个专业)
 * */

@Entity
@Table(name = "major")
public class MajorVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int majorid;//主键，标识列，自动生成
    private String majorName;//专业名称
    private String deptid;//系id
    private String remark;//说明


    public MajorVo() {}

    @Override
    public String toString() {
        return "MajorVo{" +
                "majorid=" + majorid +
                ", majorName='" + majorName + '\'' +
                ", deptid='" + deptid + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public int getMajorid() {
        return majorid;
    }

    public void setMajorid(int majorid) {
        this.majorid = majorid;
    }

    public String getDeptid() {
        return deptid;
    }

    public void setDeptid(String deptid) {
        this.deptid = deptid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

}