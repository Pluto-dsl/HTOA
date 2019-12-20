package com.pluto.service;

import com.publics.vo.sys.CharactersVo;

import java.util.List;

public interface Pluto_LcController {
    List getListByHql(String hql);
    void addUser(CharactersVo charactersVo);
    void delUser(int id);
}
