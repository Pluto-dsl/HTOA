package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 * 届别管理
 * */
@Entity
@Table(name = "studentFall")
public class StudentFallVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int fallid;//主键
    private String level;//届别名称
    private String remark;//说明

    public int getFallid() {
        return fallid;
    }

    public void setFallid(int fallid) {
        this.fallid = fallid;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
