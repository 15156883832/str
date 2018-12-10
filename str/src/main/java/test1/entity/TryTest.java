package test1.entity;

import java.util.Date;

public class TryTest {
	public static Integer level;
	public  TryTest() {
		/*TryTest.level= num*2;
		System.out.println("参数："+num+",结果："+TryTest.level);*/
		super();
		this.level = 2;
	}
	
	public TryTest(Integer id){
		this();
		this.level = id;
	}
}
