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
    public int playerWait = 300;
    public int hostWait = 500;

    //keyboard control
    public void keyPress(KeyEvent e) {
        switch (e.getKeyCode()) {
            case KeyEvent.VK_ENTER:
                newGame();
                break;
            case KeyEvent.VK_UP:
                accelerateHost();
                break;
            case KeyEvent.VK_DOWN:
                decelerateHost();
                break;
            case KeyEvent.VK_LEFT:
                deceleratePlayer();
                break;
            case KeyEvent.VK_RIGHT:
                acceleratePlayer();
        }
    }

    public void accelerateHost() {
        if (hostWait - 10 > playerWait) {
            hostWait -= 10;
            host.setReact(hostWait);
        }
    }

    public void decelerateHost() {
        if (hostWait + 10 < 500) {
            hostWait += 10;
            host.setReact(hostWait);
        }
    }

    public void deceleratePlayer() {
        if (playerWait + 10 < hostWait) {
            playerWait += 10;
        }
        player.setReact(playerWait);
    }

    public void acceleratePlayer() {
        if (playerWait > 10) {
            playerWait -= 10;
            player.setReact(playerWait);
        }
    }

    //@WebMethod(operationName = "new_game")
    public void newGame() {
        host = new GameHost(hostWait);
        player = new Player(host, playerWait);
        host.setPlayer(player);
        host.start();
    }

    public GameHost getHost() {
        return host;
    }
}
