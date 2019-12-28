package com.publics.vo.empModel.emp;

import javax.persistence.*;

/**
 * 岗位设置
 * */
@Entity
@Table(name = "post")
public class PostVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int postId;//主键，标识列，自动生成
    private String postName;//岗位名称
    private String  remark;//备注

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public PostVo(int postId,String postName, String remark) {
        this.postId = postId;
        this.postName = postName;
        this.remark = remark;
    }
    public PostVo() {
    }


    @Override
    public String toString() {
        return "postVo{" +
                "postId=" + postId +
                ", postName='" + postName + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
