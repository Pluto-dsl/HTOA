package com.publics.vo.assess;

import javax.persistence.*;

/**
 *考核指标类别,不需要在界面实现，数据直接在数据库写死，表名
 * */

@Entity
@Table(name="aduitType")
public class AduitTypeVo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int aduitTypeid;//主键，标识列，自动生成
    private String aduitTypeName;//1:教研部，2：学工科，3：教师考评，4：班主任考评，5：招生就业，6.后勤，7：成人教育
    private int Depid;//关联部门表

    @Override
    public String toString() {
        return "AduitTypeVo{" +
                "aduitTypeid=" + aduitTypeid +
                ", aduitTypeName='" + aduitTypeName + '\'' +
                ", Depid=" + Depid +
                '}';
    }

    public int getAduitTypeid() {
        return aduitTypeid;
    }

    public void setAduitTypeid(int aduitTypeid) {
        this.aduitTypeid = aduitTypeid;
    }

    public String getAduitTypeName() {
        return aduitTypeName;
    }

    public void setAduitTypeName(String aduitTypeName) {
        this.aduitTypeName = aduitTypeName;
    }

    public int getDepid() {
        return Depid;
    }

    public void setDepid(int depid) {
        Depid = depid;
    }
}
