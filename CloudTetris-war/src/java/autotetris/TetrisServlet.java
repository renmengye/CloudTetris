package autotetris;

import autotetris.elements.Board;
import autotetris.elements.Piece;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author rmy
 */
@WebServlet(name = "TetrisServlet", urlPatterns = {"/TetrisServlet"})
public class TetrisServlet extends HttpServlet implements ATCommon {

    TetrisConsole console = null;

    @Override
    public void init() {
        console = new TetrisConsole();
        console.new_game();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        PrintWriter out = response.getWriter();

        if (action.equals("start")) {
            console.new_game();
        } else if (action.equals("score")) {
            //response.setContentType("text/html;charset=UTF-8");
            //try {

            //out.println("Hello World!");
            out.println(console.host().getScore());

            //} finally {
            out.flush();
            out.close();
            //}
        } else if (action.equals("paint")) {
            try {
                JSONObject data = new JSONObject();

                JSONArray board = new JSONArray();
                JSONArray piece = new JSONArray();


                Board b = console.host().getBoard();
                
                Piece p = console.host().getPiece();

                for (int j = 0; j < YNUM; j++) {
                    JSONArray line = new JSONArray();


                    for (int i = 0; i < XNUM; i++) {

                        line.put(b.getGrid(j, i));
                    }

                    board.put(line);
                }

                data.put("board", board);

                for (int i = 0; i <= 3; i++) {
                    JSONArray grid=new JSONArray();
                    int x = p.getX() + p.getContour(i, CONTOUR_DX);
                    int y = p.getY() + p.getContour(i, CONTOUR_DY);
                    grid.put(x);
                    grid.put(y);
                    piece.put(grid);
                }
                
                data.put("piece",piece);
                
                data.put("score",console.host().getScore());

                out.print(data.toString());
                out.flush();
                out.close();
            } catch (JSONException ex) {
                Logger.getLogger(TetrisServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
}
