PVector startAnchor, endAnchor;
PolygonTransformer pTransformer;
PolygonFactory pFactory;
PolygonStack pStack;
Polygon p;

void setup() {
    size(700, 700);
    colorMode(HSB, 360, 100, 100);
    background(360, 0, 100);
    noStroke();
    startAnchor = new PVector(width/2, 100);
    endAnchor = new PVector(width/2, height - 100);
    pTransformer = new PolygonTransformer();
    pFactory = new PolygonFactory();
    pStack = new PolygonStack(color(360, 50, 0), 15);

    // Change/comment/uncomment the following 2 lines to change the shape of the initial polygon.

    p = pFactory.createRectangle(startAnchor, endAnchor, 100);
    //p = pFactory.createRegularPolygon(new PVector(width/2, height/2), 100, 8);

    for (int i = 0; i < 15; i++) {
        pStack.add(p);
        
        // Change/comment/uncomment these lines to see various deformation functions in actions.

        //p = pTransformer.gaussianDistort(p, 1);
        //p = pTransformer.gaussianDistort(p, 4);

        //p = pTransformer.gaussianDistortOdd(p, 3);

        p = pTransformer.gaussianDistort(p, 2, pTransformer.getMidpoint(startAnchor, endAnchor), -0.03);
        //p = pTransformer.gaussianDistort(p, 5, getMidpoint(startAnchor, endAnchor), 0.15);

        //p = pTransformer.gaussianDistortOdd(p, 4, getMidpoint(startAnchor, endAnchor), 0.2);
        //p = pTransformer.gaussianDistortOdd(p, 0.5, getMidpoint(startAnchor, endAnchor), 0.1);
        //p = pTransformer.gaussianDistortOdd(p, 3, getMidpoint(startAnchor, endAnchor), -0.03);

        //p = pTransformer.driftDistort(p, 3, 20, startAnchor, endAnchor);
        //p = pTransformer.driftDistort(p, 3, 5, startAnchor, endAnchor);
        //p = pTransformer.driftDistort(p, 4, 10, startAnchor, endAnchor);

        //p = pTransformer.driftDistortOdd(p, 4, 5, startAnchor, endAnchor);
        //p = pTransformer.driftDistortOdd(p, 2, 3, startAnchor, endAnchor);

        //p = pTransformer.shrinkAlongAxis(p, 4, 6, startAnchor, endAnchor);
        //p = pTransformer.shrinkAlongAxis(p, 6, 10, startAnchor, endAnchor);

        //p = pTransformer.shrinkAlongAxisOdd(p, 6, 10, startAnchor, endAnchor);
        //p = pTransformer.shrinkAlongAxisOdd(p, 5, 15, startAnchor, endAnchor);

        //p = pTransformer.shrinkDistort(p, 10, getMidpoint(startAnchor, endAnchor), 5);
    }

    // Change the draw function parameter to change te amount of alpha increment.
    // Alpha increment is explained in the documentation od the function.
    // If alpha increment is set to negative, then change the starting alpha value
    // that is set at the pStack initialization.
        
    pStack.draw(2);
    
}

void draw() {}