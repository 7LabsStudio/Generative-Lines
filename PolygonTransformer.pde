int MAX_VERTICES = 100000;

/*
 * Class that contains methods for stochastic and deterministic
 * polygon transformations.
 * 
 * If the name of the method ends with Odd, it means
 * that the points from the original polygon are fixed, and the only
 * points that move are the ones newly inserted into the polygon,
 * since this type of transformation can produce interesting effects.
 * 
 * Design decision: Since the rendering of polygons occurs only
 * after all polygons are pushed on stack, all methods in this
 * class return a list of completely new points, ie. points
 * from the input polygon aren't reused, even if the points with
 * same coordinates occur in the output polygon.
 *
 * Potential FIXME: This class also contains helper methods for
 * manipulating points and getting vectors oriented in a particular
 * way. If these get numerous in the future, they could be put into
 * a separate class.
 */

class PolygonTransformer {
    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves all points
     * around by adding a gaussian random number with given variances
     * to its x and y coordinates.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @return          distorted polygon
     */    
    Polygon gaussianDistort(Polygon p, float variance) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(disturbPoint(new PVector(p.get(i).x, p.get(i).y), variance));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves only new
     * points by adding a gaussian random number with given
     * variance to its x and y coordinates.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @return          distorted polygon
     */    
    Polygon gaussianDistortOdd(Polygon p, float variance) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(new PVector(p.get(i).x, p.get(i).y));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves all points
     * around by adding a gaussian random number with given variances
     * to its x and y coordinates, but the prefered direction of
     * displacement is towards the bias point. The ammount of
     * preference to the bias point is determined by the distCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param bias      bias point
     * @param distCoeff amount of preference towards the bias point
     * @return          distorted polygon
     */    
    Polygon gaussianDistort(Polygon p, float variance, PVector bias, float distCoeff) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(disturbPoint(new PVector(p.get(i).x, p.get(i).y), variance));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(PVector.sub(bias, midpoint).mult(distCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves only new points
     * by adding a gaussian random number with given variances to its
     * x and y coordinates, but the prefered direction of displacement
     * is towards the bias point. The ammount of preference to the
     * bias point is determined by the distCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param bias      bias point
     * @param distCoeff amount of preference towards the bias point
     * @return          distorted polygon
     */    
    Polygon gaussianDistortOdd(Polygon p, float variance, PVector bias, float distCoeff) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(new PVector(p.get(i).x, p.get(i).y));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(PVector.sub(bias, midpoint).mult(distCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves all points
     * around by adding a gaussian random number with given variances
     * to its x and y coordinates, but the prefered direction of
     * displacement is in the direction of a vector perpendicular to the
     * vector from start to end. The ammount of preference to the bias
     * point is determined by the biasCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param biasCoeff amount of preference towards the bias vector
     * @param start     beginning of the axis vector
     * @param end       end of the axis vector
     * @return          distorted polygon
     */    
    Polygon driftDistort(Polygon p, float variance, float biasCoeff, PVector start, PVector end) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(disturbPoint(new PVector(p.get(i).x, p.get(i).y), variance));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(getDriftVector(start, end).mult(biasCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves only those points
     * around by adding a gaussian random number with given variances
     * to its x and y coordinates, but the prefered direction of
     * displacement is in the direction of a vector perpendicular to the
     * vector from start to end. The ammount of preference to the bias
     * point is determined by the biasCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param biasCoeff amount of preference towards the bias vector
     * @param start     beginning of the axis vector
     * @param end       end of the axis vector
     * @return          distorted polygon
     */    
    Polygon driftDistortOdd(Polygon p, float variance, float biasCoeff, PVector start, PVector end) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(new PVector(p.get(i).x, p.get(i).y));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(getDriftVector(start, end).mult(biasCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves all points
     * around by adding a gaussian random number with given variances
     * to its x and y coordinates, but the prefered direction of
     * displacement is in the direction of an axis vector that goes
     * from start to end vectors. The ammount of preference to the bias
     * point is determined by the biasCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param biasCoeff amount of preference towards the bias vector
     * @param start     beginning of the axis vector
     * @param end       end of the axis vector
     * @return          distorted polygon
     */    
    Polygon shrinkAlongAxis(Polygon p, float variance, float biasCoeff, PVector start, PVector end) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(disturbPoint(new PVector(p.get(i).x, p.get(i).y), variance));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(getVectorTowardsLine(midpoint, start, end).mult(biasCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

    /**
     * Distorts a polygon in such way that it adds a new point in
     * the middle of every polygon side, and then moves only those 
     * points by adding a gaussian random number with given variances
     * to its x and y coordinates, but the prefered direction of
     * displacement is in the direction of an axis vector that goes
     * from start to end vectors. The ammount of preference to the bias
     * point is determined by the biasCoeff.
     * The distCoeff scales the vector from the current point to the bias
     * point, and then adds it to the current point.
     *
     * @param p         input polygon
     * @param variance  gaussian distribution variance
     * @param biasCoeff amount of preference towards the bias vector
     * @param start     beginning of the axis vector
     * @param end       end of the axis vector
     * @return          distorted polygon
     */    
    Polygon shrinkAlongAxisOdd(Polygon p, float variance, float biasCoeff, PVector start, PVector end) {
        ArrayList<PVector> output = new ArrayList<PVector>();
        PVector midpoint;
        for (int i = 0; i < p.size(); ++i) {
            output.add(new PVector(p.get(i).x, p.get(i).y));
            midpoint = getMidpoint(p.get(i), p.get((i + 1) % p.size()));
            midpoint.add(getVectorTowardsLine(midpoint, start, end).mult(biasCoeff));
            disturbPoint(midpoint, variance);
            output.add(midpoint);
        }
        return new Polygon(output);
    }

   /**
    * Stochastically shrinks a polygon towards the bias point.
    * If the variance is 0, then it just shrinks the polygon.
    *
    * @param p              input polygon
    * @param variance       gaussian distribution variance
    * @param bias           bias point
    * @param shrinkCoeff    amount of preference towards the
    *                       bias vector
    * @return          distorted polygon
    */
   Polygon shrinkDistort(Polygon p, float variance, PVector bias, float shrinkCoeff) {
       ArrayList<PVector> output = new ArrayList<PVector>();
       for (PVector v: p.getVertices()) {
           output.add(
               disturbPoint(
                   (new PVector(v.x, v.y)).add(PVector.sub(bias, v).mult(shrinkCoeff/100)),
                   variance
                )
            );
       }
       return new Polygon(output);
   }
   
   /**
    * Changes the input point by adding random gaussian numbers to its x and y
    * coordinates.
    *
    * @param point      input polygon
    * @param variance   gaussian distribution variance
    * @return           input point with changed position
    */
    PVector disturbPoint(PVector point, float variance) {
        point.x += randomGaussian() * variance;
        point.y += randomGaussian() * variance;
        return point;
    }

    /**
     * Returns unit vector in the direction rotated +90 degrees relative to
     * the vector that goes from start to end points.
     *
     * @param start axis vector start position
     * @param end   axis vector end position
     * @return      unit vector perpendicular to end - start
     */
    PVector getDriftVector(PVector start, PVector end) {
        PVector axis = PVector.sub(end, start);
        return axis.rotate(HALF_PI).normalize();
    }

    /**
     * Returns unit vector in the direction of the vector that goes from
     * start to end points.
     *
     * @param start axis vector start position
     * @param end   axis vector end position
     * @return      unit vector perpendicular to end - start
     */
    PVector getVectorTowardsLine(PVector start, PVector end, PVector point) {
        PVector axis = PVector.sub(end, start).rotate(HALF_PI);
        PVector temp = PVector.sub(start, point);
        axis.mult(-sign(PVector.dot(axis, temp)));
        return axis.normalize();
    }

    /**
     * Returns point that is in the middle of the line connecting the two input points.

     * @param start start position
     * @param end   end position
     * @return      middle point
     */
    PVector getMidpoint(PVector start, PVector end) {
        PVector temp = PVector.sub(end, start).mult(0.5);
        return PVector.add(start, temp);
    }

}

/**
 * Determines the sign of input number.
 *
 * @param x input number
 * @return  -1 if x is negative, 1 if x is positive
 */
float sign(float x) {
    return x > 0 ? 1 : -1;
}

/**
 * Enum that contains various ways of distorting a polygon.
 */
enum DistortType {
    GAUSSIAN,
    GAUSSIAN_BIASED,
    DRIFT,
    SHRINK,
    AXIS_SHRINK
}
