# About

This is a [processing 3.0](https://processing.org/) library for drawing generative lines with various textures.

# Getting started

## Download
Download all the `.pde` files and put them in your processing sketch folder.  
If you're using command line, you can download them with the following command:

`$ git clone https://gitlab.com/enverpodgorcevic/ldt`

## Basic usage
After putting all the `.pde` files in your folder of choice, you will be able to use all the downloaded classes in your sketch.  
The class `Line` is used for drawing lines of various shapes and sizes.  

In general, the lines are drawn in 3 steps:
1. creating Line object
2. set-up of line parameters
3. calling the `draw(x1, y1, x2, y2)` function on the object

This is a simple example of drawing a 30 pixel wide line that has slightly jagged edges.  

    Line l = new Line(DistortType.GAUSSIAN, 30);
    l.variance = .5;
    l.alpha = 30;
    l.draw(200, 100, 200, 500);

Which produces the following image:  

<a>![example 1](https://gitlab.com/enverpodgorcevic/ldt/-/raw/master/images/1.png)</a>

Once we have a Line object, it can be used to draw multiple lines of the same kind:

    Line l1 = new Line(DistortType.GAUSSIAN, 10);
    l1.variance = .5;
    l1.alpha = 30;
    l1.draw(200, 100, 200, 500);
    l1.draw(205, 495, 500, 500);
    l1.draw(495, 495, 495, 100);
    l1.draw(495, 100, 200, 100)


<a>![example 2](https://gitlab.com/enverpodgorcevic/ldt/-/raw/master/images/2.png)</a>

# `Line` class

## Distort type

When creating the `Line` object, we need to specify the `distortType` of the line.
In order to understand what this parameter does, one needs to know how this class actually draws the lines.
`Line` objects are drawn by drawing a certain number of rectangles on top of each other, each being a slightly distorted version of the previous one. `lineDistort` parameter determines the type of polygon distortion that takes place in this step.
Currently, the following distortion types are implemented:

- Gaussian
- Biased gaussian
- Drift distort
- Shrink along axis

# Examples
