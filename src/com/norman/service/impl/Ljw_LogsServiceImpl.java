package com.norman.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.norman.service.Ljw_LogsService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.logistics.EquipmentRepairVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
@Transactional

public class Ljw_LogsServiceImpl extends BaseDao implements Ljw_LogsService {
    @Override
    public void newRepair(EquipmentRepairVo repairVo) {
        addObject(repairVo);
    }

    @Override
    public JSONArray getMyEmpRepairData(HttpServletRequest request, int userId, int page, int limit) {
        JSONArray resultData = new JSONArray();
        List<EquipmentRepairVo> data = super.listByHql("from EquipmentRepairVo where Student="+userId);
        //遍历结果集
        for (EquipmentRepairVo vo:
                data) {
            System.out.println(vo);
            //定义装载数据的容器
            JSONObject jo = new JSONObject();
            //定义时间转换类
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            //声明参数
            String endTime;
            String status;
            String empId;
            String result;

            //判断是否有结束时间
            if (null == vo.getEndTime()){
                endTime="---";
            }else {
                endTime=sdf.format(vo.getEndTime());
            }
            //转换状态内容
            if (0 == vo.getStatus()){
                status="未完成";
            }else {
                status="已完成";
            }
            //转换处理人
            if (vo.getEmpId()==0){
                empId = "---";
            }else {
                empId = ((EmpVo)getObject(EmpVo.class,vo.getEmpId())).getEmpName();
            }
            //转换结果
            if (null == vo.getResult()){
                result = "";
            }else {
                result = vo.getResult();
            }

            //装载数据
            jo.put("equipmentId",vo.getEquipmentId());
            jo.put("equipmentType",vo.getEquipmentType());
            //通过EquipmentRepairVo的DepId获取部门表里的部门名称并装载
            jo.put("depName",((DepVo)getObject(DepVo.class,vo.getDepId())).getDepName());
            //通过EquipmentRepairVo的DepId获取员工表里的员工名称并装载
            jo.put("empName",((EmpVo)getObject(EmpVo.class,vo.getStudent())).getEmpName());
            jo.put("startTime",sdf.format(vo.getStartTime()));
            jo.put("endTime",endTime);
            jo.put("remark",vo.getRemark());
            jo.put("status",status);
            jo.put("empId",empId);
            jo.put("result",result);
            resultData.add(jo);
        }
        return resultData;
    }

    //根据用户类型（员工/学生）获取对应的报修申请数据
    @Override
    public JSONArray getRepairData(HttpServletRequest request, int userType, int page, int limit) {
        JSONArray resultdata = new JSONArray();
        List<EquipmentRepairVo> data = listByHql("from EquipmentRepairVo where userType="+userType);
        //遍历结果集
        for (EquipmentRepairVo vo:
                data) {
            System.out.println(vo);
            JSONObject jo = new JSONObject();
            //定义时间转换类
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            //声明参数
            String depName;
            String empName;
            String endTime;
            String status;
            String empId;
            String result;

            //根据员工类型设置不同的值
            if (userType==1){
                //通过EquipmentRepairVo的Classes获取班级表里的部门名称并装载
                depName=((StudentClassVo)getObject(StudentClassVo.class,vo.getClasses())).getClassName();
                //通过EquipmentRepairVo的Student获取学生表里的员工名称并装载
                empName=((StudentVo)getObject(StudentVo.class,vo.getStudent())).getStuname();
            }else {
                //通过EquipmentRepairVo的DepId获取部门表里的部门名称并装载
                depName=((DepVo)getObject(DepVo.class,vo.getDepId())).getDepName();
                //通过EquipmentRepairVo的DepId获取员工表里的员工名称并装载
                empName=((EmpVo)getObject(EmpVo.class,vo.getStudent())).getEmpName();
            }
            //判断是否有结束时间
            if (null == vo.getEndTime()){
                endTime="---";
            }else {
                endTime=sdf.format(vo.getEndTime());
            }
            //转换状态内容
            if (0 == vo.getStatus()){
                status="未完成";
            }else {
                status="已完成";
            }
            //转换处理人
            if (vo.getEmpId()==0){
                empId = "---";
            }else {
                empId = ((EmpVo)getObject(EmpVo.class,vo.getEmpId())).getEmpName();
            }
            //转换结果
            if (null == vo.getResult()){
                result = "";
            }else {
                result = vo.getResult();
            }

            //装载数据
            jo.put("equipmentId",vo.getEquipmentId());
            jo.put("equipmentType",vo.getEquipmentType());
            jo.put("depName",depName);
            jo.put("empName",empName);
            jo.put("startTime",sdf.format(vo.getStartTime()));
            jo.put("endTime",endTime);
            jo.put("remark",vo.getRemark());
            jo.put("status",status);
            jo.put("empId",empId);
            jo.put("result",result);
            resultdata.add(jo);
        }
        return resultdata;
    }

    @Override
    public int getMyEmpRepairSize(int userId) {
        List list = listByHql("FROM EquipmentRepairVo where Student="+userId);
        return list.size();
    }

    //根据用户类型（员工/学生）获取对应的报修申请的条数
    @Override
    public int getRepairSize(int userType) {
        List list = listByHql("FROM EquipmentRepairVo where userType="+userType);
        return list.size();
    }

    @Override
    public void delRepair(int id) {
        EquipmentRepairVo vo = new EquipmentRepairVo();
        vo.setEquipmentId(id);
        delObject(vo);
    }

    @Override
    public EmpVo getEmpVo(int empId) {
        return (EmpVo) getObject(EmpVo.class,empId);
    }
}
