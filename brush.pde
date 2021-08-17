void setup() {
    size(700, 700);
    colorMode(HSB, 360, 100, 100);
    background(360, 0, 100);
    noStroke();

    // Example #1
    Line l1 = new Line(DistortType.GAUSSIAN, 10);
    l1.variance = .5;
    l1.alpha = 30;
    l1.draw(200, 100, 200, 500);
    l1.draw(205, 495, 500, 500);
    l1.draw(495, 495, 495, 100);
    l1.draw(495, 100, 200, 100);

    // Example #2
    Line l2 = new Line(DistortType.GAUSSIAN_BIASED, 25);
    l2.variance = 1;
    l2.alpha = 10;
    l2.distCoeff = 0.02;
    l2.bias(600, 400);
    l2.draw(300, 300, 350, 350);
    l2.draw(350, 350, 300, 400);
    l2.draw(300, 400, 350, 450);
    l2.draw(325, 300, 325, 450);
    l2.draw(350, 300, 300, 400);
    l2.draw(300, 300, 350, 450);
    
    // Example #3
    Line l3 = new Line(DistortType.GAUSSIAN, 250);
    l3.variance = 10;
    l3.alpha = 10;
    l3.odd = true;
    l3.draw(350, 100, 350, 500);
    
    // Example #4
    Line l4 = new Line(DistortType.DRIFT, 30);
    l4.distCoeff = -7;
    l4.alpha = 30;
    // Left "eye" is drawn with odd == false, and the right with odd == true.
    l4.axis(0, 100, 100, 0);
    l4.draw(300, 220, 310, 210);
    l4.odd = true;
    l4.axis(600, 0, 700, 100);
    l4.draw(400, 220, 410, 210);

    // Example #5
    Line l5 = new Line(DistortType.AXIS_SHRINK, 60);
    l5.distCoeff = 5;
    l5.variance = 2;
    l5.alpha = 30;
    l5.odd = true;
    l5.axis(350, 0, 350, 700);
    l5.draw(350, 500, 350, 630);
}

void draw() {}