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
}
