package com.pluto.service.impl;

import com.pluto.service.Pluto_LcController;
import com.publics.dao.BaseDao;
import com.publics.vo.sys.CharModuleVo;
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
    public Object getObj(Class c, int id) {
        return super.getObject(c,id);
    }

    @Override
    public void deleteCharModel(int moduleId) {
        super.executeSQL("delete from charModule where characterId="+moduleId);
    }

    @Override
    public void addcharModule(CharModuleVo charModuleVo) {
        super.addObject(charModuleVo);
    }

    @Override
    public boolean judge(int moduleId) {
        List list = super.listByHql("from CharModuleVo where characterId="+moduleId);
        if(list.size()>0){
            return true;
        }
        return false;
    }

    @Override
    public void addUser(CharactersVo charactersVo) {
        super.addObject(charactersVo);
    }
}
