package com.publics.vo.sys;

import javax.persistence.*;

/**
 * 用户权限管理
 * */

@Entity
@Table(name = "charModule")
public class CharModuleVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int charModuleId;//主键，标识列，自动生成
    private int moduleId;//管理系统权限
    private int characterId;//关联角色表

    public CharModuleVo(){

    }

    public CharModuleVo(int moduleId, int characterId) {
        this.moduleId = moduleId;
        this.characterId = characterId;
    }

    @Override
    public String toString() {
        return "CharModuleVo{" +
                "charModuleId=" + charModuleId +
                ", moduleId=" + moduleId +
                ", characterId=" + characterId +
                '}';
    }

    public int getCharModuleId() {
        return charModuleId;
    }

    public void setCharModuleId(int charModuleId) {
        this.charModuleId = charModuleId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public int getCharacterId() {
        return characterId;
    }

    public void setCharacterId(int characterId) {
        this.characterId = characterId;
    }
}
