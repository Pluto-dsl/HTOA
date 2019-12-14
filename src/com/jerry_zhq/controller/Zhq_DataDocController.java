package com.jerry_zhq.controller;

import com.alibaba.druid.Constants;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_DataDocService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.file.DataDocVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.*;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;


@Controller
public class Zhq_DataDocController {

    @Resource
    Zhq_DataDocService zhq_dataDocService;
    @RequestMapping("/toPage/DataDoc")
    public String toPageDataDoc(){
        return "/doc_zhq/DataDoc";
    }

    @RequestMapping("/selDoc")
    @ResponseBody
    public JSONObject selDoc(HttpServletResponse response ,int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        String hql ="from DataDocVo";
        List<DataDocVo> data =zhq_dataDocService.selDoc(hql,page,limit);//分页查询
        int count = zhq_dataDocService.selDocCount();//查询总数

        for (DataDocVo docVo:data){
            Map map = new HashMap();
            List<EmpVo> empVoList = zhq_dataDocService.selEmp();//查询员工
            for (EmpVo empVo:empVoList){
                if (empVo.getEmpId() ==docVo.getEmpId()){
                    map.put("empId",empVo.getEmpName());
                }
            }
            map.put("docId",docVo.getDocId());
            map.put("dataName",docVo.getDataName());
            map.put("opTime",docVo.getOpTime());
            map.put("remark",docVo.getRemark());
            map.put("url",docVo.getUrl());
            jsonArray.add(map);
        }

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }

    //文件上传
    @RequestMapping("/addDoc")
    public String addDoc(DataDocVo dataDocVo, MultipartFile file, HttpServletRequest request,HttpServletResponse response) throws IOException {
        response.setContentType("application/force-download");
        String remark = request.getParameter("remark");
        dataDocVo.setRemark(remark);
        dataDocVo.setOpTime(new Date());
        dataDocVo.setEmpId(1);
        zhq_dataDocService.addDoc(dataDocVo,file,request);

        return "redirect:/toPage/DataDoc";
    }

    //删除
    @RequestMapping("/deleteDoc")
    @ResponseBody
    public String deleteDoc(int docId){
        DataDocVo docVo = new DataDocVo();
        docVo.setDocId(docId);
        zhq_dataDocService.delDoc(docVo);
        return "success";
    }

}
