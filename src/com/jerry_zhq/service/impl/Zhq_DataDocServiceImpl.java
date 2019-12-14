package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_DataDocService;
import com.publics.dao.BaseDao;
import com.publics.vo.file.DataDocVo;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@Service
public class Zhq_DataDocServiceImpl extends BaseDao implements Zhq_DataDocService {

    //分页查询资料文档
    @Override
    public List selDoc(String hql, int page, int limit) {
        return pageByHql(hql,page,limit);
    }

    //查看总数
    @Override
    public int selDocCount() {
        return  selTotalRow("select count(*) from dataDoc");
    }
    //查看员工
    @Override
    public List selEmp() {
        return listByHql("from EmpVo");
    }

    //上传文件
    @Override
    public void addDoc(DataDocVo dataDocVo, MultipartFile file, HttpServletRequest request) throws IOException {
        //获取原文件的文件名
        String oldName = file.getOriginalFilename();
        System.out.println("获取到的文件名是"+oldName);


        // 截取文件的扩展名
        String extName = oldName.substring(oldName.indexOf("."));  //截取后缀


        //构造文件写入位置
        String paht = request.getSession().getServletContext().getRealPath("\\");
        System.out.println("位置"+paht);

        //给文件夹加上日期
        Calendar calendar = Calendar.getInstance();
        int month  =calendar.get(Calendar.MONTH) + 1;
        String month2 = String.valueOf(month);
        if(month <10){
            month2  ="0" +month;
        }

        paht += "upload\\" + calendar.get(Calendar.YEAR) + month2+ calendar.get(Calendar.DAY_OF_MONTH);
        System.out.println(paht);

        //判断文件是否存在
        File dir = new File(paht);
        if(!dir.exists()){
            dir.mkdirs();//不存在就创建文件夹
        }

        //设计新文件名
        String s = UUID.randomUUID().toString();

        //拼凑完整的的文件名
        String filePath = paht+"\\" +s+extName;
        System.out.println("完整的文件名是"+ filePath);
        File file1 = new File(filePath);
        //保存文件
        file.transferTo(file1);

        dataDocVo.setUrl("upload\\" + calendar.get(Calendar.YEAR) + month2+ calendar.get(Calendar.DAY_OF_MONTH)+"\\"+s+extName);

        dataDocVo.setDataName(oldName);//资料名称
        addObject(dataDocVo);
    }

    //删除
    @Override
    public void delDoc(DataDocVo dataDocVo) {
        delObject(dataDocVo);
    }

    @Override
    public Object selDocId(Class vo, int id) {
        return getObject(vo,id);
    }
}
