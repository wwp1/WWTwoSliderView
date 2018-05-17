//
//  DDSliderView.m
//  DingDing
//
//  Created by 王万鹏 on 2018/3/29.
//  Copyright © 2018年 ddtech. All rights reserved.
//

#import "WWSliderView.h"
#import "WWSliderKnobLayer.h"
#import "WWSliderTrackLayer.h"

@implementation WWSliderView
{
    WWSliderTrackLayer *trackLayer;//slider线条
    WWSliderKnobLayer *lowerKnobLayer;//slider左边边的滑块
    WWSliderKnobLayer *upperKnobLayer;//slider右边的滑块

    UILabel *leftLabel;
    UILabel *rightLabel;
    
    CGFloat track_x;
    CGFloat knobWidth;
    CGFloat useableTrackLength;
    
    CGPoint previousTouchPoint;
    
    UIColor *_sliderColor;
    UIColor *_leftSmallColor;
    UIColor *_leftBigColor;
    UIColor *_rightSmallColor;
    UIColor *_rightBigColor;

    
    BOOL _seclectedUpperKnob;
    BOOL _seclectedLowerKnob;
}

- (instancetype)initWithFrame:(CGRect)frame
                  sliderColor:(UIColor *)sliderColor
               leftSmallColor:(UIColor *)leftSmallColor
                 leftBigColor:(UIColor *)leftBigColor
              rightSmallColor:(UIColor *)rightSmallColor
                rightBigColor:(UIColor *)rightBigColor
{
    self = [super initWithFrame:frame];
    if (self) {
        _maximumValue = 24.0;
        _minimumValue = 0.0;
        _upperValue = 24.0;
        _lowerValue = 0.0;

        _sliderColor = sliderColor;
        _leftSmallColor = leftSmallColor;
        _leftBigColor = leftBigColor;
        _rightSmallColor = rightSmallColor;
        _rightBigColor = rightBigColor;
        
        [self creatViews];
        
        [self setLayerFrames];
        
    }
    return self;
    
}


- (void)creatViews {
    //slider线条
    trackLayer = [WWSliderTrackLayer layer];
    trackLayer.backgroundColor = _sliderColor.CGColor;
    //中间渐变线条
    trackLayer.middleLayer = [CAGradientLayer layer];
    trackLayer.middleLayer.colors = @[(__bridge id)_leftBigColor.CGColor,(__bridge id)_rightBigColor.CGColor];
    
    [self.layer addSublayer:trackLayer];
    
    //slider左边边的滑块
    lowerKnobLayer = [WWSliderKnobLayer layer];
    lowerKnobLayer.backgroundColor = _leftBigColor.CGColor;

    lowerKnobLayer.roundLayer = [[CALayer alloc]init];
    lowerKnobLayer.roundLayer.backgroundColor = _leftSmallColor.CGColor;
    
    [self.layer addSublayer:lowerKnobLayer];
    
    //slider右边的滑块
    upperKnobLayer = [WWSliderKnobLayer layer];
    upperKnobLayer.backgroundColor = _rightBigColor.CGColor;
    
    upperKnobLayer.roundLayer = [[CALayer alloc]init];
    upperKnobLayer.roundLayer.backgroundColor = _rightSmallColor.CGColor;
    
    [self.layer addSublayer:upperKnobLayer];
    
    
    //左边label
    leftLabel = [[UILabel alloc]init];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.font = [UIFont systemFontOfSize:12]; ;
    leftLabel.frame = CGRectMake(0, 50, 36, 16);
    [self addSubview:leftLabel];
    
    //右边label
    rightLabel = [[UILabel alloc]init];
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.frame = CGRectMake(0, 50, 36, 16);
    [self addSubview:rightLabel];
}

#pragma mark - public
- (void)resetLeftValue:(float)leftValue rightValue:(float)rightValue {
    _lowerValue = leftValue;
    _upperValue = rightValue;
    
    [self setLayerFrames];
}

#pragma mark - private

- (void) setLayerFrames
{
    CGFloat widthRates = [UIScreen mainScreen].bounds.size.width/375;
    track_x = 50 * widthRates;

    trackLayer.frame = CGRectMake(track_x, self.frame.size.height * 0.5 - 1, self.frame.size.width - track_x * 2, 2);
    [trackLayer setNeedsDisplay];
    
    knobWidth = 24;
    useableTrackLength = self.bounds.size.width - track_x * 2;
    
    //现根据滑块对应的的值计算滑块center的x值，然后设置滑块的frame
    float upperKnobCentre = [self positionForValue:_upperValue];
    
    upperKnobLayer.frame = CGRectMake(upperKnobCentre - knobWidth / 2, self.frame.size.height * 0.5 - knobWidth * 0.5, knobWidth, knobWidth);
    
    float lowerKnobCentre = [self positionForValue:_lowerValue];
    lowerKnobLayer.frame = CGRectMake(lowerKnobCentre - knobWidth / 2, self.frame.size.height * 0.5 - knobWidth * 0.5, knobWidth, knobWidth);
    
    trackLayer.lowerCenterX = upperKnobCentre;
    trackLayer.upperCenterX = lowerKnobCentre;

    [upperKnobLayer setNeedsDisplay];
    [lowerKnobLayer setNeedsDisplay];
    
    NSString *leftStr = (NSInteger)_lowerValue < 10 ? @"0" : @"";
    NSString *rightStr = (NSInteger)_upperValue < 10 ? @"0" : @"";
    leftLabel.text = [NSString stringWithFormat:@"%@%ld:00",leftStr,(NSInteger)_lowerValue];
    rightLabel.text = [NSString stringWithFormat:@"%@%ld:00",rightStr,(NSInteger)_upperValue];
    
    //判断两个label没有重叠
    if (upperKnobLayer.frame.origin.x - lowerKnobLayer.frame.origin.x - lowerKnobLayer.frame.size.width - 14 > 0)
    {
            leftLabel.center = CGPointMake(lowerKnobLayer.frame.origin.x  + lowerKnobLayer.frame.size.width * 0.5, lowerKnobLayer.frame.origin.y - 14);
            rightLabel.center = CGPointMake(upperKnobLayer.frame.origin.x + upperKnobLayer.frame.size.width * 0.5, upperKnobLayer.frame.origin.y - 14);
    }else {
        if (_seclectedUpperKnob) {
            rightLabel.center = CGPointMake(leftLabel.frame.size.width + leftLabel.frame.origin.x  + leftLabel.frame.size.width * 0.5, lowerKnobLayer.frame.origin.y - 14);
        }
        if (_seclectedLowerKnob) {
            leftLabel.center = CGPointMake(rightLabel.frame.origin.x - leftLabel.frame.size.width * 0.5, upperKnobLayer.frame.origin.y - 14);
        }
    }
}

//根据滑块对应的值来计算滑块center的x的值
- (float) positionForValue:(float)value
{
    return useableTrackLength * (value - _minimumValue) /
    (_maximumValue - _minimumValue) + track_x;
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    previousTouchPoint = [touch locationInView:self];
    
    //判断是否触摸到了滑块
    if(CGRectContainsPoint(lowerKnobLayer.frame, previousTouchPoint))
    {
        _seclectedLowerKnob = YES;
        [lowerKnobLayer setNeedsDisplay];
    }
    else if(CGRectContainsPoint(upperKnobLayer.frame, previousTouchPoint))
    {

        _seclectedUpperKnob = YES;
        [upperKnobLayer setNeedsDisplay];
    }
    return _seclectedLowerKnob || _seclectedUpperKnob;
}

#define BOUND(VALUE, UPPER, LOWER)  MIN(MAX(VALUE, LOWER), UPPER)

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1. 计算用户拖动的位置
    float delta = touchPoint.x - previousTouchPoint.x;
    float valueDelta = (_maximumValue - _minimumValue) * delta / useableTrackLength;
    
    previousTouchPoint = touchPoint;
    
    // 2. 更新滑块的值
    if (_seclectedLowerKnob)
    {
        _lowerValue += valueDelta;
        _lowerValue = BOUND(_lowerValue, _upperValue, _minimumValue);
        //左边滑块距右边滑块最小间距为1
        if (_lowerValue + 1 > _upperValue) {
            _lowerValue = _upperValue -1;
        }
    }
    if (_seclectedUpperKnob)
    {
        _upperValue += valueDelta;
        _upperValue = BOUND(_upperValue, _maximumValue, _lowerValue);
        //右边滑块距左边滑块最小间距为1
        if (_lowerValue + 1 > _upperValue) {
            _upperValue = _lowerValue + 1;
        }
        
    }

    // 3. 更新UI
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    _seclectedUpperKnob = _seclectedLowerKnob = NO;
    [lowerKnobLayer setNeedsDisplay];
    [upperKnobLayer setNeedsDisplay];
}



@end
