package com.norman.dao.impl;

import com.norman.dao.Ljw_TongYongDao;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class Ljw_TongYongDaoimpl implements Ljw_TongYongDao {
    @Resource
    private SessionFactory sessionFactory;

    private Session getSession(){
        return sessionFactory.openSession();
    }


    @Override
    public List<Integer> getStuNames(String stuName) {
        Session session = getSession();
        SQLQuery sqlQuery = session.createSQLQuery("select Studid from student where stuname like '%"+stuName+"%'");
        List<Integer> list = sqlQuery.list();
        session.close();
        return list;
    }
}
