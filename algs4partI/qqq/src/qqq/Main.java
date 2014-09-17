package qqq;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class Main {

	public static Date date;
	public static void main(String[] args) {
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			  @Override
			  public void run() {
				  date = new Date();
				  date = null;
				  print();
			  }
			}, 1000, 1000);

	}
	
	private static void print(){
		Runtime runtime = Runtime.getRuntime();

	    NumberFormat format = NumberFormat.getInstance();

	    StringBuilder sb = new StringBuilder();
	    long maxMemory = runtime.maxMemory();
	    long allocatedMemory = runtime.totalMemory();
	    long freeMemory = runtime.freeMemory();

	    sb.append("free memory: " + format.format(freeMemory / 1024) + " ");
	    sb.append("allocated memory: " + format.format(allocatedMemory / 1024) + " ");
	    sb.append("max memory: " + format.format(maxMemory / 1024) + " ");
	    sb.append("total free memory: " + format.format((freeMemory + (maxMemory - allocatedMemory)) / 1024) + " ");
	    System.out.println(sb.toString());
	}

}
