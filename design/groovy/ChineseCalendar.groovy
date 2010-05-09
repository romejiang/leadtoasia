/**
 * ChineseCalendarGB.java
 * Copyright (c) 1997-2002 by Dr. Herong Yang
 * 中国农历算法 - 实用于公历 1901 年至 2100 年之间的 200 年 
 */
import java.text.*;
import java.util.*;

class ChineseCalendar {
/*****************************************************************************
                                   日期资料
*****************************************************************************/
def ttime=0;
def tInfo=[
0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
0x14b63]

def solarMonth=[31,28,31,30,31,30,31,31,30,31,30,31]
def Gan=["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
def Zhi=["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
def Animals=["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"]
def sTermInfo = [0,21208,42467,63836,85337,107014,128867,150921,173149,195551,218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758]
def nStr1 = ['日','一','二','三','四','五','六','七','八','九','十']
def nStr2 = ['初','十','廿','卅','□']
def monthName = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]


/*****************************************************************************
日期计算
*****************************************************************************/

//====================================== 返回农历 y年的总天数
public lYearDays(y) {
    def i, sum = 348;
    for(i=0x8000; i>0x8; i>>=1) sum += (tInfo[y-1900] & i)? 1: 0;
    return(sum+leapDays(y));
}

//====================================== 返回农历 y年闰月的天数
public leapDays(y) {
    if(leapMonth(y))  return((tInfo[y-1900] & 0x10000)? 30: 29);
    else return(0);
}

//====================================== 返回农历 y年闰哪个月 1-12 , 没闰返回 0
public leapMonth(y) {
    return(tInfo[y-1900] & 0xf);
}

//====================================== 返回农历 y年m月的总天数
def monthDays(y,m) {
    return( (tInfo[y-1900] & (0x10000>>m))? 30: 29 );
}

    //==============================返回公历 y年某m+1月的天数
def solarDays(y,m) {
    if(m==1)
    return(((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 29: 28);
    else
    return(solarMonth[m]);
}
    //============================== 传入 offset 返回干支, 0=甲子
 def cyclical(num) {
    num = num.abs().intValue()
//    println "======" + num 
    return(Gan[num%10]+Zhi[num%12]);
}


//===== 某年的第n个节气为几日(从0小寒起算)
public sTerm(y,n) {
    if(y==2009 && n==2){sTermInfo[n]=43467}
 
    def cal = Calendar.getInstance()
    cal.set(1900,0,6,2,5,0)

    def temp = new BigDecimal(31556925974.7).multiply(new BigDecimal(y-1900)) + new BigDecimal(sTermInfo[n] ).multiply(new BigDecimal(60000)) + -2208549300000
    
    cal.setTimeInMillis(temp.longValue());
    cal.setTimeZone(TimeZone.getTimeZone("UTC"))


    println "============= ${temp.longValue()}  ${cal.getTime()}  ${cal.get(Calendar.DAY_OF_MONTH)}"
 
    return(cal.get(Calendar.DAY_OF_MONTH));
}

//============================== 返回阴历控件 (y年,m+1月)
/*
功能说明: 返回整个月的日期资料控件

使用方式: OBJ = new calendar(年,零起算月);

OBJ.length      返回当月最大日
OBJ.firstWeek   返回当月一日星期

由 OBJ[日期].属性名称 即可取得各项值

OBJ[日期].isToday  返回是否为今日 true 或 false

其他 OBJ[日期] 属性参见 calElement() 中的注解
*/
  
    def calendar = {y,m ->

        def sDObj, lDObj, lY, lM, lD=1, lL, lX=0, tmp1, tmp2, tmp3;
        def cY, cM, cD; //年柱,月柱,日柱
        def lDPOS = [3]
        def n = 0;
        def firstLM = 0;
        def days = []

        sDObj = Calendar.getInstance()
        sDObj.set(y,m,1)   //当月一日日期

        def length    = solarDays(y,m);    //公历当月天数
        def firstWeek = sDObj.get(Calendar.DAY_OF_WEEK )-1 ;    //公历当月1日星期几

        ////////年柱 1900年立春后为庚子年(60进制36)
        if(m<2) cY=cyclical(y-1900+36-1);
        else cY=cyclical(y-1900+36);
        def term2=sTerm(y,2); //立春日期
 
        ////////月柱 1900年1月小寒以前为 丙子月(60进制12)
        def firstNode = sTerm(y,m*2) //返回当月「节」为几日开始
         
        cM = cyclical((y-1900)*12+m+12);

        //当月一日与 1900/1/1 相差天数
        //1900/1/1与 1970/1/1 相差25567日, 1900/1/1 日柱为甲戌日(60进制10)
        def cal = Calendar.getInstance()
        cal.setTimeZone(TimeZone.getTimeZone("UTC"))
        cal.set(y,m,1 ,0,0,0) //Date.UTC(y,m,1,0,0,0,0)

        def dayCyclical = (cal.getTimeInMillis()/86400000+25567+10).longValue();
 
        for(def i=0;i<length;i++) {

            if(lD>lX) {
           // sDObj = new Date(y,m,i+1);    //当月一日日期
            
            lDObj =  Lunar(new Date(y,m,i+1));     //农历
            lY    = lDObj.year;           //农历年
            lM    = lDObj.month;          //农历月
            lD    = lDObj.day;            //农历日
            lL    = lDObj.isLeap;         //农历是否闰月
            lX    = lL? leapDays(lY): monthDays(lY,lM); //农历当月最后一天

            if(n==0) firstLM = lM;
            lDPOS[n++] = i-lD+1;
            }

            //依节气调整二月分的年柱, 以立春为界
            if(m==1 && (i+1)==term2) cY=cyclical(y-1900+36);
            //依节气月柱, 以「节」为界
            if((i+1)==firstNode) cM = cyclical((y-1900)*12+m+13);
            //日柱
            cD = cyclical(dayCyclical+i);

//            def isToday = false
//            //瓣句
//            def sYear
//            def sMonth
//            def sDay
//            def week
//            //农历
//            def lYear
//            def lMonth
//            def lDay
//            def isLeap
//            //八字
//            def cYear
//            def cMonth
//            def cDay
            days[i] = new calElement(sYear :y, sMonth : m+1, sDay : i+1, week : nStr1[(i+firstWeek)%7],
            lYear : lY, lMonth : lM, lDay : lD++, isLeap : lL,
            cYear : cY ,cMonth : cM, cDay : cD );
        }
         

        //今日
        //if(y==tY && m==tM) this[tD-1].isToday = true;
        return days
    }
 
//====================================== 算出农历, 传入日期控件, 返回农历日期控件
//                                       该控件属性有 .year .month .day .isLeap
     
    def Lunar = {objDate ->
        println objDate
        def cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"))
        cal.set(objDate.getYear(),objDate.getMonth(),objDate.getDate(),0,0,0)
         println Math.round(cal.getTimeInMillis() / 10000) * 10000;

        cal.set(1900,0,31)
         println Math.round(cal.getTimeInMillis() / 10000) * 10000;

        def result = [:]
        def i, leap=0, temp=0;
        def offset   = ( new Date(objDate.getYear(),objDate.getMonth(),objDate.getDate()).getTime() - new Date(1900,0,31).getTime())/86400000;

//        println new Date(objDate.getYear(),objDate.getMonth(),objDate.getDate()).getTime() + "||" + new Date(1900,0,31).getTime()  

        for(i=1900; i<2050 && offset>0; i++) { temp=lYearDays(i); offset-=temp; }

        if(offset<0) { offset+=temp; i--; }

        result.year = i;

        leap = leapMonth(i); //闰哪个月
        result.isLeap = false;

        for(i=1; i<13 && offset>0; i++) {
        //闰月
        if(leap>0 && i==(leap+1) && result.isLeap==false)
        { --i; result.isLeap = true; temp = leapDays(result.year); }
        else
        { temp = monthDays(result.year, i); }

        //解除闰月
        if(result.isLeap==true && i==(leap+1)) result.isLeap = false;

        offset -= temp;
        }

        if(offset==0 && leap>0 && i==leap+1)
        if(result.isLeap)
        { result.isLeap = false; }
        else
        { result.isLeap = true; --i; }

        if(offset<0){ offset += temp; --i; }

        result.month = i;
        result.day = offset + 1;

        return result
    }

    public getInfo (){
        def Today = Calendar.getInstance()
        def tY = Today.get(Calendar.YEAR );
        def tM = Today.get(Calendar.MONTH );
        def tD = Today.get(Calendar.DAY_OF_MONTH );
         
        
        def cld =   calendar(tY,tM); 
        println "init $tY $tM $tD"

        def d = tD - 1;
        return  cld[d].sYear+' 年 '+cld[d].sMonth+' 月 '+cld[d].sDay+' 日\n星期'+cld[d].week+'\n'+
        '农历'+(cld[d].isLeap?'闰 ':' ')+cld[d].lMonth+' 月 '+cld[d].lDay+' 日\n'+
        ''+cld[d].cYear+'年 '+cld[d].cMonth+'月 '+cld[d].cDay + '日' ;
    }
 

 
 
    //显示详细日期资料
    static void main (arg) {
        
        def cc = new ChineseCalendar()

        println  cc.getInfo()

    }
    

}
 
 //============================== 阴历属性
class  calElement{
    def isToday = false
    //瓣句
    def sYear
    def sMonth
    def sDay
    def week
    //农历
    def lYear
    def lMonth
    def lDay
    def isLeap
    //八字
    def cYear
    def cMonth
    def cDay
}