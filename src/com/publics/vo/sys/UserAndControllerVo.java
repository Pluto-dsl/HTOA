package com.publics.vo.sys;

import javax.persistence.*;

@Entity
@Table(name = "uac")
public class UserAndControllerVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int uacId;
    private int characterId;//角色id
    private int empId;//员工id

    @Override
    public String toString() {
        return "UserAndControllerVo{" +
                "uacId=" + uacId +
                ", characterId=" + characterId +
                ", empId=" + empId +
                '}';
    }

    public int getUacId() {
        return uacId;
    }

    public void setUacId(int uacId) {
        this.uacId = uacId;
    }

    public int getCharacterId() {
        return characterId;
    }

    public void setCharacterId(int characterId) {
        this.characterId = characterId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }
}
