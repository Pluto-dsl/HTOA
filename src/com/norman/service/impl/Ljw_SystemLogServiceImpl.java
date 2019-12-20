package com.norman.service.impl;

import com.norman.dao.Ljw_TongYongDao;
import com.norman.service.Ljw_SystemLogService;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.AttendanceVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.util.*;

@Service
@Transactional
public class Ljw_SystemLogServiceImpl extends BaseDao implements Ljw_SystemLogService {

    @Resource
    Ljw_TongYongDao dao;

    @Override
    public List getEmpList(HttpServletRequest request,int page, int limit) {

        String empName = request.getParameter("empName");
        String depIdStr = request.getParameter("depId");
        String sql ="SELECT e.empId,e.empName,e.Sex,e.Phone,d.depName,SUM(a.Scores) scores FROM emp e \n" +
                "LEFT JOIN aduitLog a on e.empId = a.Empid \n" +
                "LEFT JOIN dep d on e.depId = d.depId \n" +
                "GROUP BY e.empId,e.empName,e.Sex,e.Phone,d.depName \n" +
                "HAVING 1=1 ";

        int depId;//判断员工id
        if ("".equals(depIdStr) || null == depIdStr){
            depId = 0;
        }else {
            depId = Integer.parseInt(depIdStr);
        }
        if (depId!=0){
            sql +=" and Empid in (SELECT empId FROM emp WHERE depId="+depId+")";
        }

        if (!("".equals(empName) || null == empName)){//部门
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and Empid in ("+empIds+")";
            }else {
                sql +=" and Empid in (0)";
            }
        }
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getEmpListSize() {
        return listByHql("from EmpVo").size();
    }

    @Override
    public List<Map> getEveryListById(int empId) {
        return super.listBySQL("SELECT al.aduitLogid,e.empName,am.aduitName,al.Scores,al.auditDate,al.Image,ap.empName auditPerson,al.Remark FROM aduitLog al \n" +
                "LEFT JOIN aduitModel am on al.aduitModelid=am.aduitModelid \n" +
                "LEFT JOIN emp e on al.Empid=e.empId \n" +
                "LEFT JOIN emp ap on al.auditPerson=ap.Empid\n" +
                "WHERE al.Empid = "+empId);
    }

    @Override
    public AduitLogVo getAduitLog(int auditId) {
        return (AduitLogVo) super.getObject(AduitLogVo.class,auditId);
    }

    @Override
    public List<Map> getHolidayEmp(HttpServletRequest request, int page, int limit) {
        //创建sql语句
        String sql = "select e.empId,e.empName,count(*) holiCount,SUM(h.holidayDay) holiday,SUM(h.hour) 'hour' FROM holiday h\n" +
                "LEFT JOIN emp e on h.Empid=e.empId where 1=1";

        //取出条件
        String empName = request.getParameter("empName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and h.Empid in ("+empIds+")";
            }else {
                sql +=" and h.Empid in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and h.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and h.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }else {
            Calendar cal = Calendar.getInstance();
            int mon = cal.get(Calendar.MONTH);
            mon--;
            sql += " and h.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            mon++;
            sql += " and h.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
        }
        sql +=" GROUP BY e.empId,e.empName";
        System.out.println(sql);
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getHolidayEmpSize(HttpServletRequest request) {
        //创建sql语句
        String sql = "select e.empId,e.empName,count(*) holiCount,SUM(h.holidayDay) holiday,SUM(h.hour) 'hour' FROM holiday h\n" +
                "LEFT JOIN emp e on h.Empid=e.empId where 1=1";

        //取出条件
        String empName = request.getParameter("empName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and h.Empid in ("+empIds+")";
            }else {
                sql +=" and h.Empid in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and h.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and h.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }else {
            Calendar cal = Calendar.getInstance();
            int mon = cal.get(Calendar.MONTH);
            mon--;
            sql += " and h.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            mon++;
            sql += " and h.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
        }
        sql +=" GROUP BY e.empId,e.empName";
        System.out.println(sql);
        return listBySQL(sql).size();
    }

    @Override
    public List<Map> getHolidayListByEmp(HttpServletRequest request,int page,int limit) {
        String empId = request.getParameter("empId");
        if ("".equals(empId) || empId==null ){
            return new ArrayList<>();
        }else {
            return pageBySQL("select e.empName,h.* FROM holiday h\nLEFT JOIN emp e on h.Empid=e.empId\nWHERE h.Empid = "+empId,page,limit);
        }
    }

    @Override
    public int getHolidayListByEmpSize(HttpServletRequest request) {
        String empId = request.getParameter("empId");
        if ("".equals(empId) || empId==null ){
            return 0;
        }else {
            return listBySQL("select e.empName,h.* FROM holiday h\nLEFT JOIN emp e on h.Empid=e.empId\nWHERE h.Empid = "+empId).size();
        }
    }

    @Override
    public List<Map> getHolidayStu(HttpServletRequest request, int page, int limit) {
        //获取当前登录的员工
        HttpSession session = request.getSession();
        EmpVo emp = (EmpVo) session.getAttribute("admin");

        //创建sql语句
        String sql = "SELECT stu.Studid,stu.stuname,count(*) holiday FROM holidayStudent hs\n" +
                "LEFT JOIN student stu on hs.StudentId=stu.Studid where 1=1";

        //取出条件
        String stuName = request.getParameter("stuName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(stuName) || null == stuName)){
            List<Integer> stus = dao.getStuNames(stuName);
            if (stus.size()>=1){
                String stuIds = "";
                for (int id:stus) {
                    stuIds +=+id+",";
                }
                System.out.println(stuIds);
                stuIds = stuIds.substring(0,stuIds.length()-1);
                sql +=" and hs.StudentId in ("+stuIds+")";
            }else {
                sql +=" and hs.StudentId in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and hs.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and hs.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }
        sql +=" GROUP BY stu.Studid,stu.stuname,stu.clazz\n" +
                "HAVING stu.clazz in (SELECT classid FROM studentClass WHERE teacher = "+emp.getEmpId()+" or classTeacher = "+emp.getEmpId()+")";
        System.out.println(sql);
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getHolidayStuSize(HttpServletRequest request) {
        //获取当前登录的员工
        HttpSession session = request.getSession();
        EmpVo emp = (EmpVo) session.getAttribute("admin");

        //创建sql语句
        String sql = "SELECT stu.Studid,stu.stuname,count(*) holiday FROM holidayStudent hs\n" +
                "LEFT JOIN student stu on hs.StudentId=stu.Studid where 1=1";

        //取出条件
        String stuName = request.getParameter("stuName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(stuName) || null == stuName)){
            List<Integer> stus = dao.getStuNames(stuName);
            if (stus.size()>=1){
                String stuIds = "";
                for (int id:stus) {
                    stuIds +=+id+",";
                }
                System.out.println(stuIds);
                stuIds = stuIds.substring(0,stuIds.length()-1);
                sql +=" and hs.StudentId in ("+stuIds+")";
            }else {
                sql +=" and hs.StudentId in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and hs.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and hs.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }else {
            Calendar cal = Calendar.getInstance();
            int mon = cal.get(Calendar.MONTH);
            mon--;
            sql += " and hs.startTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            mon++;
            sql += " and hs.startTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
        }
        sql +=" GROUP BY stu.Studid,stu.stuname,stu.clazz\n" +
                "HAVING stu.clazz in (SELECT classid FROM studentClass WHERE teacher = "+emp.getEmpId()+" or classTeacher = "+emp.getEmpId()+")";
        return listBySQL(sql).size();
    }

    @Override
    public List<Map> getHolidayListByStu(HttpServletRequest request,int page,int limit) {
        String stuId = request.getParameter("stuId");
        String sql = "SELECT stu.stuname,hs.* FROM holidayStudent hs\n" +
                "LEFT JOIN student stu on hs.StudentId=stu.Studid\n" +
                "WHERE hs.StudentId = "+stuId;
        if ("".equals(stuId) || stuId==null ){
            return new ArrayList<>();
        }else {
            System.out.println(sql);
            return pageBySQL(sql,page,limit);
        }
    }

    @Override
    public int getHolidayListByStuSize(HttpServletRequest request) {
        String stuId = request.getParameter("stuId");
        if ("".equals(stuId) || stuId==null ){
            return 0;
        }else {
            return listBySQL("SELECT stu.stuname,hs.* FROM holidayStudent hs\n" +
                    "LEFT JOIN student stu on hs.StudentId=stu.Studid\n" +
                    "WHERE hs.StudentId = "+stuId).size();
        }
    }

    @Override
    public List<AttendanceVo> getAttendance(HttpServletRequest request,int page,int limit) {
        //创建sql语句
        String sql = "SELECT att.*,e.empName FROM attendance att LEFT JOIN emp e on e.empId=att.empId where 1=1";

        //取出条件
        String empName = request.getParameter("empName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and att.empId in ("+empIds+")";
            }else {
                sql +=" and att.empId in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and punckClockTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and punckClockTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }else {
            Calendar cal = Calendar.getInstance();
            int mon = cal.get(Calendar.MONTH);
            mon--;
            sql += " and punckClockTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            mon++;
            sql += " and punckClockTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
        }
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getAttendanceSize(HttpServletRequest request) {
        //创建sql语句
        String sql = "SELECT att.*,e.empName FROM attendance att LEFT JOIN emp e on e.empId=att.empId where 1=1";

        //取出条件
        String empName = request.getParameter("empName");
        String month = request.getParameter("month");

        //根据条件添加sql语句
        if (!("".equals(empName) || null == empName)){
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and att.empId in ("+empIds+")";
            }else {
                sql +=" and att.empId in (0)";
            }
        }
        if (!("".equals(month) || null == month)) {
            int mon = Integer.parseInt(month);
            if (mon != 0){
                Calendar cal = Calendar.getInstance();
                sql += " and punckClockTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
                mon++;
                sql += " and punckClockTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            }
        }else {
            Calendar cal = Calendar.getInstance();
            int mon = cal.get(Calendar.MONTH);
            mon--;
            sql += " and punckClockTime >= '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
            mon++;
            sql += " and punckClockTime < '"+cal.get(Calendar.YEAR)+"-"+mon+"-01 00:00:00'";
        }
        System.out.println(sql);
        return super.listBySQL(sql).size();
    }

    @Override
    public List<Map> getFloorList() {
        return super.listBySQL("SELECT sf.floorId,sf.floorName FROM studentHuor sh\n" +
                "LEFT JOIN studentFloor sf on sh.floorId = sf.floorId\n" +
                "GROUP BY sf.floorId,sf.floorName");
    }

    @Override
    public List<Map> getHourListNames(int floor) {
        if (floor == 0){
            return new ArrayList<>();
        }
        List<Map> list = super.listBySQL("SELECT Hourid,huorName FROM studentHuor WHERE floorId = "+floor);
        List<Map> result = new ArrayList<>();
        for (Map map:list) {
            String huorName = (String) map.get("huorName");
            int floorNum = 0;
            if (huorName.length() == 6){
                floorNum = Integer.parseInt(huorName.substring(3,4));
            }else if (huorName.length() == 7){
                floorNum = Integer.parseInt(huorName.substring(4,5));
            }
            Map<String,Integer> resultMap = new HashMap<>();
            boolean flag = true;
            for (Map listMap:
                 result) {
                if (Integer.parseInt(listMap.get("floorNum").toString())==floorNum){
                    flag = false;
                }
            }
            if (flag){
                resultMap.put("floorNum",floorNum);
                result.add(resultMap);
            }
        }
        return result;
    }

    @Override
    public List<Map> getStuHourList(HttpServletRequest request, int page, int limit) {
        //创建sql语句
        String sql = "SELECT sf.floorName,sh.addr,sh.huorName hourName,(SELECT count(*) FROM student WHERE huor = sh.Hourid) stuNum,sh.numberBeds,\n" +
                "sh.numberBeds-(SELECT count(*) FROM student WHERE huor = sh.Hourid) surplus\n" +
                "FROM studentHuor sh\n" +
                "LEFT JOIN studentFloor sf on sh.floorId = sf.floorId WHERE 1=1";

        //取出条件
        String floor = request.getParameter("floor");
        String floorNum = request.getParameter("floorNum");

        System.out.println(floor);
        System.out.println(floorNum);

        //根据条件添加sql语句
        if (!("".equals(floor) || null == floor)){
            sql += " and sh.floorId = "+floor;
        }
        if (!("".equals(floorNum) || null == floorNum)){
            StudntBuildingVo floorVo = (StudntBuildingVo) super.getObject(StudntBuildingVo.class, Integer.valueOf(floor));
            if (floorVo.getFloorName().length() == 2){
                sql += " and sh.huorName like '___"+floorNum+"__'";
            }else if (floorVo.getFloorName().length() == 3){
                sql += " and sh.huorName like '____"+floorNum+"__'";
            }
        }
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getStuHourSize(HttpServletRequest request) {
        //创建sql语句
        String sql = "SELECT sf.floorName,sh.addr,sh.huorName hourName,(SELECT count(*) FROM student WHERE huor = sh.Hourid) stuNum,sh.numberBeds,\n" +
                "sh.numberBeds-(SELECT count(*) FROM student WHERE huor = sh.Hourid) surplus\n" +
                "FROM studentHuor sh\n" +
                "LEFT JOIN studentFloor sf on sh.floorId = sf.floorId WHERE 1=1";

        //取出条件
        String floor = request.getParameter("floor");
        String floorNum = request.getParameter("floorNum");

        //根据条件添加sql语句
        if (!("".equals(floor) || null == floor)){
            sql += " and sh.floorId = "+floor;
        }
        if (!("".equals(floorNum) || null == floorNum)){
            StudntBuildingVo floorVo = (StudntBuildingVo) super.getObject(StudntBuildingVo.class, Integer.valueOf(floor));
            if (floorVo.getFloorName().length() == 2){
                sql += " and sh.huorName like '___"+floorNum+"__'";
            }else if (floorVo.getFloorName().length() == 3){
                sql += " and sh.huorName like '____"+floorNum+"__'";
            }
        }
        return super.listBySQL(sql).size();
    }

}
