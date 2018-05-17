//
//  DDSliderView.h
//  DingDing
//
//  Created by 王万鹏 on 2018/3/29.
//  Copyright © 2018年 ddtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWSliderView : UIControl


@property (nonatomic, assign) CGFloat maximumValue;//最大滑动数值
@property (nonatomic, assign) CGFloat minimumValue;//最小滑动数值
@property (nonatomic, assign) float upperValue;//右边滑块所在位置
@property (nonatomic, assign) float lowerValue;//左边滑块所在位置


/**
 重新构造方法

 @param frame frame
 @param sliderColor 线条默认颜色
 @param leftSmallColor 左边滑块小圈颜色
 @param leftBigColor 左边滑块大圈颜色
 @param rightSmallColor 右边滑块小圈颜色
 @param rightBigColor 右边滑块大圈颜色
 @return 自己实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                  sliderColor:(UIColor *)sliderColor
               leftSmallColor:(UIColor *)leftSmallColor
                 leftBigColor:(UIColor *)leftBigColor
              rightSmallColor:(UIColor *)rightSmallColor
                rightBigColor:(UIColor *)rightBigColor;

//设置两滑块位置
- (void)resetLeftValue:(float)leftValue rightValue:(float)rightValue;

@end
