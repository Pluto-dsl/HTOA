package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 *   宿舍管理：
 *       在此菜单维护学校的学生寝室，实现增删改查的功能，并且在菜单的导航位置添加一个按钮，分配学生寝室。
 *       点击此按钮以弹出窗口的显示展示出所有的学生(要求必须用分页显示)。可以选择一个或多个学生的，点击确定按钮后把学生分配到该寝室
 * */
@Entity
@Table(name = "studentHuor")
public class StudentDormitoryVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Hourid;//宿舍主键id
    private String huorName;//宿舍房号(508)
    private String addr;//宿舍地址
    private int count;//宿舍人数
    private int floorId;//楼栋id外键
    private int numberBeds;//床位数
    private int huoeIddsc;//序号

    public StudentDormitoryVo(int Hourid,String huorName, String addr, int count, int floorId, int numberBeds, int huoeIddsc) {
        this.Hourid = Hourid;
        this.huorName = huorName;
        this.addr = addr;
        this.count = count;
        this.floorId = floorId;
        this.numberBeds = numberBeds;
        this.huoeIddsc = huoeIddsc;
    }


    public StudentDormitoryVo(){}

    public int getHourid() {
        return Hourid;
    }

    public void setHourid(int hourid) {
        Hourid = hourid;
    }

    public String getHuorName() {
        return huorName;
    }

    public void setHuorName(String huorName) {
        this.huorName = huorName;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
    }

    public int getNumberBeds() {
        return numberBeds;
    }

    public void setNumberBeds(int numberBeds) {
        this.numberBeds = numberBeds;
    }

    public int getHuoeIddsc() {
        return huoeIddsc;
    }

    public void setHuoeIddsc(int huoeIddsc) {
        this.huoeIddsc = huoeIddsc;
    }

    @Override
    public String toString() {
        return "StudentDormitoryVo{" +
                "Hourid=" + Hourid +
                ", huorName='" + huorName + '\'' +
                ", addr='" + addr + '\'' +
                ", count=" + count +
                ", floorId=" + floorId +
                ", numberBeds=" + numberBeds +
                ", huoeIddsc=" + huoeIddsc +
                '}';
    }
}