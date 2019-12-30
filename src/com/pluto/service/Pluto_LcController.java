package com.pluto.service;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.sys.CharModuleVo;
import com.publics.vo.sys.CharactersVo;

import java.util.List;

public interface Pluto_LcController {
    List getListByHql(String hql);
    List getListBySql(String sql);
    void addUser(CharactersVo charactersVo);
    void delUser(int id);
    Object getObj(Class c,int id);//获取对象
    boolean judge(int moduleId);
    void deleteCharModel(int moduleId);
    void addcharModule(CharModuleVo charModuleVo);
    void addObject(Object o);
    boolean judgeUser(int mid);
    void deleteUAC(int mid);
    JSONArray getUAC(int id);
//    _________________
    List getControllerList(int id);
    List getControllerList2();
//    List getController();
}
