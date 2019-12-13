package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 * 学期管理主要功能有新增学期资料，修改学期资料，删除学期资料，查看学期资料,
 * */
@Entity
@Table(name = "term")
public class TermVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int termid;
    private String termName;
    private String remark;

    public int getTermid() {
        return termid;
    }

    public void setTermid(int termid) {
        this.termid = termid;
    }

    public String getTermName() {
        return termName;
    }

    public void setTermName(String termName) {
        this.termName = termName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "TermVo{" +
                "termid=" + termid +
                ", termName='" + termName + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
