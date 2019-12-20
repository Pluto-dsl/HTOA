package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_NoticeService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.notice.NoticeVo;
import com.publics.vo.notice.RecipientVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/zhq")
public class Zhq_NoticeController {

    @Resource
    Zhq_NoticeService zhq_noticeService;

    @RequestMapping("/Notice")
    public String toNotice(){
        return "/notice_zhq/selNotice";
    }

    @RequestMapping("/selNotice")
    @ResponseBody//查询
    public JSONObject selNotice(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        String hql = "from NoticeVo";
        List<NoticeVo> noticeVoList = zhq_noticeService.selNotice(hql,page,limit);

        for(NoticeVo noticeVo:noticeVoList){
            Map map = new HashMap();
            map.put("noticeId",noticeVo.getNoticeId());//主键
            map.put("title",noticeVo.getTitle());//标题
            map.put("content",noticeVo.getContent());//通知内容
            map.put("empid",noticeVo.getEmpid());//发布人
            map.put("noticeTime",noticeVo.getNoticeTime());//发布时间
            map.put("trueContent",noticeVo.getTrueContent());//已读
            map.put("falseContent",noticeVo.getFalseContent());//未读

            noticeVo.getContent();//内容
            if(noticeVo.getNoticeType() == 1){//类型;1:所有人，2员工 3学生
                map.put("noticeType","所有人");
            }else if(noticeVo.getNoticeType() == 2){
                map.put("noticeType","员工");
            }else if(noticeVo.getNoticeType() == 3){
                map.put("noticeType","学生");
            }
            jsonArray.add(map);
        }
        int count = zhq_noticeService.selCount();

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }


    //点击了添加按钮
    @RequestMapping("/addNotice")
    public String toAddNotice(HttpSession session, NoticeVo noticeVo,HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        //NoticeType类型;1:所有人，2员工 3学生
        EmpVo empVo = (EmpVo) session.getAttribute("admin");//员工

        noticeVo.setNoticeTime(new Date());//时间
        noticeVo.setEmpid(empVo.getEmpName());//发布人
        noticeVo.setTrueContent(0);//已读


        List<EmpVo> empVoList = zhq_noticeService.selEmp();//查询员工
        List<StudentVo> studentVoList = zhq_noticeService.selStu();//查询学生

        int empCount = zhq_noticeService.selEmpCount();//查询员工总条数
        int stuCount = zhq_noticeService.selStuCount();//查询学生总条数

        if(noticeVo.getNoticeType() ==1){//所有人
           int all = empCount+stuCount;
           noticeVo.setFalseContent(all-1);//未读
           zhq_noticeService.addNotice(noticeVo);

            for (EmpVo e:empVoList){//员工
                if(e.getEmpId() ==empVo.getEmpId()){
                    continue;
                }
                RecipientVo recipientVo = new RecipientVo();
                recipientVo.setIsRead(2);//1.已读，2未读
                recipientVo.setType(1);//1员工 2学生
                recipientVo.setReceiver(e.getEmpId());//接收人
                recipientVo.setNoticeId(noticeVo.getNoticeId());
                zhq_noticeService.addRecipient(recipientVo);//添加
            }
            for (StudentVo s:studentVoList){//学生
                RecipientVo recipientVo = new RecipientVo();
                recipientVo.setIsRead(2);//1.已读，2未读
                recipientVo.setType(2);//1员工 2学生
                recipientVo.setReceiver(s.getStudid());//接收人
                recipientVo.setNoticeId(noticeVo.getNoticeId());
                zhq_noticeService.addRecipient(recipientVo);//添加
            }

        }else if(noticeVo.getNoticeType() ==2){//员工
            noticeVo.setFalseContent(empCount-1);//未读
            zhq_noticeService.addNotice(noticeVo);

            for (EmpVo e:empVoList){
                 if(e.getEmpId() ==empVo.getEmpId()){
                     continue;
                 }
                RecipientVo recipientVo = new RecipientVo();
                recipientVo.setIsRead(2);//1.已读，2未读
                recipientVo.setType(1);//1员工 2学生
                recipientVo.setReceiver(e.getEmpId());//接收人
                recipientVo.setNoticeId(noticeVo.getNoticeId());
                zhq_noticeService.addRecipient(recipientVo);//添加
            }

        }else if(noticeVo.getNoticeType() ==3){//学生
            noticeVo.setFalseContent(stuCount-1);//未读
            zhq_noticeService.addNotice(noticeVo);

            for (StudentVo s:studentVoList){
                RecipientVo recipientVo = new RecipientVo();
                recipientVo.setIsRead(2);//1.已读，2未读
                recipientVo.setType(2);//1员工 2学生
                recipientVo.setReceiver(s.getStudid());//接收人
                recipientVo.setNoticeId(noticeVo.getNoticeId());
                zhq_noticeService.addRecipient(recipientVo);//添加
            }

        }
        return "redirect:/zhq/Notice";
    }


    //查看公告
    @RequestMapping("/LookNotice")
    public String LookNotice(int noticeId,HttpServletRequest request){
        NoticeVo noticeVo = new NoticeVo();
        NoticeVo noticeVo1 = (NoticeVo) zhq_noticeService.selNoticeId(noticeVo.getClass(),noticeId);
        noticeVo1.getNoticeTime();
        System.out.println(noticeVo1.getNoticeTime());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String noticeTime = simpleDateFormat.format(noticeVo1.getNoticeTime());
        request.setAttribute("noticeTime",noticeTime);
        request.setAttribute("LookNotice",noticeVo1);
        return "/notice_zhq/lookNotice";
    }

    //点击了修改
    @RequestMapping("/updateeNotice")
    public String updateNotice(int noticeId,HttpServletRequest request){
        NoticeVo noticeVo = new NoticeVo();
        NoticeVo noticeVo1 = (NoticeVo) zhq_noticeService.selNoticeId(noticeVo.getClass(),noticeId);
        request.setAttribute("notice",noticeVo1);
        return "/notice_zhq/updateNotice";
    }


    //确定修改
    @RequestMapping("/toUpdateNotice")
    @ResponseBody
    public String toUpdateNotice(NoticeVo noticeVo,String time) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date noticeTime = simpleDateFormat.parse(time);
        noticeVo.setNoticeTime(noticeTime);
        zhq_noticeService.updateNotice(noticeVo);
        return "success";
    }


    //删除
    @RequestMapping("/deleteNotice")
    @ResponseBody
    public String delDept(int noticeId){
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setNoticeId(noticeId);
        zhq_noticeService.deleteNotice(noticeVo);
        zhq_noticeService.deleteRecipient(noticeId);
        return "success";
    }

    //修改已读状态
    @RequestMapping("/updateType")
    @ResponseBody
    public String EmpNoticeReceiptList(HttpSession session,String noticeId){
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        zhq_noticeService.updateType(empVo.getEmpId(),Integer.parseInt(noticeId));//更改状态

        int trueCount = zhq_noticeService.trueCount(Integer.parseInt(noticeId));
        int falseCount =zhq_noticeService.falseCount(Integer.parseInt(noticeId));
        zhq_noticeService.updateCountNotice(trueCount,falseCount,Integer.parseInt(noticeId));//更改已读未读状态
        return "success";
    }

    //查看公告详情
    @RequestMapping("/selNoticeParticulars")
    @ResponseBody
    public JSONObject selNoticeParticulars(int noticeId){
        JSONObject jsonObject = new JSONObject();
        List<Map> list = zhq_noticeService.selParticulars(noticeId);

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        return jsonObject;
    }




}
