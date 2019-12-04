package com.norman.service.impl;

import com.norman.service.Ljw_EmpService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.ChatRecordVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Ljw_EmpServiceImpl extends BaseDao implements Ljw_EmpService {
    @Override
    public List<ChatRecordVo> getChatRecordList() {
        return listByHql("FROM ChatRecordVo");
    }
}
