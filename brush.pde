void setup() {
    size(700, 700);
    colorMode(HSB, 360, 100, 100);
    background(360, 0, 100);
    noStroke();

    /*
    // Example #1
    Line l1 = new Line(DistortType.UNIFORM, 10);
    l1.variance = .5;
    l1.alpha = 30;
    l1.draw(200, 100, 200, 500);
    l1.draw(205, 495, 500, 500);
    l1.draw(495, 495, 495, 100);
    l1.draw(495, 100, 200, 100);

    // Example #2
    Line l2 = new Line(DistortType.POINT_BIASED, 25);
    l2.variance = 1;
    l2.alpha = 10;
    l2.distCoeff = 3;
    l2.bias(600, 400);
    l2.draw(300, 300, 350, 350);
    l2.draw(350, 350, 300, 400);
    l2.draw(300, 400, 350, 450);
    l2.draw(325, 300, 325, 450);
    l2.draw(350, 300, 300, 400);
    l2.draw(300, 300, 350, 450);

    // Example #3
    Line l3 = new Line(DistortType.UNIFORM, 250);
    l3.variance = 10;
    l3.alpha = 10;
    l3.odd = true;
    l3.draw(350, 100, 350, 500);

    // Example #4
    Line l4 = new Line(DistortType.VECTOR_BIASED, 30);
    l4.distCoeff = 8;
    l4.alpha = 30;
    l4.bias(0, -1);
    l4.draw(300, 220, 310, 210);
    // Left one is drawn with odd == false, and the right with odd == true.
    l4.odd = true;
    l4.draw(400, 220, 410, 210);

    // Example #5
    Line l5 = new Line(DistortType.ROTATIONAL, 60);
    l5.distCoeff = 0.2;
    l5.threshold = 2;
    l5.variance = 2;
    l5.alpha = 30;
    l5.odd = true;
    l5.bias(350, 540);
    l5.draw(350, 500, 350, 630);
    
    // Varying distortion method
    Line l6 = new Line(DistortType.UNIFORM, 30);
    l6.alpha = 20;
    l6.variance = 1;
    l6.threshold = -1;

    l6.draw(200, 100, 200, 300);

    l6.distortType = DistortType.POINT_BIASED;
    l6.bias(300, 400);
    l6.distCoeff = .05;
    l6.relative = true;
    l6.draw(300, 100, 300, 300);

    l6.distortType = DistortType.VECTOR_BIASED;
    l6.bias(1, 2);
    l6.distCoeff = 5;
    l6.relative = false;
    l6.draw(400, 100, 400, 300);

    l6.distortType = DistortType.ROTATIONAL;
    l6.bias(750, 100);
    l6.distCoeff = -7;
    l6.relative = true;
    l6.odd = false;
    l6.draw(500, 100, 500, 300);
    
    // Varying variance example
    Line l7 = new Line(DistortType.UNIFORM, 30);
    l7.alpha = 30;
    l7.variance = 0;
    l7.draw(200, 100, 200, 300);
    l7.variance = 0.5;
    l7.draw(300, 100, 300, 300);
    l7.variance = 1;
    l7.draw(400, 100, 400, 300);
    l7.variance = 2;
    l7.draw(500, 100, 500, 300);

    Line l8 = new Line(DistortType.POINT_BIASED, 30);
    l8.alpha = 40;
    l8.relative = true;
    l8.threshold = 4;
    l8.distCoeff = 0.02;
    l8.draw(100, 100, 100, 300);
    l8.bias(width / 2 + 200, height / 2);
    l8.odd = true;
    l8.draw(300, 100, 300, 300);
    
    // Alpha example
    Line l9 = new Line(DistortType.ROTATIONAL, 50);
    l9.distCoeff = 6;
    l9.bias(350, 200);
    l9.alpha = 100;
    l9.draw(100, 100, 100, 300);
    l9.alpha = 40;
    l9.draw(250, 100, 250, 300);
    l9.alpha = 20;
    l9.draw(400, 100, 400, 300);
    l9.alpha = 10;
    l9.draw(550, 100, 550, 300);
    
    // Depth example
    Line l10 = new Line(DistortType.ROTATIONAL, 50);
    l10.distCoeff = 6;
    l10.bias(350, 200);
    l10.alpha = 40;
    l10.draw(100, 100, 100, 300);
    l10.depth = 10;
    l10.draw(250, 100, 250, 300);
    l10.depth = 7;
    l10.draw(400, 100, 400, 300);
    l10.depth = 3;
    l10.draw(550, 100, 550, 300);
    */

}

void draw() {}