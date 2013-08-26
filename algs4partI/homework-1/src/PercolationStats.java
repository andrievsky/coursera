
public class PercolationStats {
        
    private double[] results;
    private int N;
    private int T;
    private double sum;
    private double mu;
    private int i;
    private int j;
    
    public PercolationStats(int N, int T)    // perform T independent computational experiments on an N-by-N grid
    {
        if (N <= 0 || T <= 0) throw new java.lang.IllegalArgumentException();
        this.N = N;
        this.T = T;
        int counter;
        results = new double[T];
        for(int t = 0; t < T; t++)
        {
            counter = 0;
            Percolation percolation = new Percolation(N);
            while (!percolation.percolates())
            {
                i = randomInt();
                j = randomInt();
                if (!percolation.isOpen(i, j))
                {
                    percolation.open(i, j);
                    counter++;
                }
            }
           // percolation.debug();
            results[t] = ((double)counter / (N * N));
        }
    }
    public double mean()                     // sample mean of percolation threshold
    {
    	sum = 0;
        for(int i = 0; i < T; i++)
        {
            sum += results[i];
            //StdOut.println(results[i]);
        }
        return sum/T;
    }
    public double stddev()                   // sample standard deviation of percolation threshold
    {
        mu = mean();
        sum = 0;
        for(int i = 0; i < T; i++)
        {
            sum += Math.pow(results[i] - mu, 2);
        }
        return Math.sqrt(sum/(T-1));
    }
    public double confidenceLo()             // returns lower bound of the 95% confidence interval
    {
        return mean() - stddev();
    }
    public double confidenceHi()             // returns upper bound of the 95% confidence interval
    {
        return mean() + stddev();
    }
    public static void main(String[] args)   // test client, described below
    {
        StdOut.println("PercolationStats (N, T)");
        int N = StdIn.readInt();
        int T = StdIn.readInt();
        StdOut.println("experiment started for "+N+", "+T);
        Stopwatch stopwatch = new Stopwatch();
        PercolationStats ps = new PercolationStats(N, T);
        StdOut.println("mean "+ps.mean());
        StdOut.println("stddev "+ps.stddev());
        StdOut.println("confidenceLo "+ps.confidenceLo());
        StdOut.println("confidenceHi "+ps.confidenceHi());
        StdOut.println("stopwatch.elapsedTime "+stopwatch.elapsedTime());
    }
    private int randomInt()
    {
        return 1 + ((int) (Math.random() * (N)));
    }

}
