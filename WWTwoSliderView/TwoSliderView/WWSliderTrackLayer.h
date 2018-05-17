//
//  DDRangeSliderTrackLayer.h
//  DingDing
//
//  Created by 王万鹏 on 2018/3/29.
//  Copyright © 2018年 王万鹏. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WWSliderTrackLayer : CALayer

@property(nonatomic, assign)CGFloat lowerCenterX;
@property(nonatomic, assign)CGFloat upperCenterX;
@property(nonatomic, strong)CAGradientLayer *middleLayer;

@end
