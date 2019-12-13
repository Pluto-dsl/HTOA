package com.publics.vo.sys;

import javax.persistence.*;

/**
 *
 * 系管理主要功能有新增系资料，修改系资料，删除系资料，查看系资料，系专业对应(系可以勾选专业)
 * */
@Entity
@Table(name = "dept")
public class DeptVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int deptid;//主键，标识列，自动生成
    private String deptName;//系名称
    private String remark;//说明


    public int getDeptid() {
        return deptid;
    }

    public void setDeptid(int deptid) {
        this.deptid = deptid;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
