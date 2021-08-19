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

    Line l = new Line(DistortType.UNIFORM, 30);
    l.variance = .5;
    l.alpha = 30;
    l.draw(200, 100, 200, 500);

Which produces the following image:  

<a>![single line example](https://gitlab.com/enverpodgorcevic/ldt/-/raw/master/images/1.png)</a>

Once we have a Line object, it can be used to draw multiple lines of the same kind:

    Line l1 = new Line(DistortType.UNIFORM, 10);
    l1.variance = .5;
    l1.alpha = 30;
    l1.draw(200, 100, 200, 500);
    l1.draw(205, 495, 500, 500);
    l1.draw(495, 495, 495, 100);
    l1.draw(495, 100, 200, 100)


<a>![multiple lines example](https://gitlab.com/enverpodgorcevic/ldt/-/raw/master/images/2.png)</a>

# `Line` class parameters

## Distort type

When creating the `Line` object, we need to specify the `distortType` of the line.
In order to understand what this parameter does, one needs to know how this class actually draws the lines.
`Line` objects are drawn by drawing a certain number of rectangles on top of each other, each being a slightly distorted version of the previous one. `lineDistort` parameter determines the type of polygon distortion that takes place in this step.  
All distortion algorithms move the points of the input polygon randomly about their original location, and the type of random distribution used is _gaussian distribution_. The difference between each type of distribution lies in the direction in which the distorted points tend to move:

- **Uniform distortion** - no preference for any particular direction
- **Point-biased distortion** - prefers the direction towards the bias point
- **Vector-biased distortion** - prefers the direction in the direction of some vector
- **Axis-biased distortion** - prefers the direction of 90° towards some line

## Variance

[Variance](https://en.wikipedia.org/wiki/Variance) parameter determines the amount of spread-outness of the random distribution.
If we use 0 as value of this parameter, we can get shrinking or translating effect if we use point-biased or vector-biased distortion respectively. The following example uses variance value of `0, 0.5, 1, 2`:

<a>![variance example](https://gitlab.com/enverpodgorcevic/ldt/-/raw/master/images/4.png)</a>

## Distance coefficient

When distortion algorithm implies moving the point `A` towards some other point `B`, `distance coefficient` is the number that determines how much this point is moved, relative to the distance between these two points. This number will probably always be some small number, e.g. 1/10, 1/100, 1/1000 etc.

# Examples
