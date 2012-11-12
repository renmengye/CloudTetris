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
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author rmy
 */
@WebServlet(name = "TetrisServlet", urlPatterns = {"/TetrisServlet"})
public class TetrisServlet extends HttpServlet implements ATCommon {

    //TetrisConsole console = null;
    @Override
    public void init() {
        //console = new TetrisConsole();
        //console.new_game();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession(true);

        TetrisConsole console;

        if (session.getAttribute("console") == null) {
            console = new TetrisConsole();
            console.newGame();
            session.setAttribute("console", console);
        } else {
            console = (TetrisConsole) session.getAttribute("console");
        }

        PrintWriter out = response.getWriter();

        if (action.equals("start")) {
            console.newGame();
        } else if (action.equals("score")) {
            try {
                out.println(console.getHost().getScore());
            } finally {
                out.flush();
                out.close();
            }
        } else if (action.equals("paint")) {
            try {
                JSONObject data = new JSONObject();

                JSONArray board = new JSONArray();
                JSONArray piece = new JSONArray();
                JSONArray color = new JSONArray();

                Board b = console.getHost().getBoard();
                Piece p = console.getHost().getPiece();

                for (int j = 0; j < YNUM; j++) {
                    JSONArray bline = new JSONArray();
                    for (int i = 0; i < XNUM; i++) {
                        bline.put(b.getGrid(j, i));
                    }
                    board.put(bline);
                }

                data.put("board", board);

                for (int i = 0; i <= 3; i++) {
                    JSONArray grid = new JSONArray();
                    int x = p.getX() + p.getContour(i, CONTOUR_DX);
                    int y = p.getY() + p.getContour(i, CONTOUR_DY);
                    grid.put(x);
                    grid.put(y);
                    piece.put(grid);
                }

                JSONArray grid = new JSONArray();
                grid.put(p.getType().value());
                grid.put(0);
                piece.put(grid);
                data.put("piece", piece);
                data.put("score", console.getHost().getScore());

                for (int i = 0; i < 7; i++) {
                    color.put(PIECE_WEB_COLOR[i]);
                }

                data.put("color", color);

                out.print(data.toString());
                out.flush();
                out.close();
            } catch (JSONException ex) {
                Logger.getLogger(TetrisServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("speed")) {
            String object = request.getParameter("object");
            String dir = request.getParameter("dir");
            if (object.equals("host")) {

                if (dir.equals("plus")) {
                    console.accelerateHost();

                    out.print(console.hostWait);

                } else if (dir.equals("minus")) {
                    console.decelerateHost();
                    out.print(console.hostWait);
                }

            } else if (object.equals("player")) {

                if (dir.equals("plus")) {
                    console.acceleratePlayer();
                    out.print(console.playerWait);

                } else if (dir.equals("minus")) {
                    console.deceleratePlayer();
                    out.print(console.playerWait);
                }

            }
            out.flush();
            out.close();
        }

    }
}
