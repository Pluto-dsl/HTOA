package com.pluto.service;

import java.util.List;

public interface Pluto_StudentMsg {
    String getStudentList(String sql);
    List getClassList(String hql);
    List getMajor(String hql);
}
