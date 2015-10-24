///<reference path="week1/Inversions.ts"/>
///<reference path="week2/QuickSort.ts"/>
///<reference path="util/Resource.ts"/>



class App{
    constructor(){
        //var ex1:Inversions = new Inversions();
        //ex1.run();
        this.week2();
    }

    week2():void{
        var sort:QuickSort = new QuickSort();
        var comparisons:number = 0;
        sort.sort(Resource.loadNumbers('resources/QuickSort.txt'), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotFirst(min, max, sources);
        });
        console.log('QuickSort with the first pivot: '+comparisons);
        /*comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/QuickSort.txt'), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotLast(min, max, sources);
        });
        console.log('QuickSort with the last pivot: '+comparisons);
        comparisons = 0;
        sort.sort(Resource.loadNumbers('resources/QuickSort.txt'), (min:number, max:number, sources:number[]):number => {
            comparisons += max - min;
            return QuickSort.getPivotMedian(min, max, sources);
        });
        console.log('QuickSort with a median pivot: '+comparisons);*/
    }

}

new App();
