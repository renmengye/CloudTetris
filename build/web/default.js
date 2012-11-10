/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var request;
            
var data;
var board;
var boardbuff;

var piece;
var piecebuff;

var score;
var color;
            
var canvas;
            
var canvasptr;
            
var ctx;
            
var twidth;
var theight;
var gap;
var xnum;
var ynum;
            
var xdim;
var ydim;
            
var t;
            
self.setInterval(
    function(){
        requestServlet('TetrisServlet','action=paint');
    },300);
            
            
function requestServlet(servletName, servletArguments){
    var servlet = servletName;                //the name (URI) of your servlet
    var arg = servletArguments                //any attributes you want to send
    var req = servlet + "?" + arg + "&rand="+Math.floor(Math.random()*1000000+1);            //compiling the request
    $.getJSON(req, function(data){
        if(arg == "action=paint"){
            boardbuff = data.board;
            piecebuff = data.piece;
            score = data.score;
            color = data.color;
            paint();
        } 
    });
}

$(document).ready(function(){
    window.onkeypress=function(){
        if(event.keyCode==65||event.keyCode==97){
            //alert("a");
            requestServlet('TetrisServlet','action=speed&object=player&dir=minus');
        }else if(event.keyCode==87||event.keyCode==119){
            //alert("w");
            requestServlet('TetrisServlet','action=speed&object=host&dir=plus');
        }else if(event.keyCode==68||event.keyCode==100){
            //alert("d");
            requestServlet('TetrisServlet','action=speed&object=player&dir=plus');
        }else if(event.keyCode==83||event.keyCode==115){
            //alert("s");
            requestServlet('TetrisServlet','action=speed&object=host&dir=minus');
        }else if(event.keyCode==13){
            new_game();
        }
    };

    board=new Array();

    piece=new Array();
    canvas=document.getElementById('canvas');
    ctx = canvas.getContext("2d");
                
    twidth = 202;
    theight = 382;
    gap = 2;
    xnum = 10;
    ynum = 19;
            
    xdim = Math.round(twidth / xnum) - gap;
    ydim = Math.round(theight / ynum) - gap;

    var i,j;
    for(j=0;j<ynum;j++){
        board[j]=new Array();
        for(i=0;i<xnum;i++){
            board[j][i]=-1;
        }
    }

    for(j=0;j<5;j++){
        piece[j]=new Array();
        piece[j][0]=0;
        piece[j][1]=0;
    }
                
    requestServlet('TetrisServlet','action=paint');
                
    window.resizeTo(twidth + 3, theight + 110)
                
});
            
function paint(){
    var i,j;
    
    if(piece){
        for(i=0;i<4;i++){
            var x0=piece[i][0];
            var y0=piece[i][1];
            ctx.clearRect(x0 * (xdim + gap) + gap, y0 * (ydim + gap) + gap, xdim, ydim);
        }
    }

    for(i=0;i<4;i++){
        var x=piecebuff[i][0];
        var y=piecebuff[i][1];
        ctx.fillStyle=color[piecebuff[4][0]];
        ctx.fillRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);
        piece[i][0]=piecebuff[i][0];
        piece[i][1]=piecebuff[i][1];
    }

    for(j=0;j<ynum;j++){
        for(i=0;i<xnum;i++){
                        
            if(boardbuff[j][i]!=board[j][i]){
                board[j][i]=boardbuff[j][i];
                ctx.clearRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
                if(boardbuff[j][i]==-1){
                    ctx.fillStyle="#fff";
                }else{
                    ctx.fillStyle=color[boardbuff[j][i]];
                }
                ctx.fillRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
            }
        }
    }
                
    document.getElementById("text").value=score.toString();
                
}

function new_game(){
    requestServlet('TetrisServlet','action=start');
    ctx.clearRect(0,0,twidth,theight);
    for(j=0;j<ynum;j++){
        board[j]=new Array();
        for(i=0;i<xnum;i++){
            board[j][i]=-1;
        }
    }
                
}

