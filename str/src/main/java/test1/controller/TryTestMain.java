package test1.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import test1.entity.TestEnum;



public class TryTestMain {
	private static String str;
	private static Integer number;
	@SuppressWarnings({ "unlikely-arg-type", "serial" })
	public static void main(String[] args) {
		Random rd = new Random();
		String strn = null;
		String[] arr = new String[3];
		//System.out.println(rd.nextInt(100-90)+90);//定头不定位随机数（5-100）
		//System.out.println(Math.random());
		
		/*TryTest str1 = new TryTest();
		TryTest str2 = new TryTest();*/
		/*str1.level=1;//str1指向的地址为11
		str2.level=2;//str2指向的地址为22
		System.out.println("str1.level:"+str1.level+";str2:"+str2.level);
		str1 = str2;//将str2的地址22赋给str1，即str1和str2均指向22
		System.out.println("str1.level:"+str1.level+";str2:"+str2.level);
		str1.level=3;//
		System.out.println("str1.level:"+str1.level+";str2:"+str2.level);//str1和str2都等于3*/
		/*str1.level = 1;
		str2.level = 1;
		System.out.println(str1.equals(str2));
		System.out.println(str1.level.equals(str2.level));
		str1.level=str2.level;
		System.out.println(str1.equals(str2));
		System.out.println(str1.level.equals(str2.level));
		str1=str2;
		System.out.println(str1.equals(str2));
		System.out.println(str1.level.equals(str2.level));*/
		/*Double d1 = 23.83;
		System.out.print(d1.intValue());
		System.out.print(Math.round(d1));*/
		/*String str = "My name is guapi! ";
		String[] arrs = {"a","e","i","o","u"};
		String aeiou="";
		for(int i=0;i<str.length();i++) {
			System.out.println(str.charAt(i));
			//String st = Character.toString(str.charAt(i));
			String st = String.valueOf(str.charAt(i));
			if(Arrays.asList(arrs).contains(st)){//Arrays.asList(String[])
				aeiou+=str.charAt(i);
			}
		}
		System.out.println("aeiou=="+aeiou);*/
		/*TryTest.level=1;
		TryTest tr = new TryTest();
		String[] arrs = {"a","e","i","o","u","i","u"};
		System.out.println(Arrays.toString(arrs));
		System.out.println(Arrays.asList(arrs));
		String str = Arrays.toString(arrs);
		List<String> list = Arrays.asList(arrs);
		List<String> ltStr = new ArrayList<String>();
		ltStr.add("z");
		ltStr.add("x");
		ltStr.add("f");
		ltStr.remove(0);
		//list.add("f");
		//list.remove(0);
		System.out.println(list);
		System.out.println(ltStr);
		System.out.println(list.contains("a"));*/
		/*System.out.println();
		
		String[] arrs = {"a","e","i","o","u","i","u"};
		System.out.println(Arrays.asList(arrs));
		List<String> list = Arrays.asList(arrs);
		List<String> a = new ArrayList<String>();
		a.addAll(list);
		a.add("dd");*/
		//String[] arrs = {"1","3","32","5","10","20","21","2","4","50","11","1","5","5","30"};
		/*for(int i=0;i<arrs.length;i++) {
			switch(arrs) {
			case "1":
			}
		}*/
		/*TestEnum te = null;
		switch(te) {
			case ONE: System.out.println("这是一元！");
			default: System.out.println("money");
		}*/
		TestEnum tem = TestEnum.TWENTY;
		for(TestEnum te : TestEnum.values()) {
			System.out.println(te);
		}
		switch(tem) {
			case TWENTY:
				System.out.println("20元");
				break;
			case ONE:
				System.out.println("一元");
				break;
			default:
				System.out.println("未知");
				break;
		}
	}
	

}
 