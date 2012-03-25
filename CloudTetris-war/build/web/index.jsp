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
            
            var canvas;
            var ctx;
            
            var twidth;
            var theight;
            var gap;
            var xnum;
            var ynum;
            
            var xdim;
            var ydim;
            
            var t;
            
            self.setInterval("requestServlet('TetrisServlet','action=paint')",15);
            
            
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
                
                
                canvas = document.getElementById("canvas");
                ctx = canvas.getContext("2d");
                
                twidth = 202;
                theight = 382;
                gap = 2;
                xnum = 10;
                ynum = 19;
            
                xdim = twidth / xnum - gap;
                ydim = theight / ynum - 2;
                
                
                //requestServlet("TetrisServlet","action=start");
                requestServlet('TetrisServlet','action=paint');
                
                setInterval(paint, 15);
                
            }
            
            function paint(){
                var i,j;
                //document.getElementById('txt').value="hoho3";
                ctx.clearRect(0,0,twidth,theight); 
                
                //document.getElementById('txt').value=ynum;
                
                for(j=0;j<ynum;j++){
                    for(i=0;i<xnum;i++){
                        //ctx.setColor(board[j][i].color);
                        
                        if(board[j][i]==1){
                            ctx.fillRect(i * (xdim + gap) + gap, j * (ydim + gap) + gap, xdim, ydim);
                        }
                    }
                }
                
                for(i=0;i<3;i++){
                    var x=piece[i][0];
                    var y=piece[i][1];
                    ctx.fillRect(x * (xdim + gap) + gap, y * (ydim + gap) + gap, xdim, ydim);
                }
                
                ctx.fillText("SCORE: "+score, twidth - 80, gap + 10);
                
                //t=setTimeOut("paint()",30);
                
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cloud Tetris</title>



    </head>
    <body onload="init();">
        <!--<h1>Hello World!</h1>
        <form name="Submit" action="TetrisServlet" method="get">&nbsp;
            <!--<input type="text" id="txt2" />
            <input type="submit" value="start" name="action" />
            <input type="submit" value="paint" name="action" />
        </form>
        <input type="text" id="txt" />
        <input type="button" value="start" onclick="requestServlet('TetrisServlet','action=start')"/>
        <input type="button" value="score" onclick="requestServlet('TetrisServlet','action=score')" />
        <input type="button" value="paint" onclick="requestServlet('TetrisServlet','action=paint')" />
        <input type="button" value="refresh" onclick="paint()" />-->
        <canvas id="canvas" width="202" height="382" style="border: 1px solid black;"></canvas>
        <p><input type="button" value="re-start" onclick="requestServlet('TetrisServlet','action=start')"/></p>
        
    </body>
</html>
