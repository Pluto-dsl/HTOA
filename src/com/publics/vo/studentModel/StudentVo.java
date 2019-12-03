package com.publics.vo.studentModel;

import javax.persistence.*;
import java.util.Date;

/**
 *       学生资料:
 *          此菜单可以维护学生的基本信息，需要增删改查的功能
 *          户口性质:	 1.农业  2.非农
            专业类别:	 1.中技  2.高技  3.3+2
            学习方式：1.全日制  2.函授
            是否中专：1.否   2.是
            中专学籍：1.已退 2.保留

 * */
@Entity
@Table(name = "student")
public class StudentVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Studid;//学生主键id
    private String password;//登入密码
    private String stuname;//学生姓名
    private String middleschool;//毕业学校
    private String sex;//性别
    private String age;//年龄
    private Date birthday;//出生年月
    private String phone;//学生电话
    private String addr;//家庭地址
    private int clazz;//班级外键id
    private int huor;//宿舍外键id
    private Date entertime;//入学时间
    private String introduretech;//介绍老师
    private int stat;//学生状态
    private String nation;//民族
    private String natives;//籍贯
    private int residence;//户口性质
    private String cardid;//身份证号
    private String professional;//就读专业
    private int prolevel;//专业类别
    private int studytype;//学习类别
    private String parents;//家长姓名
    private String parentsphone ;//家长电话
    private String intrphone;//老师电话
    private String audition ;//面试人
    private String auditionoption;//面试人意见
    private int isvocational;//是否中专
    private String vocationalsch;//中专学校
    private int vocationalflag;//中专学籍
    private int enrollno;//省录取号
    private Float qkMoney;//欠款金额
    private Float score;//录取成绩
    private String dibao;//是否低保
    private String sourceType;//生源类型
    private String guarantee;//担保人
    private String soldier;//是否当兵
    private String registration;//报名号
    private String zhuxiao;//是否住校
    private String remark;//备注
    private String tuixue;//退学
    private String xiuxue;//休学
    private String stuno;//学号
    private String computer ;//是否送电脑
    private String collar;//是否领用
    private String grants;//助学金

    public StudentVo(int studid, String password, String stuname, String middleschool, String sex, String age, Date birthday, String phone, String addr, int clazz, int huor, Date entertime, String introduretech, int stat, String nation, String natives, int residence, String cardid, String professional, int prolevel, int studytype, String parents, String parentsphone, String intrphone, String audition, String auditionoption, int isvocational, String vocationalsch, int vocationalflag, int enrollno, Float qkMoney, Float score, String dibao, String sourceType, String guarantee, String soldier, String registration, String zhuxiao, String remark, String tuixue, String xiuxue, String stuno, String computer, String collar, String grants) {
        Studid = studid;
        this.password = password;
        this.stuname = stuname;
        this.middleschool = middleschool;
        this.sex = sex;
        this.age = age;
        this.birthday = birthday;
        this.phone = phone;
        this.addr = addr;
        this.clazz = clazz;
        this.huor = huor;
        this.entertime = entertime;
        this.introduretech = introduretech;
        this.stat = stat;
        this.nation = nation;
        this.natives = natives;
        this.residence = residence;
        this.cardid = cardid;
        this.professional = professional;
        this.prolevel = prolevel;
        this.studytype = studytype;
        this.parents = parents;
        this.parentsphone = parentsphone;
        this.intrphone = intrphone;
        this.audition = audition;
        this.auditionoption = auditionoption;
        this.isvocational = isvocational;
        this.vocationalsch = vocationalsch;
        this.vocationalflag = vocationalflag;
        this.enrollno = enrollno;
        this.qkMoney = qkMoney;
        this.score = score;
        this.dibao = dibao;
        this.sourceType = sourceType;
        this.guarantee = guarantee;
        this.soldier = soldier;
        this.registration = registration;
        this.zhuxiao = zhuxiao;
        this.remark = remark;
        this.tuixue = tuixue;
        this.xiuxue = xiuxue;
        this.stuno = stuno;
        this.computer = computer;
        this.collar = collar;
        this.grants = grants;
    }

    public StudentVo(){}

    public int getStudid() {
        return Studid;
    }

    public void setStudid(int studid) {
        Studid = studid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname;
    }

    public String getMiddleschool() {
        return middleschool;
    }

    public void setMiddleschool(String middleschool) {
        this.middleschool = middleschool;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public int getClazz() {
        return clazz;
    }

    public void setClazz(int clazz) {
        this.clazz = clazz;
    }

    public int getHuor() {
        return huor;
    }

    public void setHuor(int huor) {
        this.huor = huor;
    }

    public Date getEntertime() {
        return entertime;
    }

    public void setEntertime(Date entertime) {
        this.entertime = entertime;
    }

    public String getIntroduretech() {
        return introduretech;
    }

    public void setIntroduretech(String introduretech) {
        this.introduretech = introduretech;
    }

    public int getStat() {
        return stat;
    }

    public void setStat(int stat) {
        this.stat = stat;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getNatives() {
        return natives;
    }

    public void setNatives(String natives) {
        this.natives = natives;
    }

    public int getResidence() {
        return residence;
    }

    public void setResidence(int residence) {
        this.residence = residence;
    }

    public String getCardid() {
        return cardid;
    }

    public void setCardid(String cardid) {
        this.cardid = cardid;
    }

    public String getProfessional() {
        return professional;
    }

    public void setProfessional(String professional) {
        this.professional = professional;
    }

    public int getProlevel() {
        return prolevel;
    }

    public void setProlevel(int prolevel) {
        this.prolevel = prolevel;
    }

    public int getStudytype() {
        return studytype;
    }

    public void setStudytype(int studytype) {
        this.studytype = studytype;
    }

    public String getParents() {
        return parents;
    }

    public void setParents(String parents) {
        this.parents = parents;
    }

    public String getParentsphone() {
        return parentsphone;
    }

    public void setParentsphone(String parentsphone) {
        this.parentsphone = parentsphone;
    }

    public String getIntrphone() {
        return intrphone;
    }

    public void setIntrphone(String intrphone) {
        this.intrphone = intrphone;
    }

    public String getAudition() {
        return audition;
    }

    public void setAudition(String audition) {
        this.audition = audition;
    }

    public String getAuditionoption() {
        return auditionoption;
    }

    public void setAuditionoption(String auditionoption) {
        this.auditionoption = auditionoption;
    }

    public int getIsvocational() {
        return isvocational;
    }

    public void setIsvocational(int isvocational) {
        this.isvocational = isvocational;
    }

    public String getVocationalsch() {
        return vocationalsch;
    }

    public void setVocationalsch(String vocationalsch) {
        this.vocationalsch = vocationalsch;
    }

    public int getVocationalflag() {
        return vocationalflag;
    }

    public void setVocationalflag(int vocationalflag) {
        this.vocationalflag = vocationalflag;
    }

    public int getEnrollno() {
        return enrollno;
    }

    public void setEnrollno(int enrollno) {
        this.enrollno = enrollno;
    }

    public Float getQkMoney() {
        return qkMoney;
    }

    public void setQkMoney(Float qkMoney) {
        this.qkMoney = qkMoney;
    }

    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }

    public String getDibao() {
        return dibao;
    }

    public void setDibao(String dibao) {
        this.dibao = dibao;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }

    public String getGuarantee() {
        return guarantee;
    }

    public void setGuarantee(String guarantee) {
        this.guarantee = guarantee;
    }

    public String getSoldier() {
        return soldier;
    }

    public void setSoldier(String soldier) {
        this.soldier = soldier;
    }

    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    public String getZhuxiao() {
        return zhuxiao;
    }

    public void setZhuxiao(String zhuxiao) {
        this.zhuxiao = zhuxiao;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTuixue() {
        return tuixue;
    }

    public void setTuixue(String tuixue) {
        this.tuixue = tuixue;
    }

    public String getXiuxue() {
        return xiuxue;
    }

    public void setXiuxue(String xiuxue) {
        this.xiuxue = xiuxue;
    }

    public String getStuno() {
        return stuno;
    }

    public void setStuno(String stuno) {
        this.stuno = stuno;
    }

    public String getComputer() {
        return computer;
    }

    public void setComputer(String computer) {
        this.computer = computer;
    }

    public String getCollar() {
        return collar;
    }

    public void setCollar(String collar) {
        this.collar = collar;
    }

    public String getGrants() {
        return grants;
    }

    public void setGrants(String grants) {
        this.grants = grants;
    }

    @Override
    public String toString() {
        return "StudentVo{" +
                "Studid=" + Studid +
                ", password='" + password + '\'' +
                ", stuname='" + stuname + '\'' +
                ", middleschool='" + middleschool + '\'' +
                ", sex='" + sex + '\'' +
                ", age='" + age + '\'' +
                ", birthday=" + birthday +
                ", phone='" + phone + '\'' +
                ", addr='" + addr + '\'' +
                ", clazz=" + clazz +
                ", huor=" + huor +
                ", entertime=" + entertime +
                ", introduretech='" + introduretech + '\'' +
                ", stat=" + stat +
                ", nation='" + nation + '\'' +
                ", natives='" + natives + '\'' +
                ", residence=" + residence +
                ", cardid='" + cardid + '\'' +
                ", professional='" + professional + '\'' +
                ", prolevel=" + prolevel +
                ", studytype=" + studytype +
                ", parents='" + parents + '\'' +
                ", parentsphone='" + parentsphone + '\'' +
                ", intrphone='" + intrphone + '\'' +
                ", audition='" + audition + '\'' +
                ", auditionoption='" + auditionoption + '\'' +
                ", isvocational=" + isvocational +
                ", vocationalsch='" + vocationalsch + '\'' +
                ", vocationalflag=" + vocationalflag +
                ", enrollno=" + enrollno +
                ", qkMoney=" + qkMoney +
                ", score=" + score +
                ", dibao='" + dibao + '\'' +
                ", sourceType='" + sourceType + '\'' +
                ", guarantee='" + guarantee + '\'' +
                ", soldier='" + soldier + '\'' +
                ", registration='" + registration + '\'' +
                ", zhuxiao='" + zhuxiao + '\'' +
                ", remark='" + remark + '\'' +
                ", tuixue='" + tuixue + '\'' +
                ", xiuxue='" + xiuxue + '\'' +
                ", stuno='" + stuno + '\'' +
                ", computer='" + computer + '\'' +
                ", collar='" + collar + '\'' +
                ", grants='" + grants + '\'' +
                '}';
    }
}