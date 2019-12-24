package com.publics.service.impl;

import com.publics.dao.BaseDao;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.SystemLogVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

@Service
public class LoggingServiceImpl extends BaseDao implements LoggingService {
    @Override
    public void addLog(int empId,String content) {
        InetAddress addr = null;
        Date date = new Date();
        try {
            addr = InetAddress.getLocalHost();

        } catch (UnknownHostException e) {
            e.printStackTrace();
        }

        SystemLogVo log = new SystemLogVo();
        log.setEmpId(empId);
        log.setMsg(content);
        log.setIpAddr(addr.getHostAddress());
        log.setOptime(date);
        super.addObject(log);
    }
}
