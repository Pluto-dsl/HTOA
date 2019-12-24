package com.pluto.service;

import java.util.Map;

public interface Pluto_LogService {
    Map getLogData(String sql,int page,int limit);
}
