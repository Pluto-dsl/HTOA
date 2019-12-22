package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_NoticeService;
import com.publics.dao.BaseDao;
import com.publics.vo.notice.NoticeVo;
import com.publics.vo.notice.RecipientVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Zhq_NoticeServiceImpl extends BaseDao implements Zhq_NoticeService {
    //分页查询
    @Override
    public List selNotice(String hql, int page, int pageSize) {
        return  pageByHql(hql,page,pageSize);
    }

    //查询总条数
    @Override
    public int selCount() {
        return selTotalRow("select count(*) from notice");
    }

    //添加
    @Override
    public void addNotice(NoticeVo noticeVo) {
        addObject(noticeVo);
    }
    //添加接收人
    @Override
    public void addRecipient(RecipientVo recipientVo) {
        addObject(recipientVo);
    }

    //根据id查询
    @Override
    public Object selNoticeId(Class clazz,int noticeId) {
        return getObject(clazz,noticeId);
    }

    //修改
    @Override
    public void updateNotice(NoticeVo noticeVo) {
        updObject(noticeVo);
    }

    //删除
    @Override
    public void deleteNotice(NoticeVo noticeVo) {
        delObject(noticeVo);
    }

    @Override
    public void deleteRecipient(int noticeId) {
        executeSQL("delete  from recipient where noticeId ="+noticeId);
    }

    //查询员工总条数
    @Override
    public int selEmpCount() {
        return selTotalRow("select count(*) from emp");
    }
    //查询学生总条数
    @Override
    public int selStuCount() {
        return selTotalRow("select count(*) from student");
    }

    //查询员工
    @Override
    public List selEmp() {
        return listByHql("from EmpVo");
    }
    //查询学生
    @Override
    public List selStu() {
        return listByHql("from StudentVo");
    }

    //根据用户id和公告id更改状态
    @Override
    public void updateType(int empId, int noticeId) {
        executeSQL("update recipient set isRead=1 where type=1 and receiver="+empId+" and noticeId="+noticeId);
    }

    //根据公告id查询已读的人数
    @Override
    public int trueCount(int noticeId) {
        return selTotalRow("select count(*) from recipient where type=1 and isRead=1 and noticeId="+noticeId);
    }
    //根据公告id查询未读的人数
    @Override
    public int falseCount(int noticeId) {
        return selTotalRow("select count(*) from recipient where type=1 and isRead=2 and noticeId="+noticeId);
    }

    //根据查询出来的已读未读人数修改Notice表中的已读未读人数
    @Override
    public void updateCountNotice(int trueCount, int falseCount,int noticeId) {
        executeSQL("update notice set trueContent="+trueCount+",falseContent="+falseCount+" where noticeId="+noticeId);
    }
    //根据id查询公告详情
    @Override
    public List selParticulars(int noticeId) {
        return listBySQL("select  e.empName as js,n.title,n.empid,n.noticeTime,r.receiver,r.isRead from notice n\n" +
                "left join recipient r on n.noticeId=r.noticeId \n" +
                "left join emp e on r.receiver = e.empid where n.noticeId ="+noticeId + " and type=1");
    }

    @Override
    public List selParticulars2(int noticeId) {
        return listBySQL("select  s.stuname as js,n.title,n.empid,n.noticeTime,r.receiver,r.isRead from notice n\n" +
                "left join recipient r on n.noticeId=r.noticeId \n" +
                "left join student s on  r.receiver=s.Studid\n" +
                "where n.noticeId ="+noticeId+" and type=2");
    }

    //根据id查询是否未读公告
    @Override
    public List selTFParticulars(int empId) {
        return listBySQL("select n.noticeId ,n.content,n.empid ,n.noticeTime,n.noticeType,n.title,r.receiver from notice n left join recipient r on n.noticeId=r.noticeId where r.receiver="+empId+ " and r.type=1 and isRead=2 ");
    }

    @Override
    public int selCountParticulars(int empId) {
        return selTotalRow("select count(*) fl  from notice n left join recipient r on n.noticeId=r.noticeId where r.receiver="+empId+ " and r.type=1 and isRead=2");
    }


}
