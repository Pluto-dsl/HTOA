package com.publics.vo.empModel.emp;

import javax.persistence.*;

@Entity
@Table(name = "familyInfo")
public class FamilyInfoVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int familyid;//主键，标识列，自动生成
    private String Empid;//关联Emp表empid字段
    private String contactName;//联系人名称
    private String relationship;//与员工关系
    private String Phone;//联系电话
    private String Remark;//说明


    public int getFamilyid() {
        return familyid;
    }

    public void setFamilyid(int familyid) {
        this.familyid = familyid;
    }

    public String getEmpid() {
        return Empid;
    }

    public void setEmpid(String empid) {
        Empid = empid;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String phone) {
        Phone = phone;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    @Override
    public String toString() {
        return "FamilyInfoVo{" +
                "familyid=" + familyid +
                ", Empid='" + Empid + '\'' +
                ", contactName='" + contactName + '\'' +
                ", relationship='" + relationship + '\'' +
                ", Phone='" + Phone + '\'' +
                ", Remark='" + Remark + '\'' +
                '}';
    }
}
