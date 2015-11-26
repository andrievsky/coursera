/**
 * Created by nick on 10/24/15.
 */

class Resource{
    static loadNumbers(path:string):number[]{
        var res:number[] = fs.readFileSync(path).toString().split("\n").map( (value:string):number => {
            return parseInt(value);
        }).filter((value:number, index:number, array:number[]):boolean =>{
            return !isNaN(value);
        });
        return res;
    }

    static loadGraph(path:string):Array<Array<number>>{
        var res:Array<number[]> = fs.readFileSync(path).toString().split('\n')
            .map((row:string):number[] => {
                return row.split('\t')
                    .map((value:string, index: number, array: string[]):number => {
                        return parseInt(value);
                    }).filter((value:number, index:number, array:number[]):boolean =>{
                        return !isNaN(value);
                    });
            }).filter((row:number[]):boolean => {
                return row.length > 0;
            });
        return res;
    }
}
