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

`Line l = new Line(DistortType.GAUSSIAN, 30);`  
`l.variance = .5;`  
`l.alpha = 30;`  
`l.draw(200, 100, 200, 500);`  

Which produces the following image:  

<a>![sth](https://raw.githubusercontent.com/sighack/watercolor-simulation/master/images/1.png)</a>




# Examples
