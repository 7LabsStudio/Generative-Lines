/**
 * Line class that has width and other parameters that alter the way it renders on screen.
 */
class Line {
    private PolygonTransformer pt = new PolygonTransformer();
    private PolygonFactory pf = new PolygonFactory();
    private PVector bias = new PVector(width/2, height/2);
    PVector axisStart = new PVector(width/2, 0);
    PVector axisEnd = new PVector(width/2, height);
    DistortType distortType;
    color colour;
    float lineWidth;
    float alpha = 100;
    float variance = 3;
    float distCoeff = 0;
    int depth = 15;
    boolean odd = false;
    
    Line(DistortType distortType, float lineWidth) {
        this.distortType = distortType;
        this.lineWidth = lineWidth;
    }
    
    private Polygon transform(Polygon p) {
        switch (this.distortType) {
            case UNIFORM:
                return this.odd ?
                    pt.uniformDistortOdd(p, variance) :
                    pt.uniformDistort(p, variance);
            case POINT_BIASED:
                if (bias == null) {
                    throw new NullPointerException("Bias point cannot be null.");
                }
                return this.odd ?
                    pt.pointBiasedDistortOdd(p, variance, bias, distCoeff) :
                    pt.pointBiasedDistort(p, variance, bias, distCoeff);
            case VECTOR_BIASED:
                if (axisStart == null || axisEnd == null) {
                    throw new NullPointerException("Axis endpoint cannot be null.");
                }
                return this.odd ?
                    pt.vectorBiasedDistortOdd(p, variance, distCoeff, axisStart, axisEnd) :
                    pt.vectorBiasedDistort(p, variance, distCoeff, axisStart, axisEnd);
            case AXIS_BIASED:
                if (axisStart == null || axisEnd == null) {
                    throw new NullPointerException("Axis endpoint cannot be null.");
                }
                return this.odd ?
                    pt.axisBiasedDistortOdd(p, variance, distCoeff, axisStart, axisEnd) :
                    pt.axisBiasedDistort(p, variance, distCoeff, axisStart, axisEnd);
            default:
               return p; 
        }
    }
    
    /**
     * Sets the axis start and end points. Axis is used in transformations that require
     * moving points in a direction relative to some line, as opposed to bias,
     * which is used when points need to be moved in a direction of some other point.
     * Default axis line is a vertical line that goes through the center of rendering area.
     * If, for some reason, axis points are point null when draw() function is called,
     * NullPointerException will be thrown and the program will freeze/crash.
     *
     * @param  x1  x coordinate of start point
     * @param  y1  y coordinate of start point
     * @param  x2  x coordinate of end point
     * @param  y2  y coordinate of end point
     */
    void axis(float x1, float y1, float x2, float y2) {
        this.axisStart = new PVector(x1, y1);
        this.axisEnd = new PVector(x2, y2);
    }
    
    /**
     * Sets the bias point that is important for some types of lines.
     * Default bias point is in the center of the rendering area.
     * If for some reason bias point null when draw() function is called,
     * NullPointerException will be thrown and the program will freeze/crash.
     *
     * @param  x  x coordinate of bias point
     * @param  y  y coordinate of bias point
     */
    void bias(float x, float y) {
        this.bias = new PVector(x, y);
    }
    
    /**
     * Draws a line from (x1, y1) to (x2, y2).
     * This method does a lot of heavy lifting, since it first generates the line as
     * a polygon stack of given depth, and then does the drawing to the screen.
     * Potential FIXME: Right now it is okay that the line polygon is generated
     * at drawing time, but it could potentially be problematic if, in the future,
     * this class is used for drawing lines interactively, in which case it could cause
     * screen flickering and/or delayed rendering of some lines.
     *
     * @param  x1  x coordinate of start point
     * @param  y1  y coordinate of start point
     * @param  x2  x coordinate of end point
     * @param  y2  y coordinate of end point
     */
    void draw(float x1, float y1, float x2, float y2) {
        PolygonStack ps = new PolygonStack(this.colour, this.alpha);
        Polygon p = pf.createRectangle(x1, y1, x2, y2, this.lineWidth);
        ps.add(p);
        for (int i = 0; i < this.depth; i++) {
            p = transform(p);
            ps.add(p);
        }
        ps.draw();
    }
}
