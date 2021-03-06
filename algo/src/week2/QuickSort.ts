/**
 * Created by nick on 10/23/15.
 */

class QuickSort{
    public sort(source:number[], getPivot:Function):void {
        if(source.length < 2) return;
        this.partision(source, 0, source.length - 1, getPivot);
    }

    private partision(source:number[], left:number, right:number, getPivot:Function):boolean{
        if (left >= right) return true;

        var i:number;
        var j:number;
        var index:number = getPivot(left, right, source);
        var pivot:number = source[index];

        this.swap(source, index, left);
        index = left;
        i = left + 1;
        for(j = i; j <= right; j++){
            if(source[j] < pivot) {
                this.swap(source, j, i);
                i++;
            }
        }

        this.swap(source, index, i - 1);
        index = i - 1;

        if(left < index - 1) this.partision(source, left, index - 1, getPivot);
        if(index + 1 < right) this.partision(source, index + 1, right, getPivot);
    }

    public debug:Function;
    private swap(source:number[], a:number, b:number):void {
        var tmp:number;
        if(a == b) return;
        tmp = source[a];
        source[a] = source[b];
        source[b] = tmp;
    }

    static getPivotMedian(min:number, max:number, sources:number[]):number{
        if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        var length:number = max - min + 1;
        var index:number = min + ((length % 2 == 0) ? length / 2 - 1: Math.floor(length / 2));
        if(sources[index] > sources[min]) {
            if(sources[index] < sources[max]) return index;
            else return (sources[min] < sources[max]) ? max : min;
        } else {
            if(sources[min] < sources[max]) return min;
            else return (sources[index] > sources[max]) ?  index: max;
        }
    }

    static getPivotFirst(min:number, max:number, sources?:number[]):number{
        if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return min;
    }

    static getPivotLast(min:number, max:number, sources?:number[]):number {
        if (min >= max) throw Error('getPivotNaiveIterator min: ' + min + ' max:' + max);
        return max;
    }
}
