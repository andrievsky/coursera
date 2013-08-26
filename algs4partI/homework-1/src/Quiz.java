
public class Quiz {
	public static void main(String[] args)
    {
		System.out.println("Quiz Start");
		q1("4-7 2-6 9-2 0-8 0-7 5-2");
		q2("8-5 7-2 2-3 9-3 4-0 4-5 1-3 4-7 9-6");
		q3("0 1 2 3 7 6 6 7 9 9");
		q3("7 7 7 8 7 4 0 3 0 7");
		q3("4 0 4 8 4 4 4 4 5 5");
		q3("6 9 0 9 0 2 6 6 8 2");
		q3("7 3 3 3 1 3 3 1 1 1");
		System.out.println("Quiz End");
		
    }
	
	private static void q1(String source)
	{
		System.out.println("Question 1");
		String[] parts = source.split(" ");
		String[] part;
		QFUF qf = new QFUF(10);
		for (int i = 0; i < parts.length; i++)
		{
			part = parts[i].split("-");
			qf.union(Integer.parseInt(part[0]), Integer.parseInt(part[1]));
		}
	}
	
	private static void q2(String source)
	{
		System.out.println("Question 2");
		
		String[] parts = source.split(" ");
		String[] part;
		WQUUF uf = new WQUUF(10);
		for (int i = 0; i < parts.length; i++)
		{
			part = parts[i].split("-");
			uf.union(Integer.parseInt(part[0]), Integer.parseInt(part[1]));
		}
	}
	
	private static void q3(String src)
	{
		System.out.println("Question 3 \n"+src);
		String[] parts = src.split(" ");
		int[] source = new int[parts.length];
		for (int i = 0; i < parts.length; i++)
    	{
			source[i] = Integer.parseInt(parts[i]);
    	}
		int[] roots = new int[source.length];
		int[] parents = new int[source.length];
		int n = 0;
		int deep;
		int p;
		for (int i = 0; i < source.length; i++)
    	{
			deep = deep(source, i, 0);
			if (deep == -1)
			{
				System.out.println("FALSE the id[] array contains a cycle contains a cycle");
				return;
			}
			p = i;
			while (p != source[p]){
	            p = source[p];
				roots[p] += 1;
			}
			parents[source[i]] += 1;
    		if (deep > n) n = deep;
    	}
		int root = 0;
		int parent = 0;
		for (int i = 0; i < parents.length; i++)
    	{
			if (parents[parent] < parents[i]) parent = i;
			if (roots[root] < roots[i]) root = i;
    	}
		if (n > log(source.length, 2))
		{
			System.out.println("FALSE n = "+ n + " > ln("+source.length+" ) = "+log(source.length, 2));
			return;
		}
		for (int i = 0; i < source.length; i++)
    	{
			if (roots[i] * 2 >= roots[source[i]] && i != source[i]) 
			{
				System.out.println("FALSE "+i+" >= parent "+source[i]);
				return;
			}
		}
		System.out.println("OK");
	}
	
	private static int deep(int[] source, int i, int deep)
	{
		if (i != source[i]) return (deep > source.length) ? -1 : deep(source, source[i], deep+1);
		else return deep;
	}
	
	static int log(int x, int base)
	{
	    return (int) (Math.log(x) / Math.log(base));
	}
	
	public static void debug(int[] args)
    {
    	String index = "";
    	String value = "";
    	for (int i = 0; i < args.length; i++)
    	{
    		index += i + " ";
    		value += args[i] + " ";
    	}
    	StdOut.println(index);
    	StdOut.println(value);
    }
}
