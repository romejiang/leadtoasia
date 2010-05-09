public class Escpe {
    public static void  main(String []arg){
String s = "asdfasdfads<dasdf  sadfa> asdfasdf<table id=''>asdf</d>";    
print	escape(s);
    } 

        public static String escape(String src) {
     
        char j;
        StringBuffer tmp = new StringBuffer();
 boolean skip = false;
        for (int i = 0; i < src.length(); i++) {
            j = src.charAt(i);
            if (j == '<')	skip = true;
 	    if(!skip){
		tmp.append(j);
	    }
	    if(j== '>')skip = false;

        }
        return tmp.toString();
    }
}