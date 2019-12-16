package com.jerry_zhq.service;

import com.publics.vo.file.DataDocVo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public interface Zhq_DataDocService {
    //分页查询资料文档
    List selDoc(String hql,int page,int limit);
    //查看总数
    int selDocCount();

    //查看员工
    List selEmp();

    //上传文件
    void addDoc(DataDocVo dataDocVo , MultipartFile file, HttpServletRequest request) throws IOException;

    //删除
    void delDoc(DataDocVo dataDocVo);

    Object selDocId(Class vo,int id);
}
