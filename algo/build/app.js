/**
 * Created by nick on 10/21/15.
 */
var MergeSort = (function () {
    function MergeSort() {
    }
    MergeSort.prototype.sort = function (values) {
        this.numbers = values;
        this.length = values.length;
        this.helper = [];
        this.mergesort(0, this.length - 1);
    };
    MergeSort.prototype.mergesort = function (low, high) {
        // check if low is smaller then high, if not then the array is sorted
        if (low < high) {
            // Get the index of the element which is in the middle
            var middle = Math.floor(low + (high - low) / 2);
            // Sort the left side of the array
            this.mergesort(low, middle);
            // Sort the right side of the array
            this.mergesort(middle + 1, high);
            // Combine them both
            this.merge(low, middle, high);
        }
    };
    MergeSort.prototype.merge = function (low, middle, high) {
        // Copy both parts into the helper array
        for (var i = low; i <= high; i++) {
            this.helper[i] = this.numbers[i];
        }
        var i = low;
        var j = middle + 1;
        var k = low;
        // Copy the smallest values from either the left or the right side back
        // to the original array
        while (i <= middle && j <= high) {
            if (this.helper[i] <= this.helper[j]) {
                this.numbers[k] = this.helper[i];
                i++;
            }
            else {
                this.numbers[k] = this.helper[j];
                j++;
            }
            k++;
        }
        // Copy the rest of the left side of the array into the target array
        while (i <= middle) {
            this.numbers[k] = this.helper[i];
            k++;
            i++;
        }
    };
    return MergeSort;
})();
/**
 * Created by nick on 10/21/15.
 */
///<reference path="MergeSort.ts"/>
///<reference path="../../typings/node/node.d.ts"/>
var fs = require('fs');
var Inversions = (function () {
    function Inversions() {
    }
    Inversions.prototype.run = function () {
        var input = fs.readFileSync('resources/IntegerArray.txt').toString().split("\n");
        var data = input.map(function (value) {
            return parseInt(value);
        });
        this.runFromSource(data);
    };
    Inversions.prototype.runFromSource = function (input) {
        input.forEach(function (value, index, src) {
            if (typeof (value) != 'number')
                console.log(value + " is NAN !!!");
        });
        this.iterations = 0;
        this.calculate(input);
        console.log('\nElements: ' + input.length + ' Inversions: ' + this.iterations);
        return this.iterations;
    };
    Inversions.prototype.calculate = function (source) {
        var mergeSort = new MergeSort();
        var sorted = source.concat();
        mergeSort.sort(sorted);
        var connections = [];
        var i, j;
        for (i = 0; i < sorted.length; i++) {
            connections[i] = source.indexOf(sorted[i]);
        }
        for (i = 0; i < connections.length; i++) {
            for (j = 0; j < i; j++) {
                if (connections[i] < connections[j])
                    this.iterations++;
            }
        }
    };
    return Inversions;
})();
/**
 * Created by nick on 10/23/15.
 */
var QuickSort = (function () {
    function QuickSort() {
    }
    QuickSort.prototype.sort = function (source, getPivot) {
        if (source.length < 2)
            return;
        this.partision(source, 0, source.length - 1, getPivot);
    };
    QuickSort.prototype.partision = function (source, left, right, getPivot) {
        if (left >= right)
            return;
        var index = getPivot(left, right);
        this.pivot = source[index];
        //this.swap(source, index, left);
        this.i = left + 1;
        for (this.j = this.i; this.j <= right; this.j++) {
            if (source[this.j] < this.pivot) {
                this.swap(source, this.i, this.j);
                this.i++;
            }
        }
        if (this.debug)
            this.debug(source, left, right, this.pivot, index, this.i, this.j);
        this.swap(source, index, this.i - 1);
        index = this.i - 1;
        this.partision(source, left, index - 1, getPivot);
        this.partision(source, index + 1, right, getPivot);
    };
    QuickSort.prototype.swap = function (source, a, b) {
        this.tmp = source[a];
        source[a] = source[b];
        source[b] = this.tmp;
    };
    return QuickSort;
})();
///<reference path="week1/Inversions.ts"/>
///<reference path="week2/QuickSort.ts"/>
var App = (function () {
    function App() {
        //var ex1:Inversions = new Inversions();
        //ex1.run();
    }
    return App;
})();
new App();
/**
 * Created by nick on 10/24/15.
 */
var Resource = (function () {
    function Resource() {
    }
    Resource.loadNumbers = function (path) {
        var res = fs.readFileSync(path).toString().split("\n").map(function (value) {
            return parseInt(value);
        });
        return res;
    };
    return Resource;
})();
