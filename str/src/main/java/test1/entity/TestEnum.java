package test1.entity;

public enum TestEnum {//new Enum<TestEnum>("","")
	/*这段代码实际上调用了5次 Enum(String name, int ordinal)：

	new Enum<TestEnum>("ONE",0);
	new Enum<TestEnum>("TWO",1);
	new Enum<TestEnum>("FIVE",2);
	new Enum<TestEnum>("TWO",3);
	new Enum<TestEnum>("TEN",4);
	new Enum<TestEnum>("TWENTY",5);*/
	//ONE,TWO,FIVE,TEN,TWENTY;
	
	ONE("1",1),TWO("2",2),FIVE("5",3),TEN("10",4),TWENTY("20",5);
	private String name;
	private Integer index;
	private TestEnum(String val,Integer idx) {
		this.setName(val);
		this.setIndex(idx);
	}
	public Integer getIndex() {
		return index;
	}
	public void setIndex(Integer index) {
		this.index = index;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
