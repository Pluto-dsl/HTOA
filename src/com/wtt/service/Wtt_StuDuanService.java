package com.wtt.service;

import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.sys.DepVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface Wtt_StuDuanService {
    List<FeedbackVo> feedback( int currpage, int pagesize);
    //查询总行数
    int pagecount();
    //查询部门
    List<DepVo> dep();
    //新增学生问题反馈
    void add(FeedbackVo feedbackVo);
}