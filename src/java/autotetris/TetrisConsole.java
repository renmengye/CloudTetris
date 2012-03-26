package autotetris;

import autotetris.ai.Player;
import autotetris.elements.GameHost;
import java.awt.event.KeyEvent;

/**
 *
 * @author rmy
 */
public class TetrisConsole implements ATCommon {

    private Player player;              //computer AI agent
    private GameHost host;
    public int player_react = 200;
    public int host_react = 300;

    //keyboard control
    public void keyPress(KeyEvent e) {
        switch (e.getKeyCode()) {
            case KeyEvent.VK_ENTER:
                new_game();
                break;
            case KeyEvent.VK_UP:
                host_acc();
                break;
            case KeyEvent.VK_DOWN:
                host_dcc();
                break;
            case KeyEvent.VK_LEFT:
                player_dcc();
                break;
            case KeyEvent.VK_RIGHT:
                player_acc();
        }
    }

    public void host_acc() {
        if (host_react - 10 > player_react) {
            host_react -= 10;
            host.setReact(host_react);
        }
    }

    public void host_dcc() {
        if (host_react + 10 < 500) {
            host_react += 10;
            host.setReact(host_react);
        }
    }

    public void player_dcc() {
        if (player_react + 10 < host_react) {
            player_react += 10;
        }
        player.setReact(player_react);
    }

    public void player_acc() {
        if (player_react > 10) {
            player_react -= 10;
            player.setReact(player_react);
        }
    }

    //@WebMethod(operationName = "new_game")
    public void new_game() {
        host = new GameHost(host_react);
        player = new Player(host, player_react);
        host.setPlayer(player);
        host.start();
    }

    public GameHost host() {
        return host;
    }
}
