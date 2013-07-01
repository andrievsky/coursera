#!/usr/bin/env node

var NUMBERS_COUNT = 100;
var DELIMITER = ",";


function isPrime(n) { 
    var i; 
    if (n < 2) { // 1, 0, and negative numbers are not prime. 
      return false; 
    } 
    for (i = n - 1; i > 0; i--) { 
      if (i == 1) { 
        return true; 
      } 
      if (n % i == 0) { 
        return false; 
      } 
    } 
  } 

function getPrimes(n) {
    var i = 2, primes = [];
    while (primes.length < n)
    {
        if (isPrime(i)) primes.push(i);
        i++;
    }
    return primes;
}


// Print to console
var fmt = function(arr) {
	return arr.toString();
};

var fs = require('fs');
var outfile = "prime-numbers.txt";
var out = fmt(getPrimes(NUMBERS_COUNT));
fs.writeFileSync(outfile, out);  
console.log("Script: " + __filename + "\nWrote:\n" + out + "\nTo: " + outfile);