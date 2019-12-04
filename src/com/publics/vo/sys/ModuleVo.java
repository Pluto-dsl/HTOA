package com.publics.vo.sys;

import javax.persistence.*;

/**
 * 系统权限管理
 * */

@Entity
@Table(name = "module")
public class ModuleVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int moduleId;//主键，标识列，自动生成
    private String moduleName;//权限名称
    private int root;//根节点
    private String controller;//访问控制器

    public ModuleVo() {

    }

    public ModuleVo(String moduleName, int root, String controller) {
        this.moduleName = moduleName;
        this.root = root;
        this.controller = controller;
    }

    @Override
    public String toString() {
        return "ModuleVo{" +
                "moduleId=" + moduleId +
                ", moduleName='" + moduleName + '\'' +
                ", root=" + root +
                ", controller='" + controller + '\'' +
                '}';
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public int getRoot() {
        return root;
    }

    public void setRoot(int root) {
        this.root = root;
    }

    public String getController() {
        return controller;
    }

    public void setController(String controller) {
        this.controller = controller;
    }
}
