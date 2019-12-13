package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_StuDuanService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service
public class Wtt_StuDuanServiceImpl extends BaseDao implements Wtt_StuDuanService {

    @Override
    public List<FeedbackVo> feedback(int currpage, int pagesize) {
        return pageBySQL("select f.feedbackId,s.stuname,d.depName,f.empName,f.feedBackType,f.feedbackTime,f.Image,f.opinion,f.remark,f.status from feedback f left join dep d on f.depId = d.depid\n" +
                "left join student s on s.Studid = f.empId",currpage,pagesize);
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
    @Override
    public Map student(String name) {
        String sql = "select s.Studid,c.className from student s \n" +
                "left join studentClass c on s.clazz = c.classId\n" +
                "where s.intrphone = '"+name+"'";
        System.out.println(sql);
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map;
        }
        return null;
    }
}