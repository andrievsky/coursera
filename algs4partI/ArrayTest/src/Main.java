
public class Main {
	
	public static void main(String[] args)   // test client, described below
    {
		Stopwatch stopwatch = new Stopwatch();
		int n = 512;
		int g[][] = new int[n][n];
		for(int i = 0; i < n; i++) {
		    for(int j = 0; j < n; j++) {
		        g[i][j] = i + j;  
		    }
		}
		double time1 = stopwatch.elapsedTime();
		StdOut.println("stopwatch.elapsedTime "+time1);
		stopwatch = new Stopwatch();
		g = new int[n][n];
		for(int i = 0; i < n; i++) {
		    g[i][i] = 2* i;
		    for(int j = 0; j < i; j++) {
		        g[j][i] = g[i][j] = i + j; 
		    }
		}
		double time2 = stopwatch.elapsedTime();
		StdOut.println("stopwatch.elapsedTime "+time2);
		StdOut.println("diff "+time2/time1);
    }

}
