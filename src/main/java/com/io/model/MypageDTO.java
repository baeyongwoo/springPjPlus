package com.io.model;

import java.util.Date;

public class MypageDTO {
    private Long tno;
    private String tmptitle;
    private Date tmpregdate;
    private String tmpcontent;
    private String uname;
    private String category;
    private String dname;

    // Getters and Setters
    public Long getTno() {
        return tno;
    }

    public void setTno(Long tno) {
        this.tno = tno;
    }

    public String getTmptitle() {
        return tmptitle;
    }

    public void setTmptitle(String tmptitle) {
        this.tmptitle = tmptitle;
    }

    public Date getTmpregdate() {
        return tmpregdate;
    }

    public void setTmpregdate(Date tmpregdate) {
        this.tmpregdate = tmpregdate;
    }

    public String getTmpcontent() {
        return tmpcontent;
    }

    public void setTmpcontent(String tmpcontent) {
        this.tmpcontent = tmpcontent;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }
}
