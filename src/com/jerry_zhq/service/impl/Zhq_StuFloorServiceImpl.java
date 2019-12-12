package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_StuFloorService;
import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Zhq_StuFloorServiceImpl extends BaseDao implements Zhq_StuFloorService {

    //分页查询
    @Override
    public List selFloor(String hql,int page,int pageSize) {
        return pageByHql(hql,page,pageSize);
    }

    //查询总行数
    @Override
    public int selCount() {
        return selTotalRow("select count(*) from studentFloor");
    }

    //删除
    @Override
    public void deleteStuBiu(StudntBuildingVo studntBuildingVoId) {
        delObject(studntBuildingVoId);
    }

    //添加
    @Override
    public void addStuBiu(StudntBuildingVo studntBuildingVo) {
        addObject(studntBuildingVo);
    }




}
