package com.publics.service;

import com.publics.vo.sys.SystemLogVo;

import javax.servlet.http.HttpServletRequest;

public interface LoggingService {
    void addLog(SystemLogVo log);
}
