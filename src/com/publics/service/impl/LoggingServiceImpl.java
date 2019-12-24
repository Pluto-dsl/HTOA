package com.publics.service.impl;

import com.publics.dao.BaseDao;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.SystemLogVo;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

public class LoggingServiceImpl extends BaseDao implements LoggingService {
    @Override
    public void addLog(SystemLogVo log) {
        InetAddress addr = null;
        try {
            addr = InetAddress.getLocalHost();

        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        log.setIpAddr(addr.getHostAddress());
        Date date = new Date();
        log.setOptime(date);
        super.addObject(log);
    }
}
