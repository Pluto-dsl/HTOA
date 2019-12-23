package com.jerry_zhq.controller;

import com.alibaba.druid.Constants;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_DataDocService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.file.DataDocVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import org.h2.store.Data;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;
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
@RequestMapping("/zhq")
public class Zhq_DataDocController {

    @Resource
    Zhq_DataDocService zhq_dataDocService;


    @RequestMapping("/DataDoc")
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
    public String addDoc(DataDocVo dataDocVo, MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        response.setContentType("application/force-download");
        String remark = request.getParameter("remark");
        EmpVo empVo = (EmpVo) session.getAttribute("admin");

        dataDocVo.setRemark(remark);
        dataDocVo.setOpTime(new Date());
        dataDocVo.setEmpId(empVo.getEmpId());
        zhq_dataDocService.addDoc(dataDocVo,file,request);

        return "redirect:/zhq/DataDoc";
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

    @RequestMapping("/download.do")
    public void download(Integer docId,DataDocVo dataDocVo,HttpServletResponse response) throws Exception{
         //System.out.println("获取到的id是"+docId);
        DataDocVo dataDocVO1 = (DataDocVo) zhq_dataDocService.selDocId(dataDocVo.getClass(),docId);

         //System.out.println("要下载的路径是"+dataDocVO1.getUrl());
        // 指定要下载的文件所在路径
        String path = dataDocVO1.getUrl();
        // 创建该文件对象
        File file = new File(path);

        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + dataDocVO1.getDataName());

        //打开本地文件流
        InputStream inputStream = new FileInputStream(file);
        //激活下载操作
        OutputStream os = response.getOutputStream();

        byte[] b = new byte[1024*50];
        int length;
        while ((length = inputStream.read(b)) > 0) {
            os.write(b,0,length);
        }
        // 这里主要关闭。
        os.close();
        inputStream.close();

    }

}
