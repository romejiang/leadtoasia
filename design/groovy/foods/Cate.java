package com.ecfta.foods;

/**
 * @author <a href="mailto:romejiang@gmail.com">Rome.Jiang</a>
 *         Date: 2007-11-7
 *         Time: 14:10:59
 */
public class Cate {
    String name;
    String k;             // ��ζ
    String h;        // ����
    String f;        // ����
    String r; //�˾�����
    String adds;
    String tel;
    String desc;
    String t; // �Ƽ���
    String keyword; //��ǩ����


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
        return "����=" + name + "\n" +
                "��ζ=" + k + "\n" +
                "����=" + h + "\n" +
                "����=" + f + "\n" +
                "�˾�����=" + r + "\n" +
                "��ַ=" + adds + "\n" +
                "�绰=" + tel + "\n" +
                "����=" + desc + "\n" +
                "�Ƽ���=" + t + "\n" +
                "�����ǩ=" + keyword + "\n"
                ;
    }
}
