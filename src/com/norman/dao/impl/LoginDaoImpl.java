package com.norman.dao.impl;

import com.norman.dao.LoginDao;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class LoginDaoImpl implements LoginDao {
    @Resource
    private SessionFactory sessionFactory;

    private Session getSession(){
        return sessionFactory.openSession();
    }

    @Override
    public EmpVo empByAcc(String hql) {
        Session session = getSession();
        Query query = session.createQuery(hql);
        List<EmpVo> list = query.list();
        session.flush();
        session.close();
        for (EmpVo emp:
             list) {
            return emp;
        }
        return null;
    }

    @Override
    public StudentVo stuByAcc(String hql) {
        Session session = getSession();
        Query query = session.createQuery(hql);
        List<StudentVo> list = query.list();
        session.flush();
        session.close();
        for (StudentVo stu:
                list) {
            return stu;
        }
        return null;
    }
}
