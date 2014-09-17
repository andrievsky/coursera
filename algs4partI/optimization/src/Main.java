import java.io.IOException;

import qs.QSException;

/***
 * http://algs4.cs.princeton.edu/65reductions/
 * http://math.semestr.ru/simplex/simplex.php
 * http://www.math.uwaterloo.ca/~bico//qsopt/software/java/develop.htm#solve
 * http://ru.wikipedia.org/wiki/Метод_Гаусса_—_Жордана
 * http://www.htbs-miit.ru:9999/biblio/books/math/m1.pdf
 * 
 * http://math.semestr.ru/simplex/simplex1.php optimization for Math Modeling labs
 * 
 * @author nick
 *
 */


public class Main {
	
	static public void main(String[] args)
	{
		//test1();
		String[] params = new String[]{"assets/problem2.lp"};
		try {
			QSoptSolver.main(params);
		} catch (QSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		test1();
	}
	
	public static void test(double[][] A, double[] b, double[] c) {
        Simplex lp = new Simplex(A, b, c);
        StdOut.println("value = " + lp.value());
        double[] x = lp.primal();
        for (int i = 0; i < x.length; i++)
            StdOut.println("x[" + i + "] = " + x[i]);
        double[] y = lp.dual();
        for (int j = 0; j < y.length; j++)
            StdOut.println("y[" + j + "] = " + y[j]);
    }
	// x0 = 3.5, x1 = 1, opt = 12.5
    public static void test1() {
        double[] c = {  3.0,  2.0 };
        double[] b = { 6.0, 8.0, 1.0, 2.0 };
        double[][] A = {
            {  1.0, 2.0 },
            {  2.0,  1.0 },
            { -1.0, 1.0 },
            { 0.0, 1.0 }
        };
        test(A, b, c);
    }
    
    public static void test2() {
        double[] c = {  1.0,  1.0 };
        double[] b = { 6.0, 8.0, 1.0, 2.0 };
        double[][] A = {
            {  5.0, 1.0 },
            {  2.0,  1.0 },
            { -1.0, 1.0 },
            { 0.0, 1.0 }
        };
        test(A, b, c);
    }
}
