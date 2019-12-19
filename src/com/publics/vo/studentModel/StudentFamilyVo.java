package com.publics.vo.studentModel;


import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "studentFamily")
public class StudentFamilyVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int familyid;
    private int stuid;
    private String familyname;
    private String relation;
    private String familyhone;

    @Override
    public String toString() {
        return "StudentFamilyVo{" +
                "familyid=" + familyid +
                ", stuid=" + stuid +
                ", familyname='" + familyname + '\'' +
                ", relation='" + relation + '\'' +
                ", familyhone='" + familyhone + '\'' +
                '}';
    }

    public int getFamilyid() {
        return familyid;
    }

    public void setFamilyid(int familyid) {
        this.familyid = familyid;
    }

    public int getStuid() {
        return stuid;
    }

    public void setStuid(int stuid) {
        this.stuid = stuid;
    }

    public String getFamilyname() {
        return familyname;
    }

    public void setFamilyname(String familyname) {
        this.familyname = familyname;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getFamilyhone() {
        return familyhone;
    }

    public void setFamilyhone(String familyhone) {
        this.familyhone = familyhone;
    }
}
