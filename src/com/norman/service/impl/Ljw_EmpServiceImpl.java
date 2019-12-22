package com.norman.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.ChatRecordVo;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class Ljw_EmpServiceImpl extends BaseDao implements Ljw_EmpService {

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
    public JSONArray getChatData(HttpServletRequest request,int page,int limit) {
        JSONArray data = new JSONArray();
        String empName = request.getParameter("empName");
        String depIdStr = request.getParameter("depId");
        String startDay = request.getParameter("startDay");
        String endDay = request.getParameter("endDay");
        int depId;
        if ("".equals(depIdStr) || null == depIdStr){
            depId = 0;
        }else {
            depId = Integer.parseInt(depIdStr);
        }
        String hql = "FROM ChatRecordVo where 1=1";
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                 //System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                hql +=" and sayface in ("+empIds+")";
            }else {
                hql +=" and sayface in (0)";
            }
        }
        if (depId!=0){
            hql +=" and sayface in (SELECT empId FROM EmpVo where depId="+depId+")";
        }
        if (!("".equals(startDay) || null == startDay)){
            hql +=" and chatDate>='"+startDay+"'";
        }
        if (!("".equals(endDay) || null == endDay)){
            hql +=" and chatDate<='"+endDay+"'";
        }
         //System.out.println(hql);

        List<ChatRecordVo> list = pageByHql(hql,page,limit);
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
             //System.out.println(crJO);
            data.add(crJO);
        }
        return data;
    }

    @Override
    public void setChatRecord(ChatRecordVo vo) {
        updObject(vo);
    }

    @Override
    public JSONArray getWeekLogData(HttpServletRequest request, int page, int limit) {
        JSONArray data = new JSONArray();
        String empName = request.getParameter("empName");
        String depIdStr = request.getParameter("depId");
        int depId = 0;
        if ("".equals(depIdStr) || null == depIdStr){
            depId = 0;
        }else {
            depId = Integer.parseInt(depIdStr);
        }
        String startDay = request.getParameter("startDay");
        String endDay = request.getParameter("endDay");
        String hql = "FROM WeeklogVo where 1=1";
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                 //System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                hql +=" and sayface in ("+empIds+")";
            }else {
                hql +=" and sayface in (0)";
            }
        }
        if (depId!=0){
            hql +=" and Empid in (SELECT empId FROM EmpVo where depId="+depId+")";
        }
        if (!("".equals(startDay) || null == startDay)){
            hql +=" and Workday>='"+startDay+"'";
        }
        if (!("".equals(endDay) || null == endDay)){
            hql +=" and Workday<='"+endDay+"'";
        }
         //System.out.println(hql);
        List<WeeklogVo> list = pageByHql(hql,page,limit);
        for (WeeklogVo vo:list) {
            //查询员工姓名
            EmpVo emp = (EmpVo) getObject(EmpVo.class,vo.getEmpid());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            JSONObject wlJO = new JSONObject();
            wlJO.put("worklogid",vo.getWeeklogid());
            wlJO.put("empName",emp.getEmpName());
            wlJO.put("weekDay",sdf.format(vo.getWorkday()));
            wlJO.put("weekCur",vo.getWeekCur());
            wlJO.put("studentQuestion",vo.getStudentQuestion());
            wlJO.put("idea",vo.getIdea());
            wlJO.put("weekNext",vo.getWeekNext());
             //System.out.println(wlJO);
            data.add(wlJO);
        }
        return data;
    }

    @Override
    public int getWeekLogSize(HttpServletRequest request) {
        String empName = request.getParameter("empName");
        String depIdStr = request.getParameter("depId");
        int depId = 0;
        if ("".equals(depIdStr) || null == depIdStr){
            depId = 0;
        }else {
            depId = Integer.parseInt(depIdStr);
        }
         //System.out.println(depId);
        String startDay = request.getParameter("startDay");
        String endDay = request.getParameter("endDay");
        String hql = "select count(*) from WeeklogVo where 1=1";
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            String empIds = "";
            for (int id:
                    emps) {
                empIds +=+id+",";
            }
            empIds = empIds.substring(0,empIds.length()-1);
            hql +=" and Empid in ("+empIds+")";
        }
        if (depId!=0){
            hql +=" and Empid in (SELECT empId FROM EmpVo where depId="+depId+")";
        }
        if (!("".equals(startDay) || null == startDay)){
            hql +=" and Workday>='"+startDay+"'";
        }
        if (!("".equals(endDay) || null == endDay)){
            hql +=" and Workday<='"+endDay+"'";
        }
         //System.out.println(hql);
        return getCountByHql(hql);
    }

    @Override
    public JSONObject getWeekLog(int id) {
        WeeklogVo weeklogVo = (WeeklogVo) getObject(WeeklogVo.class,id);
        EmpVo empVo = (EmpVo) getObject(EmpVo.class,weeklogVo.getEmpid());
        DepVo dep = (DepVo) getObject(DepVo.class,empVo.getDepId());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("depName",dep.getDepName());
        jsonObject.put("empName",empVo.getEmpName());
        jsonObject.put("workDay",sdf.format(weeklogVo.getWorkday()));
        jsonObject.put("weekCur",weeklogVo.getWeekCur());
        jsonObject.put("studentQuestion",weeklogVo.getStudentQuestion());
        jsonObject.put("idea",weeklogVo.getIdea());
        jsonObject.put("weekNext",weeklogVo.getWeekNext());
        return jsonObject;
    }

    @Override
    public List<DepVo> getDepList() {
        return listByHql("from DepVo");
    }
}
