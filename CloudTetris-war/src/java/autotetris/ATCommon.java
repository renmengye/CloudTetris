package autotetris;

/**
 *
 * @author MengYe
 */
public interface ATCommon {

    public static final int TWIDTH = 202, THEIGHT = 382,
            GAP = 2, XNUM = 10, YNUM = 19,
            XDIM = TWIDTH / XNUM - GAP, YDIM = THEIGHT / YNUM - 2;
    
    public static final int[] O_NUM = {1, 2, 2, 2, 4, 4, 4};
    //probablity: not used in this application anymore
    public static final byte[][] PROB = {{10, 15, 15, 15, 10, 10, 25},
                                        {20, 5, 20, 20, 10, 10, 15},
                                        {0, 0, 0, 0, 0, 1, 0},
                                        {0, 0, 0, 0, 1, 0, 0},
                                        {20, 15, 15, 15, 10, 10, 15},
                                        {20, 15, 15, 15, 10, 10, 15},
                                        {15, 30, 15, 15, 5, 5, 15}};
    //contour constants
    public static final int CONTOUR_DX = 0, CONTOUR_DY = 1;

    public static final byte[][][][] CONTOUR = {{{{-1, 0}, {0, 0}, {-1, 1}, {0, 1}}},
                                                {{{-2, 0}, {-1, 0}, {0, 0}, {1, 0}}, {{0, -2}, {0, -1}, {0, 0}, {0, 1}}},
                                                {{{-1, 1}, {0, 1}, {0, 0}, {1, 0}}, {{-1, -1}, {-1, 0}, {0, 0}, {0, 1}}},
                                                {{{-1, 0}, {0, 0}, {0, 1}, {1, 1}}, {{0, -1}, {0, 0}, {-1, 0}, {-1, 1}}},
                                                {{{-1, 0}, {0, 0}, {1, 0}, {1, 1}}, {{0, -1}, {0, 0}, {0, 1}, {-1, 1}}, {{-1, -1}, {-1, 0}, {0, 0}, {1, 0}}, {{1, -1}, {0, -1}, {0, 0}, {0, 1}}},
                                                {{{-1, 1}, {-1, 0}, {0, 0}, {1, 0}}, {{-1, -1}, {0, -1}, {0, 0}, {0, 1}}, {{-1, 0}, {0, 0}, {1, 0}, {1, -1}}, {{0, -1}, {0, 0}, {0, 1}, {1, 1}}},
                                                {{{-1, 0}, {0, 0}, {1, 0}, {0, 1}}, {{-1, 0}, {0, 0}, {0, -1}, {0, 1}}, {{-1, 0}, {0, 0}, {1, 0}, {0, -1}}, {{0, 0}, {1, 0}, {0, -1}, {0, 1}}}};


    public static final int MAX_DEPTH = 0;

    public static final byte[][] START_Y={{0},
                                            {0,2},
                                            {0,1},
                                            {0,1},
                                            {0,1,1,1},
                                            {0,1,1,1},
                                            {0,1,1,1}};
    public static final int[] SCORE={0,1,3,6,10};

    public static final int[][] PIECE_COLOR={{0,153,204},
                                            {204,153,255},
                                            {153,255,255},
                                            {51,204,153},
                                            {255,153,0},
                                            {153,102,0},
                                            {0,153,51}};
    
    public static final String[] PIECE_WEB_COLOR={"#00ced1",
                                                  "#ff7f50",
                                                  "#3cb371",
                                                  "#d2b48c",
                                                  "#dda0dd",
                                                  "#4169e1",
                                                  "#ffc0cb"
        
    };
}
