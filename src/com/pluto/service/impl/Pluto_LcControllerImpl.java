package com.pluto.service.impl;

import com.pluto.service.Pluto_LcController;
import com.publics.dao.BaseDao;
import com.publics.vo.sys.CharactersVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Pluto_LcControllerImpl extends BaseDao implements Pluto_LcController {
    @Override
    public List getListByHql(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public void delUser(int id) {
        super.delObject(super.getObject(new CharactersVo().getClass(),id));
    }

    @Override
    public void addUser(CharactersVo charactersVo) {
        super.addObject(charactersVo);
    }
}
