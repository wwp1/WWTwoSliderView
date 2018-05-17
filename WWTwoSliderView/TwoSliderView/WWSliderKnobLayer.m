//
//  DDRangeSliderKnobLayer.m
//  DingDing
//
//  Created by 王万鹏 on 2018/3/29.
//  Copyright © 2018年 王万鹏. All rights reserved.
//

#import "WWSliderKnobLayer.h"
//#import "UIColor+DDColor.h"

@implementation WWSliderKnobLayer


- (void)drawInContext:(CGContextRef)ctx
{

    self.cornerRadius = self.frame.size.width * 0.5;
    
    _roundLayer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.width * 0.5);
    //设置大小
    _roundLayer.bounds = CGRectMake(0, 0, self.frame.size.width * 0.5,self.bounds.size.height * 0.5);
    
    _roundLayer.cornerRadius = self.frame.size.width * 0.5 * 0.5;
    
   
    [self addSublayer:_roundLayer];
    [_roundLayer setNeedsDisplay];
   
}


@end
