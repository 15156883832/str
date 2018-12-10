package test1.controller;

import test1.form.PropertiesUtils;

public class OnlyTest {
	
	public static void main(String[] args) {
		System.out.println("${ADMINPATH}==="+PropertiesUtils.get(PropertiesUtils.ADMINPATH));
		System.out.println("${USERS_PATH}==="+PropertiesUtils.get(PropertiesUtils.USERS_PATH));
	}
}
