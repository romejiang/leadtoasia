


public class mapbar {
    public static void  main(String []arg){
	Decode("HESHECZVVJGDU");
    }



  
  public static String  Decode(encodedcoord)
  //解密坐标
  { 
    def   int EncodeKey = 3409;
  //加密密钥，数值型；可以每个客户都不一样
    def int MaxNumPos=-1;
    //最大数位的位置
    def int MaxNum=0;
    //最大数
    def   Org='';
    //出除修改后的原始值
    def index = 0;
    encodedcoord.each{
      def Tmp=Character.digit(encodedcoord.charAt(index),36)-10;
      //println Tmp;
	if(Tmp>=10)
		Tmp=Tmp-7;
	
	Org+=Integer.toString(Tmp,36);
	if(Tmp>MaxNum)
	{
		MaxNumPos=index
		MaxNum=Tmp
	}
	//获取最大数及其位置

      index++;
    } 
     //println Org
     def Diff=Long.parseLong(Org.substring(0,MaxNumPos),16);
    //纬度-经度
     def Sum=Long.parseLong(Org.substring(MaxNumPos+1),16);
     //纬度+经度
  

        //纬度+经度
     def Coord=[]
     //坐标
     Coord[0]=(Diff+Sum- EncodeKey)/2;
     //纬度
     Coord[1]=(Sum-Coord[0])/100000.0;
     //经度
     Coord[0]/=100000.0;

     println Coord[0]
     println Coord[1]
	return Coord;
  }
}