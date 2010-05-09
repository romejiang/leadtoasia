package com.ecfta.foods;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.GZIPInputStream;

/**
 * @author <a href="mailto:romejiang@gmail.com">Rome.Jiang</a>
 *         Date: 2007-8-14
 *         Time: 18:18:44
 *         <p/>
 *         ��ȡ���ڵ����� ����վ�� ��ʳ��Ϣ������Ȼ��д���ֻ�
 */
public class GetFoods {
    String rootpaht = "d://foods/";


    public static void main(String[] args) {

        GetFoods gets = new GetFoods();
        if (args.length > 0) {
            gets.setRootpaht(args[0]);
        }
        List a = new ArrayList();
//      Step 1 ��ȡ������ʳ ��ҳ �ĵ�ַ ����
//
//        String domain = "http://www.dianping.com";
//        for (int x = 1; x <= 287; x++) {
//            a.addAll(gets.index("http://www.dianping.com/search_m/17/10_p" + x,
//                    "UTF-8"));
//            System.out.println(x);
//        }
//        try {
//            FileUtils.writeLines(new File("d://foods/index.txt"), "gbk", a);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

//          Step 2 ������ҳ������
//        try {
//            a = FileUtils.readLines(new File("d://foods/index.txt"), "gbk");
//            for (int i = 0; i < a.size(); i++) {
//                String s = (String) a.get(i);
//                System.out.println(s);
////                FileUtils.forceMkdir(new File("d://foods/" + (i / 100)));
////                gets.read("http://www.dianping.com" + s, "", "d://foods/" + (i / 100) + "/" + s.substring(s.lastIndexOf("/")) + ".html");
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

//      Step 3  ������ҳ���ݣ���Ϊkey=value ���ݿ�
//        try {
//            a = FileUtils.readLines(new File("d://foods/index.txt"), "gbk");
//            PrintWriter fw = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
//                    new FileOutputStream("d://foods//db.txt"))));
//
//            for (int i = 0; i < a.size(); i++) {
//                String s = (String) a.get(i);
//                // System.out.println("d://foods/" + (i / 100) + "/" + s.substring(s.lastIndexOf("/")) + ".html");
//                Cate c = gets.readFile("d:/foods/" + (i / 100) + s.substring(s.lastIndexOf("/")) + ".html");
//                fw.write("id=" + (i + 1) + "\n");
//                fw.write("path=d:/foods/" + (i / 100) + s.substring(s.lastIndexOf("/")) + ".html\n");
//                fw.write(c.toString());
//                System.out.println(i);
//                //   gets.readFile(s);
//            }
//            fw.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

        //Step 4 ��ȡ���ݿ��ļ������� List
        try {
            List db = new ArrayList();
            a = FileUtils.readLines(new File("d:/foods/db.txt"), "gbk");
            for (int i = 0; i < a.size();) {
                i++;
                i++;
                Cate e = new Cate();
                e.setName(getValues((String) a.get(i++)));
                e.setK(getValues((String) a.get(i++)));
                e.setH(getValues((String) a.get(i++)));
                e.setF(getValues((String) a.get(i++)));
                e.setR(getValues((String) a.get(i++)));
                e.setAdds(getValues((String) a.get(i++)));
                e.setTel(getValues((String) a.get(i++)));
                e.setDesc(getValues((String) a.get(i++)));
                e.setT(getValues((String) a.get(i++)));
                e.setKeyword(getValues((String) a.get(i++)));
                System.out.println(i * 100 / a.size() + "%");
                db.add(e);
//    String name;
//    String k;             // ��ζ
//    String h;        // ����
//    String f;        // ����
//    String r; //�˾�����
//    String adds;
//    String tel;
//    String desc;
//    String t; // �Ƽ���
//    String keyword; //��ǩ����
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println((String) a.get(i++));
//                System.out.println("=========");
            }
        } catch (IOException e) {
            System.out.println(e);
        }

        while (true) {

            String str = inputString();
            if (str.trim().equalsIgnoreCase("end")) {
                break;
            }
            System.out.println(str);

            
        }

//        int x = 0;
//        try {
//            x = System.in.read();
//        } catch (IOException e) {
//            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//        }
//        System.out.println(x);
//        Get.start("http://dm.www.wangyou.com/html/class32/comic386.html");
    }

    public static String inputString() {
        StringBuilder str = new StringBuilder();
        boolean enter = true;
        try {
            while (enter) {
                int x = System.in.read();
                if (x == 10) {
                    enter = false;
                } else {
                    str.append((char) x);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return str.toString();
    }

    public static String getValues(String v) {
        if (v.indexOf("=") != -1) {
            return v.substring(v.indexOf("=") + 1);
        }
        return v;
    }

    /**
     * ����ÿ��js���ļ���Ȼ���ŵ�ַ��Ȼ��ץȡ���е�����ͼƬ
     *
     * @param file
     */
    public Cate readFile(String file) {

        try {
            String content = FileUtils.readFileToString(new File(file), "gbk");
//            System.out.println(content);
            Cate cate = new Cate();
            cate.setName(getTag(content, "<title>", "</title>").replaceAll("_���ڵ�����", ""));
            cate.setK(getTag(content, "��ζ&nbsp;<span class=\"TColor12 Bold\">", "</span>"));
            cate.setH(getTag(content, "����&nbsp;<span class=\"TColor12 Bold\">", "</span>"));
            cate.setF(getTag(content, "����&nbsp;<span class=\"TColor12 Bold\">", "</span>"));
            cate.setR(getTag(content, "�˾�&nbsp;<span class=\"TColor12 Bold\">", "</span>"));
            cate.setAdds(getTag(content, "<b>��ַ:</b>", "<a class=\"BL\""));
            if (StringUtils.isBlank(cate.getAdds())) {
                cate.setAdds(getTag(content, "<b>��ַ:</b>", "<b>�绰:</b>"));
            }
            cate.setTel(getTag(content, "<b>�绰:</b>", "<br /></div>"));
            cate.setKeyword(getTag(content, "<h3>�����ǩ&nbsp;&nbsp;</h3>", "<h3>�̻����</h3>"));
            if (StringUtils.isBlank(cate.getKeyword())) {
                cate.setKeyword(getTag(content, "<h3>�����ǩ&nbsp;&nbsp;</h3>", "<div class=\"Blank\">"));
            }
            cate.setDesc(getTag(content, "<h3>�̻����</h3>", "</div></div><div class=\"Item\">"));
            cate.setT(getTag(content, "<h3>�Ƽ���", "<div class=\"Reviews\">").replaceAll("\\[���͵��ֻ�\\]", ""));


            cate.setK(cate.getK().replace("-", ""));
            cate.setH(cate.getH().replace("-", ""));
            cate.setF(cate.getF().replace("-", ""));
            cate.setR(cate.getR().replace("-", ""));
            cate.setR(cate.getR().replace("��", ""));
            cate.setKeyword(cate.getKeyword().replace("���ޱ�ǩ", ""));
            cate.setKeyword(cate.getKeyword().replaceAll("\\([0-9]*\\)", ","));
            cate.setKeyword(cate.getKeyword().replaceAll("\\?", ","));
            cate.setKeyword(cate.getKeyword().replaceAll("\\(", ""));
            cate.setKeyword(cate.getKeyword().replaceAll("\\)", ""));
            cate.setT(cate.getT().replaceAll("\\([0-9]*\\)", ","));

            //System.out.println(cate);
            return cate;
        } catch (IOException e) {
            System.out.println(e);
        }
        return new Cate();
    }

    /**
     * ������Ҫ���ҵ�content�����ݵĿ�ʼ���start,�������end�����ز��ҵĽ��
     *
     * @param content
     * @param start
     * @param end
     * @return
     */
    public static String getTag(String content, String start, String end) {
        String reg = start + "[^\f]*?" + end;
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher(content);
        String temp = "";
        try {
            if (m.find()) {
                temp = m.group();
            } else {
                int start_position = content.indexOf(start);
                int end_position = content.indexOf(end);
//                System.out.println("HtmlSense Reg Error! " +
//                        "start_position" + start_position + start+ " end_position" + end_position + end );
                if (start_position != -1 &&
                        end_position != -1) {
                    temp = content.substring(start_position + start.length(), end_position);
                }
            }
            temp = temp.replaceAll(start, "");
            temp = temp.replaceAll(end, "");
            temp = temp.replaceAll("<.*?>", "");
            temp = temp.replaceAll("&nbsp;", "");
            temp = temp.replaceAll("\n", "");
            temp = temp.replaceAll("\t", "");
            temp = temp.replaceAll("\r", "");


        } catch (Exception e) {
            // System.out.println("HtmlSense" + e);
        }
        return temp;
    }


    public String getFind(String master, String regx) {
        Pattern p = Pattern.compile(regx);
        Matcher m = p.matcher(master);
        if (m.find()) {
            return m.group(1);
        }
        return null;
    }


    public List index(String link, String codeing) {
        Set result = new TreeSet();
        try {
            URL url = new URL(link);
            HttpURLConnection httpurlconnection = (HttpURLConnection) url.openConnection();
            httpurlconnection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1; Alexa Toolbar)");
            httpurlconnection.setRequestProperty("accept-encoding", "gzip, deflate");
            httpurlconnection.setRequestProperty("accept-language", "zh-cn");
            httpurlconnection.setRequestProperty("accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*");

            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
            System.setProperty("sun.net.client.defaultReadTimeout", "60000");

            InputStream inputstream = httpurlconnection.getInputStream();
//            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader((inputstream)));
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(new GZIPInputStream(inputstream)));

            String s;
            String temp;
            while ((s = bufferedreader.readLine()) != null) {
                // System.out.println(s);
                temp = getFind(s, "\\\"(/shop/[0-9]*)\\\"");
                if (temp != null) {
                    result.add(temp);
                }
            }

            bufferedreader.close();
            inputstream.close();
            httpurlconnection.disconnect();

        }
        catch (MalformedURLException malformedurlexception) {
            System.out.println(malformedurlexception.toString());
        }
        catch (IOException ioexception) {
            System.out.println(ioexception.toString());
        }
        return new ArrayList(result);

    }


    public void read(String link, String codeing, String file) {
        List result = new ArrayList();
        try {
            URL url = new URL(link);
            HttpURLConnection httpurlconnection = (HttpURLConnection) url.openConnection();
            httpurlconnection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1; Alexa Toolbar)");
            httpurlconnection.setRequestProperty("accept-encoding", "gzip, deflate");
            httpurlconnection.setRequestProperty("accept-language", "zh-cn");
            httpurlconnection.setRequestProperty("accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*");

            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
            System.setProperty("sun.net.client.defaultReadTimeout", "60000");

            InputStream inputstream = httpurlconnection.getInputStream();
//            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader((inputstream)));
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(new GZIPInputStream(inputstream), "utf8"));

            String s;

            while ((s = bufferedreader.readLine()) != null) {
//                System.out.println(s);
                result.add(s);
//                result.append("\n");
            }

            bufferedreader.close();
            inputstream.close();
            httpurlconnection.disconnect();
            // System.out.println(result.size());
            FileUtils.writeLines(new File(file), null, result);
        }
        catch (MalformedURLException malformedurlexception) {
            System.out.println(malformedurlexception.toString());
        }
        catch (IOException ioexception) {
            System.out.println(ioexception.toString());
        }

    }

    public String getRootpaht() {
        return rootpaht;
    }

    public void setRootpaht(String rootpaht) {
        this.rootpaht = rootpaht;
    }
}