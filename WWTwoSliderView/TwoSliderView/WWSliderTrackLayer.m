//
//  DDRangeSliderTrackLayer.m
//  DingDing
//
//  Created by 王万鹏 on 2018/3/29.
//  Copyright © 2018年 王万鹏. All rights reserved.
//

#import "WWSliderTrackLayer.h"
#import <UIKit/UIKit.h>

@implementation WWSliderTrackLayer



- (void)drawInContext:(CGContextRef)ctx
{

    self.cornerRadius = self.frame.size.height * 0.5;

    float lower = self.lowerCenterX - self.frame.origin.x;
    float upper = self.upperCenterX - self.frame.origin.x;

    _middleLayer.frame = CGRectMake(lower, 0, upper - lower, self.frame.size.height);
    
    _middleLayer.locations = @[@0.0, @1.0];
    _middleLayer.startPoint = CGPointMake(0, 0);
    _middleLayer.endPoint = CGPointMake(1.0, 0);
    [self addSublayer:_middleLayer];
    [_middleLayer setNeedsDisplay];

}



@end
