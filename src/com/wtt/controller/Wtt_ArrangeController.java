package com.wtt.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.LoginService;
import com.publics.vo.educ.WeekArrangeVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.wtt.service.Wtt_ArrangeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/arrange")
public class Wtt_ArrangeController {
    @Resource
    Wtt_ArrangeService wtt_arrangeService;
    @Resource
    private LoginService log;
    //无权限时跳转页面
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    //去到值班管理页面
    @RequestMapping(value = "/arrangePage")
    public String arrange(ModelMap modelMap){
        List list = wtt_arrangeService.emp();
        modelMap.addAttribute("emplist",list);
        return "emp_wtt/zhibanarrange";
    }

    //查询值班管理页面操作
    @RequestMapping(value = "/selectarrange")
    public void selectshijiang(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<WeekArrangeVo> list = wtt_arrangeService.weekArrangevo(page,limit);
        JSONArray jsonArray = new JSONArray();
        for (WeekArrangeVo weekArrangeVo:list){
            EmpVo empVo = wtt_arrangeService.emps(Integer.parseInt(weekArrangeVo.getEmpId()));
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("weekArrangeId",weekArrangeVo.getWeekArrangeId());
            jsonObject.put("weekArrangeName",weekArrangeVo.getWeekArrangeName());
            jsonObject.put("ranges",weekArrangeVo.getRanges());
            jsonObject.put("week",weekArrangeVo.getWeek());
            jsonObject.put("empId",empVo.getEmpName());
            jsonObject.put("orderId",weekArrangeVo.getOrderId());
            jsonObject.put("duty",weekArrangeVo.getDuty());
            jsonObject.put("startTime",weekArrangeVo.getStartTime());
            jsonObject.put("endTime",weekArrangeVo.getEndTime());
            jsonObject.put("remark",weekArrangeVo.getRemark());

            jsonArray.add(jsonObject);
        }
        //获取总行数
        int rows =wtt_arrangeService.pagecount();
        /*System.out.println("总行数:"+rows);*/
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",jsonArray);
        jsonObject.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObject.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //新增
    @RequestMapping(value = "/addarrange")
    public String addarrange(WeekArrangeVo weekArrangeVo){
        wtt_arrangeService.add(weekArrangeVo);
        
        return "redirect:/arrange/arrangePage";
    }

    //删除
    @RequestMapping(value = "/deletearrange")
    public String deletearrange(int id){
        wtt_arrangeService.delete(id);
        return "redirect:/arrange/arrangePage";
    }
}