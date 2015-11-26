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
                console.log(value + " type is NAN");
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
            return true;
        var i;
        var j;
        var index = getPivot(left, right, source);
        var pivot = source[index];
        this.swap(source, index, left);
        index = left;
        i = left + 1;
        for (j = i; j <= right; j++) {
            if (source[j] < pivot) {
                this.swap(source, j, i);
                i++;
            }
        }
        this.swap(source, index, i - 1);
        index = i - 1;
        if (left < index - 1)
            this.partision(source, left, index - 1, getPivot);
        if (index + 1 < right)
            this.partision(source, index + 1, right, getPivot);
    };
    QuickSort.prototype.swap = function (source, a, b) {
        var tmp;
        if (a == b)
            return;
        tmp = source[a];
        source[a] = source[b];
        source[b] = tmp;
    };
    QuickSort.getPivotMedian = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        var length = max - min + 1;
        var index = min + ((length % 2 == 0) ? length / 2 - 1 : Math.floor(length / 2));
        if (sources[index] > sources[min]) {
            if (sources[index] < sources[max])
                return index;
            else
                return (sources[min] < sources[max]) ? max : min;
        }
        else {
            if (sources[min] < sources[max])
                return min;
            else
                return (sources[index] > sources[max]) ? index : max;
        }
    };
    QuickSort.getPivotFirst = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return min;
    };
    QuickSort.getPivotLast = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return max;
    };
    return QuickSort;
})();
/**
 * Created by nick on 10/24/15.
 */
var Resource = (function () {
    function Resource() {
    }
    Resource.loadNumbers = function (path) {
        var res = fs.readFileSync(path).toString().split("\n").map(function (value) {
            return parseInt(value);
        }).filter(function (value, index, array) {
            return !isNaN(value);
        });
        return res;
    };
    Resource.loadGraph = function (path) {
        var res = fs.readFileSync(path).toString().split('\n')
            .map(function (row) {
            return row.split('\t')
                .map(function (value, index, array) {
                return parseInt(value);
            }).filter(function (value, index, array) {
                return !isNaN(value);
            });
        }).filter(function (row) {
            return row.length > 0;
        });
        return res;
    };
    return Resource;
})();
/**
 * Created by nick on 10/25/15.
 */
/*
quicksort(A, lo, hi)
if lo < hi
    p = partition(A, lo, hi)
quicksort(A, lo, p - 1)
quicksort(A, p + 1, hi)

partition(A, lo, hi)
pivot = A[hi]
i = lo //place for swapping
for j = lo to hi - 1
if A[j] <= pivot
    swap A[i] with A[j]
    i = i + 1
swap A[i] with A[hi]
    return i
*/
var QuickSortLomuto = (function () {
    function QuickSortLomuto() {
    }
    QuickSortLomuto.prototype.sort = function (source, getPivot) {
        if (source.length < 2)
            return;
        this.quicksort(source, 0, source.length - 1, getPivot);
    };
    QuickSortLomuto.prototype.quicksort = function (source, left, right, getPivot) {
        if (left < right) {
            var p = this.partition(source, left, right, getPivot);
            this.quicksort(source, left, p - 1, getPivot);
            this.quicksort(source, p + 1, right, getPivot);
        }
    };
    QuickSortLomuto.prototype.partition = function (source, left, right, getPivot) {
        var i;
        var j;
        var index = getPivot(left, right, source);
        var pivot = source[index];
        this.swap(source, index, right);
        index = right;
        i = left;
        for (j = i; j < right; j++) {
            if (source[j] <= pivot) {
                this.swap(source, i, j);
                i++;
            }
        }
        this.swap(source, i, index);
        index = i;
        return index;
    };
    QuickSortLomuto.prototype.swap = function (source, a, b) {
        var tmp;
        if (a == b)
            return;
        tmp = source[a];
        source[a] = source[b];
        source[b] = tmp;
    };
    QuickSortLomuto.getPivotMedian = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        var length = max - min + 1;
        var index = min + ((length % 2 == 0) ? length / 2 - 1 : Math.floor(length / 2));
        if (sources[index] > sources[min]) {
            if (sources[index] < sources[max])
                return index;
            else
                return (sources[min] < sources[max]) ? max : min;
        }
        else {
            if (sources[min] < sources[max])
                return min;
            else
                return (sources[index] > sources[max]) ? index : max;
        }
    };
    QuickSortLomuto.getPivotFirst = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return min;
    };
    QuickSortLomuto.getPivotLast = function (min, max, sources) {
        if (min >= max)
            throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return max;
    };
    return QuickSortLomuto;
})();
/**
 * Created by nick on 11/9/15.
 */
var Edge = (function () {
    function Edge(vertexA, vertexB) {
        this.vertexA = vertexA;
        this.vertexB = vertexB;
    }
    return Edge;
})();
/**
 * Created by nick on 11/9/15.
 */
///<reference path="Edge.ts"/>
var Vertex = (function () {
    function Vertex() {
        this.edges = {};
    }
    return Vertex;
})();
/**
 * Created by nick on 11/9/15.
 */
///<reference path="Edge.ts"/>
///<reference path="Vertex.ts"/>
var NGraph = (function () {
    function NGraph() {
        this.vertices = [];
        this.edges = [];
        this.length = 0;
    }
    NGraph.prototype.addVertex = function (id) {
        var vertex = new Vertex();
        vertex.id = id;
        this.vertices[id] = vertex;
    };
    NGraph.prototype.addEdge = function (vertexA, vertexB) {
        if (this.vertices[vertexA].edges[vertexB])
            return;
        var edge = new Edge(vertexA, vertexB);
        this.vertices[vertexA].edges[vertexB] = edge;
        this.vertices[vertexB].edges[vertexA] = edge;
        this.edges.push(edge);
        this.length++;
    };
    NGraph.prototype.removeRandomEdge = function () {
        var eid = Math.round(Math.random() * (this.edges.length - 1));
        var edge = this.edges[eid];
        delete this.vertices[edge.vertexA].edges[edge.vertexB];
        delete this.vertices[edge.vertexB].edges[edge.vertexA];
        this.edges.splice(eid, 1);
        for (var i in this.vertices[edge.vertexB].edges) {
            this.vertices[edge.vertexB].edges[i];
        }
    };
    NGraph.prototype.updateVertex = function (form, to) {
    };
    NGraph.prototype.isJoined = function () {
        for (var i = 0; i < this.vertices.length; i++) {
        }
    };
    NGraph.prototype.findMinCut = function () {
        var res = Number.MAX_VALUE;
        var graph;
        graph = this.clone();
        for (var i = 0; i < this.length - 2; i++) {
            graph.removeRandomEdge();
        }
        console.log(this.vertices);
        console.log(this.edges);
        console.log('===================================');
        console.log(graph.vertices);
        console.log(graph.edges);
        return res;
    };
    NGraph.prototype.clone = function () {
        return NGraph.create(this.source);
    };
    NGraph.create = function (source) {
        var graph = new NGraph();
        source.forEach(function (value, index, array) {
            //console.log(value)
            graph.addVertex(value[0].toString());
        });
        source.forEach(function (value, index, array) {
            for (var i = 1; i < value.length; i++) {
                graph.addEdge(value[0].toString(), value[i].toString());
            }
        });
        graph.source = source;
        return graph;
    };
    return NGraph;
})();
///<reference path="week1/Inversions.ts"/>
///<reference path="week2/QuickSort.ts"/>
///<reference path="util/Resource.ts"/>
///<reference path="week2/QuickSortLomuto.ts"/>
///<reference path="week3/NGraph.ts"/>
var App = (function () {
    function App() {
        //var ex1:Inversions = new Inversions();
        //ex1.run();
        //this.week2();
        this.week3();
    }
    App.prototype.week3 = function () {
        var src = Resource.loadGraph('resources/kargerMinCut.txt');
        //console.log(src);
        var testSource = [[1, 2, 3], [2, 1, 3, 4], [3, 1, 2, 4], [4, 2, 3]];
        var graph = NGraph.create(testSource);
        graph.findMinCut();
        //var graph:NGraph = NGraph.create(src);
        //console.log(graph);
    };
    App.prototype.week2 = function () {
        var src = Resource.loadNumbers('resources/IntegerArray.txt');
        console.log('length is ' + src.length);
        console.log('done.');
        var sort = new QuickSort();
        var comparisons = 0;
        sort.sort(this.getTestArr(), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max, sources);
        });
        console.log('QuickSort with the first pivot: ' + comparisons);
        comparisons = 0;
        sort.sort(this.getTestArr(), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max, sources);
        });
        console.log('QuickSort with the last pivot: ' + comparisons);
        comparisons = 0;
        sort.sort(this.getTestArr(), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        console.log('QuickSort with a median pivot: ' + comparisons);
    };
    App.prototype.getTestArr = function () {
        return Resource.loadNumbers('resources/QuickSort.txt');
        return Resource.loadNumbers('resources/IntegerArray.txt');
        var testArr = [];
        for (var i = 1; i <= 1000; i++) {
            testArr.push(i);
        }
        return testArr;
    };
    return App;
})();
new App();
