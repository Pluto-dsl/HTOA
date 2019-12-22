package com.pluto.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.pluto.service.Pluto_LcController;
import com.publics.dao.BaseDao;
import com.publics.vo.sys.CharModuleVo;
import com.publics.vo.sys.CharactersVo;
import com.publics.vo.sys.UserAndControllerVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Pluto_LcControllerImpl extends BaseDao implements Pluto_LcController {
    @Override
    public List getListByHql(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public JSONArray getUAC(int id) {
        List list = super.listByHql("from UserAndControllerVo where characterId="+id);

        JSONArray j = new JSONArray();
        for (int i = 0; i < list.size(); i++) {
            UserAndControllerVo u = (UserAndControllerVo) list.get(i);
            j.add(u.getEmpId());
        }
        return j;
    }

    @Override
    public void deleteUAC(int mid) {
        super.executeSQL("delete from uac where characterId="+mid);
    }

    @Override
    public List getControllerList(int id) {
        String sql = "select controller from module where moduleId not in (select m.moduleId from uac u " +
                " INNER JOIN charModule c on u.characterId = c.characterId" +
                " INNER JOIN module m on m.moduleId = c.moduleId" +
                " where u.empId = "+id+")";
        System.out.println(sql);
        List list = super.listBySQL(sql);
        return list;
    }

    @Override
    public List getControllerList2() {
        List list = super.listBySQL("select controller from module where moduleId not in (select m.moduleId from uac u \n" +
                "\t\tINNER JOIN\tcharModule c on u.characterId = c.characterId\n" +
                "\t\tINNER JOIN  module m on m.moduleId = c.moduleId");
        return list;
    }

    @Override
    public boolean judgeUser(int mid) {

        List list = super.listByHql("from UserAndControllerVo where characterId="+mid);
        if(list.size()>0){
            return true;
        }
        return false;
    }

    @Override
    public void addObject(Object o) {
        super.addObject(o);
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
