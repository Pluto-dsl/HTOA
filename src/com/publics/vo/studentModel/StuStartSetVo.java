package com.publics.vo.studentModel;

import javax.persistence.*;

@Entity
@Table(name = "studentSet")
public class StuStartSetVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int statusId;
    private String statusName;
//    状态名称：1意向学生、2预定报名学生、3试学学生、4在读学生、5、已毕业学生 6、退学
    private String remark;//说明

    @Override
    public String toString() {
        return "StuStartSetVo{" +
                "statusId=" + statusId +
                ", statusName='" + statusName + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
