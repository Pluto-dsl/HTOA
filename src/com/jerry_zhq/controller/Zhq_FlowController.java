package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_FlowService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.file.DataDocVo;
import org.activiti.engine.*;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

@Controller
@RequestMapping("/zhq")
public class Zhq_FlowController {
    @Resource
    private ProcessEngine processEngine;
    @Resource
    private TaskService taskService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private HistoryService historyService;
    @Resource
    private RepositoryService repositoryService;

    @Resource
    private Zhq_FlowService zhq_flowService;

    @RequestMapping("/flow")
    public String flow(){
        return "/flow_zhq/flow";
    }

    //查询
    @RequestMapping("/selFlow")
    @ResponseBody
    public JSONObject selDoc(HttpServletResponse response , int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        JSONObject jsonObject = new JSONObject();

        String hql = "select * from ACT_RE_PROCDEF";
        List list = zhq_flowService.selFlow(hql,page,limit);
        int count = zhq_flowService.selCount();

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",list);
        return jsonObject;
    }
    //上传
    @RequestMapping("/addFlow")
    public String addFlow(MultipartFile file){
         //System.out.println("获取到的文件名是"+file.getOriginalFilename());
        try {
            //创建临时file对象
            File pdFile = File.createTempFile("tem",null);
            //把MultipartFile对象转换成IO流File对象
            file.transferTo(pdFile);
            //部署
            org.activiti.engine.repository.Deployment deployment = repositoryService.createDeployment().addZipInputStream(new ZipInputStream(new FileInputStream(pdFile))).deploy();
             //System.out.println("ID"+ deployment.getId());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/zhq/flow";
    }
    /**
     * 下载流程图
     */
    @RequestMapping("/toExport")
    public String toExport(String id,HttpServletResponse resp){
        try {

            //设置response对象的头参数，attachment就是附件，filename=文件名称
            resp.setHeader("Content-disposition","attachment;filename=" +id+".zip" );
            //下载的文件类型是zip文件
            resp.setContentType("application/x-zip-compressed");

            //----------------------------------------------------------------------------

            //流程定义对象
            ProcessDefinition processDefinition = repositoryService
                    .createProcessDefinitionQuery()
                    .processDefinitionId(id).singleResult();
            //部署id
            String deploymentId = processDefinition.getDeploymentId();

            //bpmn资源文件名称
            String resourceName_bpmn = processDefinition.getResourceName();
            //bpmn资源文件输入流
            InputStream inputStream_bpmn = repositoryService.getResourceAsStream(deploymentId, resourceName_bpmn);
            //png文件名称
            String resourceName_png = processDefinition.getDiagramResourceName();
            //png资源文件输入流
            InputStream inputStream_png = repositoryService.getResourceAsStream(deploymentId, resourceName_png);

            //------创建输出流，绑定到response对象-------------------------------------------------------
            OutputStream out = resp.getOutputStream();
            //创建ZIP输出对象，绑定到输出流
            ZipOutputStream zipo = new ZipOutputStream(out);

            //流复制
            byte[] b = new byte[1024];
            int len = -1;

            //定义zip压缩包中的文件对象（zip实体）
            ZipEntry ze = new ZipEntry(resourceName_bpmn);
            //把创建的实体对象放到压缩包中
            zipo.putNextEntry(ze);
            //文件内容拷贝
            while((len = inputStream_bpmn.read(b,0,1024)) != -1){
                zipo.write(b,0,b.length);
            }
            zipo.closeEntry();
            //---------------
            ZipEntry ze1 = new ZipEntry(resourceName_png);
            zipo.putNextEntry(ze1);
            while((len = inputStream_png.read(b,0,1024)) != -1){
                zipo.write(b,0,b.length);
            }
            //关闭流
            inputStream_bpmn.close();
            inputStream_png.close();
            zipo.flush();
            zipo.close();
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    //查询流程定义列表
    @RequestMapping("/viewProcessImage")
    public String viewProcessImage(String did, String imageName, HttpServletResponse resp){
        InputStream in = repositoryService.getResourceAsStream(did,imageName);
        try {
            OutputStream out = resp.getOutputStream();
            // 把图片的输入流程写入resp的输出流中
            byte[] b = new byte[1024];
            for (int len = -1; (len= in.read(b))!=-1; ) {
                out.write(b, 0, len);
            }
            // 关闭流
            out.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
