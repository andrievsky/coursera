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

class QuickSortLomuto{
    public sort(source:number[], getPivot:Function):void {
        if(source.length < 2) return;
        this.quicksort(source, 0, source.length - 1, getPivot);
    }

    private quicksort(source:number[], left:number, right:number, getPivot:Function):void{
        if (left < right) {
            var p:number = this.partition(source, left, right, getPivot);
            this.quicksort(source, left, p - 1, getPivot);
            this.quicksort(source, p + 1, right,getPivot);
        }
    }

    private partition(source:number[], left:number, right:number, getPivot:Function):number{

        var i:number;
        var j:number;
        var index:number = getPivot(left, right, source);
        var pivot:number = source[index];

        this.swap(source, index, right);
        index = right;
        i = left;
        for(j = i; j < right; j++){
            if(source[j] <= pivot) {
                this.swap(source, i, j);
                i++;
            }
        }

        this.swap(source, i, index);
        index = i;

        return index;
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
