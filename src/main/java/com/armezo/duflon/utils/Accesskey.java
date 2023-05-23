package com.armezo.duflon.utils;

public class Accesskey {
	public static String getAccesskey()
	{
		int key_length=6;
	    String chars = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";
		String pass="";
		
		boolean flag=true;
			
			while(flag)
			{				
				 for(int x=0; x < key_length; x++ )
				 {
					  int  j = (int)Math.floor(Math.random() * 31);
					  pass += chars.charAt(j);
					  flag= false;
				 }				
			 }		     
		
	  return pass;
	}
}
