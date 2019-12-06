package com.norman.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.ChatRecordVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class Ljw_EmpServiceImpl extends BaseDao implements Ljw_EmpService {
    @Override
    public List<ChatRecordVo> getChatRecordList(int page,int limit) {
        return pageByHql("FROM ChatRecordVo",page,limit);
    }

    @Override
    public int getChatRecordSize() {
        return getCountByHql("select count(*) from ChatRecordVo");
    }

    @Override
    public void delChatRecord(int id) {
        ChatRecordVo chatRecordVo = new ChatRecordVo();
        chatRecordVo.setChatid(id);
        delObject(chatRecordVo);
    }

    @Override
    public void addChatRecord(ChatRecordVo vo) {
        addObject(vo);
    }

    @Override
    public List<EmpVo> getEmpList() {
        return listByHql("FROM EmpVo");
    }

    @Override
    public List<StudentVo> getStudentList() {
        return listByHql("FROM StudentVo");
    }

    @Override
    public JSONArray getData(int page,int limit) {
        JSONArray data = new JSONArray();
        List<ChatRecordVo> list = pageByHql("FROM ChatRecordVo",page,limit);
        for (ChatRecordVo chatRecordVo:list) {
            EmpVo emp = (EmpVo) getObject(EmpVo.class,chatRecordVo.getTeacher());
            StudentVo stu = (StudentVo) getObject(StudentVo.class,chatRecordVo.getSayface());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            JSONObject crJO = new JSONObject();
            crJO.put("chatId",chatRecordVo.getChatid());
            crJO.put("sayFace",stu.getStuname());
            crJO.put("teacher",emp.getEmpName());
            crJO.put("chatDate",sdf.format(chatRecordVo.getChatDate()));
            crJO.put("addr",chatRecordVo.getAddr());
            crJO.put("sayscon",chatRecordVo.getSayscon());
            System.out.println(crJO);
            data.add(crJO);
        }
        return data;
    }

    @Override
    public void setChatRecord(ChatRecordVo vo) {
        updObject(vo);
    }
}
