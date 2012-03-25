package autotetris;

import autotetris.ai.Player;
import autotetris.elements.GameHost;
import java.awt.event.KeyEvent;
import javax.jws.WebMethod;

/**
 *
 * @author rmy
 */
public class TetrisConsole implements ATCommon {

    private Player player;              //computer AI agent
    private GameHost host;
    private int player_react = 60;
    private int host_react = 200;


    //keyboard control
    public void keyPress(KeyEvent e) {
        switch (e.getKeyCode()) {
            case KeyEvent.VK_ENTER:
                new_game();
                break;
            case KeyEvent.VK_UP:
                if (host_react - 10 > player_react) {
                    host_react -= 10;
                    host.setReact(host_react);
                }
                break;
            case KeyEvent.VK_DOWN:
                if (host_react + 10 < 500) {
                    host_react += 10;
                    host.setReact(host_react);
                }
                break;
            case KeyEvent.VK_LEFT:
                if (player_react + 5 < host_react) {
                    player_react += 5;
                }
                player.setReact(player_react);
                break;
            case KeyEvent.VK_RIGHT:
                if (player_react > 5) {
                    player_react -= 5;
                    player.setReact(player_react);
                }
        }
    }

    
    //@WebMethod(operationName = "new_game")
    public void new_game() {
        host = new GameHost(host_react);
        player = new Player(host, player_react);
        host.setPlayer(player);
        host.start();
    }
    
    public GameHost host(){
        return host;
    }
}
