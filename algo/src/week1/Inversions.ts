/**
 * Created by nick on 10/21/15.
 */

///<reference path="MergeSort.ts"/>
///<reference path="../../typings/node/node.d.ts"/>

var fs:any = require('fs');

class Inversions{
    constructor(){}

    iterations:number;

    run():void{
        var input:string[] = fs.readFileSync('resources/IntegerArray.txt').toString().split("\n");
        var data:number[] = input.map( (value:string):number => {
            return parseInt(value);
        });
        this.runFromSource(data);
    }

    runFromSource(input:number[]):number {
        input.forEach((value:number, index:number, src:number[]) => {
           if (typeof(value) != 'number') console.log(value +" is NAN !!!");
        });
        this.iterations = 0;
        this.calculate(input);
        console.log('\nElements: '+ input.length +' Inversions: '+this.iterations);
        return this.iterations;
    }

    calculate(source:Array<number>):void{
        var mergeSort:MergeSort = new MergeSort();
        var sorted:number[] = source.concat();
        mergeSort.sort(sorted);
        var connections:number[] = [];
        var i, j:number;

        for(i = 0; i < sorted.length; i++){
            connections[i] = source.indexOf(sorted[i]);
        }

        for(i = 0; i < connections.length; i++){
            for(j = 0; j < i; j++){
                if(connections[i] < connections[j]) this.iterations++;
            }
        }
    }
}

