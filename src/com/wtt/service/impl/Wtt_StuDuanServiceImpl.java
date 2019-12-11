package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_StuDuanService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class Wtt_StuDuanServiceImpl extends BaseDao implements Wtt_StuDuanService {

    @Override
    public List<FeedbackVo> feedback(int currpage, int pagesize) {
        return pageBySQL("select f.feedbackId,d.depName,f.empName,f.feedBackType,f.feedbackTime,f.Image,f.opinion,f.remark,f.status from feedback f left join dep d on f.depId = d.depid",currpage,pagesize);
    }

    @Override
    public int pagecount() {
        return selTotalRow("select count(*) from feedback");
    }

    @Override
    public List<DepVo> dep() {
        return listByHql("from DepVo");
    }

    @Override
    public void add(FeedbackVo feedbackVo) {
        addObject(feedbackVo);
    }
}