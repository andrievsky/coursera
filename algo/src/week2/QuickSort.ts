/**
 * Created by nick on 10/23/15.
 */

class QuickSort{
    public sort(source:number[], getPivot:Function):void {
        if(source.length < 2) return;
        this.partision(source, 0, source.length - 1, getPivot);
    }
    //[1, 3, 5, 2, 4, 6]
    private pivot:number;
    private i:number;
    private j:number;
    private partision(source:number[], left:number, right:number, getPivot:Function):void{

        if (left >= right) return;
        var index:number = getPivot(left, right);
        this.pivot = source[index];

        //this.swap(source, index, left);
        this.i = left + 1;
        for(this.j = this.i; this.j <= right; this.j++){
            if(source[this.j] < this.pivot) {
                this.swap(source, this.i, this.j);
                this.i++;
            }
        }
        if(this.debug) this.debug(source, left, right, this.pivot, index, this.i, this.j);
        this.swap(source, index, this.i - 1);
        index = this.i - 1;

        this.partision(source, left, index - 1, getPivot);
        this.partision(source, index + 1, right, getPivot);
    }

    public debug:Function;
    private tmp:number;
    private swap(source:number[], a:number, b:number):void {
        this.tmp = source[a];
        source[a] = source[b];
        source[b] = this.tmp;
    }
}
