package autotetris.elements;

import java.awt.Color;

/**
 *
 * @author renmengy
 */
public class Grid {

    public byte value;
    public Color color;
    public int hexcolor;

    public Grid(byte value, Color color, int hexcolor){
        this.value=value;
        this.color=color;
        this.hexcolor=hexcolor;
    }

    @Override
    public Grid clone(){
        return new Grid(value,color,hexcolor);
    }

}
