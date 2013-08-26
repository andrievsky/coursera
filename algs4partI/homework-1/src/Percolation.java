public class Percolation  {
    
    private boolean[] openSites;
    private int topSite;
    private int bottomSite;
    private int N;
    private WeightedQuickUnionUF uf;
    private WeightedQuickUnionUF uf2;
    
    public Percolation(int N)
    {
        uf = new WeightedQuickUnionUF(((int) Math.pow((N+1), 2)+2));
        uf2 = new WeightedQuickUnionUF(((int) Math.pow((N+1), 2)+1));
        this.N = N;
        openSites = new boolean[((int) Math.pow(N, 2)+2)];
        topSite = (int) Math.pow(N, 2);
        bottomSite = topSite + 1;
        
    }
    
    public void open(int i, int j)
    {
        if (i < 1 || i > N || j < 1 || j > N) throw new java.lang.IndexOutOfBoundsException();
        
        openSites[getSite(i, j)] = true;
        //top
        if (i == 1) connect(getSite(i, j), topSite);
        else if (openSites[getSite(i-1, j)]) connect(getSite(i, j), getSite(i-1, j));
        //bottom
        if (i == N) uf.union(getSite(i, j), bottomSite);
        else if (openSites[getSite(i+1, j)]) connect(getSite(i, j), getSite(i+1, j));
        //left
        if (j > 1 && openSites[getSite(i, j-1)]) connect(getSite(i, j), getSite(i, j-1));
        // right
        if (j < N && openSites[getSite(i, j+1)]) connect(getSite(i, j), getSite(i, j+1));
    }
    private void connect(int i, int j)
    {
    	uf.union(i, j);
    	uf2.union(i, j);
    }
    public boolean isOpen(int i, int j)
    {
    	if (i < 1 || i > N || j < 1 || j > N) throw new java.lang.IndexOutOfBoundsException();
        return openSites[getSite(i, j)];
    }
    public boolean isFull(int i, int j)
    {
    	if (i < 1 || i > N || j < 1 || j > N) throw new java.lang.IndexOutOfBoundsException();
        return uf2.connected(topSite, getSite(i, j));
    }
    public boolean percolates()
    {
        return uf.connected(topSite, bottomSite);
    }
    private int getSite(int i, int j)
    {
    	return ((i-1)*N)+(j-1);
    }
}
