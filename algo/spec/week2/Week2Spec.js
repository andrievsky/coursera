/**
 * Created by nick on 10/24/15.
 */
///<reference path="../../src/week2/QuickSort.ts"/>
///<reference path="../../typings/jasmine/jasmine.d.ts"/>
///<reference path="../../src/util/Resource.ts"/>
///<reference path="../../src/week2/QuickSortLomuto.ts"/>
var fs = require('fs');
var app = fs.readFileSync('build/app.js', 'utf-8'); // depends on the file encoding
eval(app);
describe("Week 2", function () {
    var sort = new QuickSort();
    //var sort:QuickSortLomuto = new QuickSortLomuto();
    var data = [
        { source: [1, 3, 5, 2, 4, 6], result: [1, 2, 3, 4, 5, 6] }
    ];
    it("Task 1, static arrays", function () {
        data.forEach(function (item, index, array) {
            var clone = item.source.concat();
            sort.sort(clone, QuickSort.getPivotFirst);
            expect(clone).toEqual(item.result);
        });
    });
    it("Task1, random arrays", function () {
        for (var reps = 0; reps < 10; reps++) {
            var source = getRandonArray(1000);
            var result = source.concat();
            sort.sort(source, QuickSort.getPivotFirst);
            result.sort(function (a, b) { return a - b; });
            expect(source).toEqual(result);
        }
    });
    it("Task 1, 10", function () {
        var comparisons = 0;
        sort.sort([3, 9, 8, 4, 6, 10, 2, 5, 7, 1], function (min, max) {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(25);
    });
    it("Task 1, 100", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-100.txt'), function (min, max) {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(615);
    });
    it("Task 1, 1000", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-1000.txt'), function (min, max) {
            if (min >= max)
                throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(10297);
    });
    it("Task 2, static arrays", function () {
        /*sort.debug = (... args:any[]) => {
            console.log('debug ['+args[0] + ']  '+args[1] + ' ' + args[2] +' p: '+args[3]+ ' index: '+args[4] + ' i: '+args[5] + ' j: '+args[6]);
        }*/
        data.forEach(function (item, index, array) {
            var clone = item.source.concat();
            sort.sort(clone, QuickSort.getPivotLast);
            expect(clone).toEqual(item.result);
        });
    });
    it("Task 2, 10", function () {
        var comparisons = 0;
        sort.sort([3, 9, 8, 4, 6, 10, 2, 5, 7, 1], function (min, max) {
            comparisons += max - min;
            //console.log(min +' -> '+max)
            //console.log(comparisons)
            return QuickSort.getPivotLast(min, max);
        });
        expect(comparisons).toEqual(29);
    });
    it("Task 2, 100", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-100.txt'), function (min, max) {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max);
        });
        expect(comparisons).toEqual(587);
    });
    it("Task 2, 1000", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-1000.txt'), function (min, max) {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max);
        });
        expect(comparisons).toEqual(10184);
    });
    it("Task 3, static arrays", function () {
        data.forEach(function (item, index, array) {
            var clone = item.source.concat();
            sort.sort(clone, QuickSort.getPivotMedian);
            expect(clone).toEqual(item.result);
        });
    });
    it("Task 3, 10", function () {
        var comparisons = 0;
        sort.sort([3, 9, 8, 4, 6, 10, 2, 5, 7, 1], function (min, max, sources) {
            if (min >= max)
                throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        expect(comparisons).toEqual(21);
    });
    it("Task 2, 100", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-100.txt'), function (min, max, sources) {
            if (min >= max)
                throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        expect(comparisons).toEqual(518);
    });
    it("Task 3, 1000", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/w2-1000.txt'), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        expect(comparisons).toEqual(8921);
    });
    it("QuickSort with the first pivot for IntegerArray", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/IntegerArray.txt'), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max, sources);
        });
        expect(comparisons).toEqual(1954287);
    });
    it("QuickSort with the last pivot for IntegerArray", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/IntegerArray.txt'), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max, sources);
        });
        expect(comparisons).toEqual(2047196);
    });
    it("QuickSort with a midian pivot for IntegerArray", function () {
        var comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/IntegerArray.txt'), function (min, max, sources) {
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        expect(comparisons).toEqual(1697653);
    });
});
var getRandonArray = function (length, strict) {
    if (strict === void 0) { strict = false; }
    if (!strict)
        length = Math.floor(Math.random() * length);
    var res = [];
    for (var i = 0; i < length; i++) {
        res.push(Math.floor(Math.random() * length));
    }
    return res;
};
var getRandomRange = function (min, max) {
    return min + Math.round(Math.random() * (max - min));
};
