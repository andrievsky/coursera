/**
 * Created by nick on 11/9/15.
 */
    ///<reference path="Edge.ts"/>
    ///<reference path="Vertex.ts"/>


class NGraph {

    public vertices:Vertex[] = [];
    public edges:Edge[] = [];
    public length:number = 0;
    public source:Array<number[]>



    public addVertex(id:string):void{
        var vertex = new Vertex();
        vertex.id = id;
        this.vertices[id] = vertex;
    }

    public addEdge(vertexA:string, vertexB:string):void{
        if(this.vertices[vertexA].edges[vertexB]) return;
        var edge = new Edge(vertexA, vertexB);
        this.vertices[vertexA].edges[vertexB] = edge;
        this.vertices[vertexB].edges[vertexA] = edge;
        this.edges.push(edge);
        this.length++;
    }

    public removeRandomEdge():void{
        var eid:number = Math.round(Math.random()*(this.edges.length - 1));
        var edge:Edge = this.edges[eid];
        delete this.vertices[edge.vertexA].edges[edge.vertexB];
        delete this.vertices[edge.vertexB].edges[edge.vertexA];
        this.edges.splice(eid, 1);
        for (var i in this.vertices[edge.vertexB].edges){
            this.vertices[edge.vertexB].edges[i]
        }

    }

    private updateVertex(form:string, to:string):void{

    }

    public isJoined():void{
        for(var i:number = 0; i < this.vertices.length; i++){

        }
    }

    public findMinCut():number{
        var res:number = Number.MAX_VALUE;
        var graph:NGraph;
        graph = this.clone();
        for (var i:number = 0; i < this.length - 2; i++){
            graph.removeRandomEdge();
        }
        console.log(this.vertices)
        console.log(this.edges)
        console.log('===================================')
        console.log(graph.vertices)
        console.log(graph.edges)
        return res;
    }

    public clone():NGraph{
        return NGraph.create(this.source);
    }

    static create(source:Array<number[]>):NGraph{
        var graph:NGraph = new NGraph();
        source.forEach((value: number[], index: number, array: Array<number[]>):void =>{
            //console.log(value)
            graph.addVertex(value[0].toString());
        });
        source.forEach((value: number[], index: number, array: Array<number[]>):void =>{
            for(var i:number = 1; i < value.length; i++){
                graph.addEdge(value[0].toString(), value[i].toString());
            }
        });
        graph.source = source;
        return graph;
    }

}