package autotetris.elements;


/**
 *
 * @author renmengy
 */
public class Grid {

    public byte value;
    public int hexcolor;

    public Grid(byte value, int hexcolor){
        this.value=value;
        this.hexcolor=hexcolor;
    }

    @Override
    public Grid clone(){
        return new Grid(value,hexcolor);
    }

}
