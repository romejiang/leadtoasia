package com.ecfta.foods;

/**
 * @author <a href="mailto:romejiang@gmail.com">Rome.Jiang</a>
 *         Date: 2007-11-7
 *         Time: 14:10:59
 */
public class Cate {
    String name;
    String k;             // 口味
    String h;        // 环境
    String f;        // 服务
    String r; //人均消费
    String adds;
    String tel;
    String desc;
    String t; // 推荐菜
    String keyword; //标签分类


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getK() {
        return k;
    }

    public void setK(String k) {
        this.k = k;
    }

    public String getH() {
        return h;
    }

    public void setH(String h) {
        this.h = h;
    }

    public String getF() {
        return f;
    }

    public void setF(String f) {
        this.f = f;
    }

    public String getR() {
        return r;
    }

    public void setR(String r) {
        this.r = r;
    }

    public String getAdds() {
        return adds;
    }

    public void setAdds(String adds) {
        this.adds = adds;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getT() {
        return t;
    }

    public void setT(String t) {
        this.t = t;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }


    public String toString() {
        return "店名=" + name + "\n" +
                "口味=" + k + "\n" +
                "环境=" + h + "\n" +
                "服务=" + f + "\n" +
                "人均消费=" + r + "\n" +
                "地址=" + adds + "\n" +
                "电话=" + tel + "\n" +
                "介绍=" + desc + "\n" +
                "推荐菜=" + t + "\n" +
                "分类标签=" + keyword + "\n"
                ;
    }
}
