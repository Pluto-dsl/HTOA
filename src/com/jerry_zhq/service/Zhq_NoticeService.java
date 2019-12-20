package com.jerry_zhq.service;

import com.publics.vo.notice.NoticeVo;
import com.publics.vo.notice.RecipientVo;

import java.util.List;

public interface Zhq_NoticeService {
    //分页查询
    List selNotice(String hql, int page, int pageSize);
    //查询总条数
    int selCount();

    //添加
    void addNotice(NoticeVo noticeVo);
    //添加接收人
    void addRecipient(RecipientVo recipientVo);

    //根据id查询
    Object selNoticeId( Class clazz ,int noticeId);
    //修改
    void updateNotice(NoticeVo noticeVo);

    //删除
    void deleteNotice(NoticeVo noticeVo);
    void deleteRecipient(int noticeId);
    //查询员工总条数
    int selEmpCount();

    //查询学生总条数
    int selStuCount();

    //查询员工
    List selEmp();
    //查询学生
    List selStu();

    //根据用户id和公告id更改状态
    void updateType(int empId,int noticeId);
    //根据公告id查询已读的人数
    int trueCount(int noticeId);
    //根据公告id查询未读的人数
    int falseCount(int noticeId);

    //根据查询出来的已读未读人数修改Notice表中的已读未读人数
    void updateCountNotice(int trueCount,int falseCount,int noticeId);

    //根据id查询公告详情
    List selParticulars(int noticeId);

    //根据id查询是否未读公告
    List selTFParticulars(int empId);

    //查询多少条未读
    int selCountParticulars(int empId);
}
