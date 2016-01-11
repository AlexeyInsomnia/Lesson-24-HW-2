//
//  APDrawingView.m
//  Lesson 24 HW 2
//
//  Created by Alex on 10.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APDrawingView.h"

@implementation APDrawingView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    for (int i = 0; i < 6; i++) {
        [self drawFiveStar:context andRect:rect];
    }
    
}



- (void) drawFiveStar:(CGContextRef) contextNew andRect:(CGRect) rect {
    


    
    NSLog(@"drawRect %@", NSStringFromCGRect(rect));
    
    
    NSUInteger numberOfStarsVertices = 5;
    
    NSUInteger numberOfVerticesForDraw = 2;
   
    NSUInteger radiusStar = 50;
    
    NSUInteger circleRadius = 10;
    
    CGPoint centerOfStar;
 
    centerOfStar.x = arc4random()%((NSUInteger)CGRectGetWidth(rect)/2 - 2*radiusStar - 2*circleRadius) + radiusStar + circleRadius;
    centerOfStar.y = arc4random()%((NSUInteger)CGRectGetHeight(rect)/2 - 2*radiusStar - 2*circleRadius) + radiusStar + circleRadius;


    CGFloat firstVerticeAngle = 3*M_PI/2;
    
    //CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    NSLog(@"Center of the star point is: %@", NSStringFromCGPoint(centerOfStar));
    
    NSMutableArray *points = [NSMutableArray array];
    
    // draw the star
    CGContextSetFillColorWithColor(contextNew, [self randomColor].CGColor); //fill color star
    CGPoint firstPoint = CGPointMake(centerOfStar.x, centerOfStar.y-radiusStar);//left point
    CGContextMoveToPoint(contextNew, firstPoint.x, firstPoint.y);//start from here - left point of star
    CGPoint point;
    NSLog(@"Lets make points for star:");
    
    
    for (int i = 0; i <= numberOfStarsVertices - 1; i++) {
        
        point.x = centerOfStar.x + radiusStar*cos(2*M_PI/numberOfStarsVertices*(numberOfVerticesForDraw*i) + firstVerticeAngle);
        point.y = centerOfStar.y + radiusStar*sin(2*M_PI/numberOfStarsVertices*(numberOfVerticesForDraw*i) + firstVerticeAngle);
 
        [points addObject:[NSValue valueWithCGPoint:point]];
        
        CGContextAddLineToPoint(contextNew, point.x, point.y);
        
        NSLog(@"%d: %@", i, NSStringFromCGPoint(point));
    }
    
    CGContextAddLineToPoint(contextNew, firstPoint.x, firstPoint.y);
    
    CGContextFillPath(contextNew);
    
    // draw the circles
    CGContextSetStrokeColorWithColor(contextNew, [self randomColor].CGColor);
    for (int i = 0; i <= numberOfStarsVertices - 1; i++) {
        point = [points[i] CGPointValue];
        CGContextMoveToPoint(contextNew, point.x + circleRadius, point.y);
        CGContextAddArc(contextNew, point.x, point.y, circleRadius, 0, 2*M_PI, 0);
    }
    CGContextSetLineWidth(contextNew, circleRadius/3.f);
    CGContextStrokePath(contextNew);
    
    // draw the polygon
    CGContextSetStrokeColorWithColor(contextNew, [self randomColor].CGColor);
    NSLog(@"Points for polygon:");
    CGContextMoveToPoint(contextNew, firstPoint.x, firstPoint.y);
    for (int i = 1; i <= numberOfStarsVertices - 1; i++) {
        
        point.x = centerOfStar.x + radiusStar*cos(2*M_PI/numberOfStarsVertices*(i) + firstVerticeAngle);
        point.y = centerOfStar.y + radiusStar*sin(2*M_PI/numberOfStarsVertices*(i) + firstVerticeAngle);
        CGContextAddLineToPoint(contextNew, point.x, point.y);
        
        NSLog(@"%d: %@", i, NSStringFromCGPoint(point));
    }
    CGContextAddLineToPoint(contextNew, firstPoint.x, firstPoint.y);
    CGContextSetLineCap(contextNew, kCGLineCapRound);
    
    CGContextStrokePath(contextNew);
    
    CGContextSetFillColorWithColor(contextNew, [UIColor greenColor].CGColor);
    CGContextFillPath(contextNew);
}

- (UIColor*) randomColor {
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}


@end
