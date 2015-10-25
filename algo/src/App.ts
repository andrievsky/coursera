///<reference path="week1/Inversions.ts"/>
///<reference path="week2/QuickSort.ts"/>
///<reference path="util/Resource.ts"/>
///<reference path="week2/QuickSortLomuto.ts"/>




class App{
    constructor(){
        //var ex1:Inversions = new Inversions();
        //ex1.run();
        this.week2();
    }

    week2():void{
        var src:number[] = Resource.loadNumbers('resources/IntegerArray.txt');
        console.log('length is '+src.length);



        console.log('done.');

        var sort:QuickSort = new QuickSort();
        var comparisons:number = 0;

        sort.sort(this.getTestArr(), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max, sources);
        });
        console.log('QuickSort with the first pivot: '+comparisons);
        comparisons = 0;
        sort.sort(this.getTestArr(), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max, sources);
        });
        console.log('QuickSort with the last pivot: '+comparisons);
        comparisons = 0;
        sort.sort(this.getTestArr(), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        console.log('QuickSort with a median pivot: '+comparisons);
    }

    getTestArr():number[]{
        return Resource.loadNumbers('resources/QuickSort.txt');
        return Resource.loadNumbers('resources/IntegerArray.txt');
        var testArr:number[] = [];
        for(var i:number = 1; i <= 1000; i++){
            testArr.push(i);
        }
        return testArr;
    }

}

new App();
