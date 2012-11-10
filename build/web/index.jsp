<%-- 
    Document   : index
    Created on : Mar 25, 2012, 12:50:46 AM
    Author     : rmy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
        <script type='text/javascript' src="default.js"></script>
        <title>Cloud Tetris</title>
    </head>
    <body>
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
