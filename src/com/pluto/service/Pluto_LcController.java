package com.pluto.service;

import com.publics.vo.sys.CharModuleVo;
import com.publics.vo.sys.CharactersVo;

import java.util.List;

public interface Pluto_LcController {
    List getListByHql(String hql);
    void addUser(CharactersVo charactersVo);
    void delUser(int id);
    Object getObj(Class c,int id);//获取对象
    boolean judge(int moduleId);
    void deleteCharModel(int moduleId);
    void addcharModule(CharModuleVo charModuleVo);
}
