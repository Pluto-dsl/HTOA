package com.publics.vo.studentModel;

import javax.persistence.*;

/**
 *   楼栋维护:
 *      在此菜单维护学校的学生寝室的楼栋，
 *      包括楼层编号，楼层名称，楼层具体位置，以及宿舍管理员姓名，实现增删改查的功能
 * */
@Entity
@Table(name = "studentFloor")
public class StudntBuildingVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int floorId;//楼栋主键id
    private String floorName;//楼栋名称

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
    }

    public String getFloorName() {
        return floorName;
    }

    public void setFloorName(String floorName) {
        this.floorName = floorName;
    }

    public StudntBuildingVo(int floorId,String floorName) {
        this.floorId = floorId;
        this.floorName = floorName;
    }

    public StudntBuildingVo() {}

    @Override
    public String toString() {
        return "StudntBuildingVo{" +
                "floorId=" + floorId +
                ", floorName='" + floorName + '\'' +
                '}';
    }
}