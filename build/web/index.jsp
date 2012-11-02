<%-- 
    Document   : index
    Created on : Mar 25, 2012, 12:50:46 AM
    Author     : rmy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type='text/javascript'>
            
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
            
            window.setInterval("requestServlet('TetrisServlet','action=paint')",300);
            
            
            function requestServlet(servletName, servletArguments){
                var servlet = servletName;                //the name (URI) of your servlet
                var arg = servletArguments                //any attributes you want to send
                var req = servlet + "?" + arg + "&rand=" + Math.floor(Math.random*100);            //compiling the request
                addrequest(req);                         //calls the addrequest function
                request.onreadystatechange = function(){  //this is used to listen for changes in the request's status
                    if (request.readyState==4 && request.status==200){
                        
                        if(arg=="action=paint"){
                            
                            data= eval('(' + request.responseText + ')');
                        
                            boardbuff=data.board;
                            piecebuff=data.piece;
                            score=data.score;
                            color=data.color;
                            paint();
                        }
                    }
                }
            }

            function addrequest(req) {
                request = new XMLHttpRequest();
                request.open("GET", req, true);       //prepare the request
                request.send(null);                       //send it
                return request;                           //return the request
            }

            function init(){

                window.onkeypress=function(){

                    //alert(event.keyCode.toString());
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
                //boardbuff=new Array();

                piece=new Array();
                //canvas=new Array();
                //canvas[0] = document.getElementById('canvas');
                //canvas[1]=document.getElementById('canvas2');
                //canvasptr=0;
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
                
                //requestServlet("TetrisServlet","action=start");
                requestServlet('TetrisServlet','action=paint');
                
                //setInterval(paint, 50);
                
                window.resizeTo(twidth+3,theight+110)
                
            }
            
            function paint(){
                var i,j;

                for(i=0;i<4;i++){

                    var x0=piece[i][0];
                    var y0=piece[i][1];
                    ctx.clearRect(x0 * (xdim + gap) + gap, y0 * (ydim + gap) + gap, xdim, ydim);
                }

                for(i=0;i<4;i++){
                    var x=piecebuff[i][0];
                    var y=piecebuff[i][1];
                    ctx.fillStyle=color[piecebuff[4][0]];
                    ctx.fillRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);
                    //ctx.fillStyle="#000";
                    //ctx.strokeRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);

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
                            //ctx.fillStyle="#000";
                            //ctx.strokeRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
                        }
                    }
                }
                
                

                //ctx.clearRect(twidth - 80, gap + 10, 80, 10);
                //ctx.fillText("SCORE: "+score, twidth - 80, gap + 10);
                document.getElementById("text").value=score.toString();
                
                //canvas[canvasptr].style.visibility="visible";
                //canvas[1-canvasptr].style.visibility="hidden";
                //canvasptr=1-canvasptr;
                
                
                //t=setTimeOut("paint()",30);
                
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

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cloud Tetris</title>



    </head>
    <body onload="init();">
    <canvas id="canvas" width="202" height="382" style="border: 1px solid black; position:absolute; top:0;left:0;"></canvas>
    <!--<canvas id="canvas" width="202" height="382" style="border: 1px solid black; position:absolute; top:0;left:0;visibility: hidden;"></canvas>
    //<canvas id="canvas2" width="202" height="382" style="border: 1px solid black; position:absolute; top:0;left:0; visibility: hidden;"></canvas>-->
    <p>
        <input type="text" id="text" value="0" style="position:fixed; top:390px; left: 10px; width: 30px"/>
        <input type="button" value="Restart Game" onclick="new_game()" style="position:fixed; top:390px; left:55px;" />
        <!--
        <input type="button" value="h+" onclick="requestServlet('TetrisServlet','action=speed&object=host&dir=plus')" style="position:fixed; top:390px; left:0px;" />
        <input type="button" value="h-" onclick="requestServlet('TetrisServlet','action=speed&object=host&dir=minus')" style="position:fixed; top:390px; left:30px;" />

        <input type="button" value="p+" onclick="requestServlet('TetrisServlet','action=speed&object=player&dir=plus')" style="position:fixed; top:390px; left:140px;" />
        <input type="button" value="p-" onclick="requestServlet('TetrisServlet','action=speed&object=player&dir=minus')" style="position:fixed; top:390px; left:170px;" />
        -->
    </p>

</body>
</html>
