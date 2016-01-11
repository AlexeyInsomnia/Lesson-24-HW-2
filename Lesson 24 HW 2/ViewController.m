//
//  ViewController.m
//  Lesson 24 HW 2
//
//  Created by Alex on 10.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"
#import "APDrawingView.h"

@interface ViewController ()


@property (assign, nonatomic) CGPoint lastPoint;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*) randomColor {
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    

    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
   
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.canvas.image drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
    
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    NSLog(@"%.2f,%.2f",self.lastPoint.x, self.lastPoint.y );
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context,10.0f);
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    CGContextStrokePath(context);
    
   
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {


}


#pragma mark - Orientation



 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         //UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
         // do whatever
         
         [self.drawingView setNeedsDisplay];
         
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


@end
