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
            var piece;
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
            
            self.setInterval("requestServlet('TetrisServlet','action=paint')",40);
            
            
            function requestServlet(servletName, servletArguments){
                var servlet = servletName;                //the name (URI) of your servlet
                var arg = servletArguments                //any attributes you want to send
                var req = servlet + "?" + arg;            //compiling the request
                addrequest(req);                         //calls the addrequest function
                request.onreadystatechange = function(){  //this is used to listen for changes in the request's status
                    if (request.readyState==4 && request.status==200){
                        //document.getElementById('txt').value=request.responseText; 
                        
                        
                        if(arg=="action=paint"){
                            
                            data= eval('(' + request.responseText + ')');
                        
                            board=data.board;
                            piece=data.piece;
                            score=data.score;
                            color=data.color;
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
                
                canvas=new Array();
                
                canvas[0] = document.getElementById('canvas');
                
                canvas[1]=document.getElementById('canvas2');
                
                canvasptr=0;
                
                
                twidth = 202;
                theight = 382;
                gap = 2;
                xnum = 10;
                ynum = 19;
            
                xdim = twidth / xnum - gap;
                ydim = theight / ynum - 2;
                
                
                //requestServlet("TetrisServlet","action=start");
                requestServlet('TetrisServlet','action=paint');
                
                setInterval(paint, 40);
                
                window.resizeTo(twidth+3,theight+110)
                
            }
            
            function paint(){
                var i,j;
                
                
                ctx = canvas[canvasptr].getContext("2d");
                
                ctx.clearRect(0,0,twidth,theight); 
                
                //ctx.fillText(color[0], twidth - 150, gap + 10);
                
                for(j=0;j<ynum;j++){
                    for(i=0;i<xnum;i++){
                        
                        if(board[j][i]>=0){
                            ctx.fillStyle=color[board[j][i]];
                            
                            //ctx.fillStyle="#0000ff";
                            ctx.fillRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
                            ctx.fillStyle="#000";
                            ctx.strokeRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
                        }
                    }
                }
                
                for(i=0;i<4;i++){
                    var x=piece[i][0];
                    var y=piece[i][1];
                    
                    
                    ctx.fillStyle=color[piece[4][0]];
                    ctx.fillRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);
                    ctx.fillStyle="#000";
                    ctx.strokeRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);
                }
                
                ctx.fillText("SCORE: "+score, twidth - 80, gap + 10);
                
                canvas[canvasptr].style.visibility="visible";
                canvas[1-canvasptr].style.visibility="hidden";
                canvasptr=1-canvasptr;
                
                
                //t=setTimeOut("paint()",30);
                
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cloud Tetris</title>



    </head>
    <body onload="init();">
        <canvas id="canvas" width="202" height="382" style="border: 1px solid black; position:absolute; top:0;left:0;visibility: hidden;"></canvas>
        <canvas id="canvas2" width="202" height="382" style="border: 1px solid black; position:absolute; top:0;left:0; visibility: hidden;"></canvas>
        <p>
            <input type="button" value="h+" onclick="requestServlet('TetrisServlet','action=speed&object=host&dir=plus')" style="position:fixed; top:390px; left:0px;" />
            <input type="button" value="h-" onclick="requestServlet('TetrisServlet','action=speed&object=host&dir=minus')" style="position:fixed; top:390px; left:30px;" />
            <input type="button" value="Restart Game" onclick="requestServlet('TetrisServlet','action=start')" style="position:fixed; top:390px; left:55px;" />
            <input type="button" value="p+" onclick="requestServlet('TetrisServlet','action=speed&object=player&dir=plus')" style="position:fixed; top:390px; left:140px;" />
            <input type="button" value="p-" onclick="requestServlet('TetrisServlet','action=speed&object=player&dir=minus')" style="position:fixed; top:390px; left:170px;" />
        </p>
        
    </body>
</html>
