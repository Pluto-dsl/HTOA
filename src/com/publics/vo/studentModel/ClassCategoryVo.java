package com.publics.vo.studentModel;

import javax.persistence.*;
/**
 *      班级类别表
 * */
@Entity
@Table(name = "classType")
public class ClassCategoryVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int classTypeId;//主键，标识列，自动生成
    private String classTypeName;//1：高技，2：中技，3:3+2,4：成人教育

    public ClassCategoryVo(int classTypeId,String classTypeName) {
        this.classTypeId = classTypeId;
        this.classTypeName = classTypeName;
    }

    public ClassCategoryVo() {}

    public int getClassTypeId() {
        return classTypeId;
    }

    public void setClassTypeId(int classTypeId) {
        this.classTypeId = classTypeId;
    }

    public String getClassTypeName() {
        return classTypeName;
    }

    public void setClassTypeName(String classTypeName) {
        this.classTypeName = classTypeName;
    }

    @Override
    public String toString() {
        return "ClassCategoryVo{" +
                "classTypeId=" + classTypeId +
                ", classTypeName='" + classTypeName + '\'' +
                '}';
    }
}