//
//  ViewController.h
//  Lesson 24 HW 2
//
//  Created by Alex on 10.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APDrawingView;

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet APDrawingView* drawingView;
@property (weak, nonatomic) IBOutlet UIImageView *canvas;


@end

