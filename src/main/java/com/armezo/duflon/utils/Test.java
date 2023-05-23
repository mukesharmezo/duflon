package com.armezo.duflon.utils;

public class Test {
	
	public static void main(String[] a) {
		String a1="Secretarial";
		String division="Secretarial";
	if(a1.replaceAll("[^a-zA-Z0-9]", "").equals( division.replaceAll("[^a-zA-Z0-9]", ""))){
		System.out.println("Cal...");
	}else {
		System.out.println("else ....Cal...");
	}
	}
}
