package com.publics.dao;

import org.hibernate.*;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2019/10/21.
 */


@Transactional
public class BaseDao {
    @Resource
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.openSession();
    }

    /**
     * 查询列表(查询一个表的所有数据)
     *
     * @param hql
     * @return
     */
    public List listByHql(String hql) {
        Session session = getSession();
        List list = session.createQuery(hql).list();
        session.close();
        return list;
    }

    //HQL分页  (查一个表的所有字段分页)
    public List pageByHql(String hql, int currPage, int pageSize) {
        Session session = getSession();
        Query query = session.createQuery(hql);
        query.setFirstResult((currPage - 1) * pageSize);//开始行数 0  5  10
        query.setMaxResults(pageSize);//每页行数(每次查几行)   5  5   5
        List list = query.list();
        session.close();
        return list;
    }

    //SQL查询列表（连接多个表，筛选列时）
    public List listBySQL(String sql) {
        Session session = getSession();
        SQLQuery sqlquery = session.createSQLQuery(sql);
        sqlquery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);//把结果变形为 List<Map>
        List list = sqlquery.list();
        System.out.println("list:"+list);
        session.close();
        return list;
    }

    //SQL查询分页列表（一个表或连接多个表，筛选列时）
    public List pageBySQL(String sql, int currPage, int pageSize) {
        Session session = getSession();
        SQLQuery sqlquery =session .createSQLQuery(sql);
        sqlquery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);//把结果变形为 List<Map>
        sqlquery.setFirstResult((currPage - 1) * pageSize);//开始行数 0  5  10
        sqlquery.setMaxResults(pageSize);//每页行数(每次查几行)   5  5   5
        List list = sqlquery.list();
        session.close();
        return list;
    }

    /**
     * 三合一SQL执行(增删改)
     */
    public void executeSQL(String sql) {
        Session session =  getSession();
        SQLQuery sqlquery =session.createSQLQuery(sql);
        sqlquery.executeUpdate();
        session.close();
    }

    /**
     * SQL查询总行数
     */
    //select count(*) from newemp
    public int selTotalRow(String sql) {
        Session session = getSession();
        SQLQuery sqlquery = session.createSQLQuery(sql);
        int i = Integer.parseInt(sqlquery.uniqueResult()+"");
        session.close();
        return i;
    }

    /**
     * 保存对象
     * @param obj
     */
    public void addObject(Object obj) {
        Session session = getSession();
        session.save(obj);
        session.flush();
        session.close();
    }

    /**
     * 根据ID获取对象
     *
     * @param clazz
     * @param id
     * @return
     */
    public Object getObject(Class clazz, Integer id) {
        Session session = getSession();
        Object obj=  session.get(clazz, id);
        session.close();
        return obj;
    }

    /**
     * 修改对象
     *
     * @param obj
     */
    public void updObject(Object obj) {
        Session session = getSession();
        session.update(obj);
        session.flush();
        session.close();
    }

    /**
     * 删除对象
     *
     * @param obj
     */
    public void delObject(Object obj) {
        Session session = getSession();
        session.delete(obj);
        session.flush();
        session.close();
    }

}
