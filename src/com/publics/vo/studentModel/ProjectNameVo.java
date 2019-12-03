package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 *      项目答辩名称表
 * */

@Entity
@Table(name = "project")
public class ProjectNameVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int projectId;//主键，标识列，自动生成
    private String projectName;//项目名称
    private String remark;//说明

    public ProjectNameVo(int projectId,String projectName, String remark) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.remark = remark;
    }

    public ProjectNameVo() {}

    @Override
    public String toString() {
        return "ProjectNameVo{" +
                "projectId=" + projectId +
                ", projectName='" + projectName + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }

    public int getProjectId() {
        return projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public String getRemark() {
        return remark;
    }
}