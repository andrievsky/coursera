/**
 * Created by nick on 10/24/15.
 */

///<reference path="../../src/week2/QuickSort.ts"/>
///<reference path="../../typings/jasmine/jasmine.d.ts"/>
///<reference path="../../src/util/Resource.ts"/>


var fs = require('fs');

var app = fs.readFileSync('build/app.js','utf-8') // depends on the file encoding
eval(app);

describe("Week 2", () => {
    var sort:QuickSort = new QuickSort();
    var data = [
        {source: [1, 3, 5, 2, 4, 6], result: [1,2,3,4,5,6]}
        ];

    it("Task 1, static arrays", function () {
        data.forEach(function (item, index, array) {
            var clone:number[] = item.source.concat();
            sort.sort(clone, getPivotFirst);
            expect(clone).toEqual(item.result);
        })
    });

    it("Task1, random arrays", function () {
        for(var reps:number = 0; reps < 10; reps++){

            var source:number[] = getRandonArray();
            var result:number[] = source.concat();
            sort.sort(source, getPivotFirst);
            result.sort((a:number, b:number):number => {return a - b;});
            expect(source).toEqual(result);
        }

    });

    it("Task 1, 10", function () {
        var comparisons:number = 0;
        sort.sort([3, 9, 8, 4, 6, 10, 2, 5, 7, 1], (min:number, max:number):number => {
            if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(25);
    });

    it("Task 1, 100", function () {
        var comparisons:number = 0;
        sort.sort(Resource.loadNumbers('resources/w2-100.txt'), (min:number, max:number):number => {
            if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(615);
    });

    it("Task 1, 1000", function () {
        var comparisons:number = 0;
        sort.sort(Resource.loadNumbers('resources/w2-1000.txt'), (min:number, max:number):number => {
            if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            return getPivotFirst(min, max);
        });
        expect(comparisons).toEqual(10297);
    });

    it("Task 2, static arrays", function () {
        sort.debug = (... args:any[]) => {
            console.log('debug ['+args[0] + ']  '+args[1] + ' ' + args[2] +' p: '+args[3]+ ' index: '+args[4] + ' i: '+args[5] + ' j: '+args[6]);
        }
        data.forEach((item:any, index:number, array:any[]):void => {
            var clone:number[] = item.source.concat();
            sort.sort(clone, getPivotLast);
            expect(clone).toEqual(item.result);
        })
    });

    it("Task 2, 10", function () {
        var comparisons:number = 0;
        sort.debug = null;
        sort.sort([3, 9, 8, 4, 6, 10, 2, 5, 7, 1], (min:number, max:number):number => {
            if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
            comparisons += max - min;
            //console.log(min +' -> '+max)
            //console.log(comparisons)
            return getPivotLast(min, max);
        });
        expect(comparisons).toEqual(29);
    });


});

var getPivotFirst = (min:number, max:number):number => {
    return min;
};

var getPivotLast = (min:number, max:number):number => {
    console.log(min +' -> '+max);
    return max;
};

var getRandonArray = ():number[] => {
    var length:number = Math.floor(Math.random()*1000);
    var res:number[] = [];
    for(var i:number = 0; i < length; i++){
        res.push(Math.floor(Math.random()*1000));
    }

    return res;
}