package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.educ.TrialVo;
import com.wtt.service.Wtt_TrialService;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Wtt_TrialServiceImpl extends BaseDao implements Wtt_TrialService {

    @Override
    public List<TrialVo> trialvo(int currpage, int pagesize) {
        return pageByHql("from TrialVo",currpage,pagesize);
    }

    @Override
    public int pagecount() {
        return selTotalRow("select count(*) from weeklog");
    }
}
