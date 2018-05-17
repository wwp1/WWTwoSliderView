//
//  ViewController.m
//  WWTwoSliderView
//
//  Created by 王万鹏 on 2018/5/15.
//  Copyright © 2018年 王万鹏. All rights reserved.
//

#import "ViewController.h"
#import "WWSliderView.h"

@interface ViewController ()

@property(nonatomic, strong)WWSliderView *rangeSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect sliderFrame = CGRectMake(0, 200, self.view.frame.size.width, 160);
    UIColor *color1 = [UIColor lightGrayColor];
    UIColor *color2 = [UIColor colorWithRed:22/255.0 green:145/255.0 blue:153/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:22/255.0 green:145/255.0 blue:153/255.0 alpha:0.5];
    UIColor *color4 = [UIColor colorWithRed:244/255.0 green:77/255.0 blue:84/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:244/255.0 green:77/255.0 blue:84/255.0 alpha:0.5];

    
    _rangeSlider = [[WWSliderView alloc] initWithFrame:sliderFrame
                                                         sliderColor:color1
                                                      leftSmallColor:color2
                                                        leftBigColor:color3
                                                     rightSmallColor:color4
                                                       rightBigColor:color5];
    //1.先设置最左边数值、最右边数值（0-24）
    _rangeSlider.minimumValue = 0;
    _rangeSlider.maximumValue = 24;
    //2.再设置两个滑块位置
    [_rangeSlider resetLeftValue:8.0 rightValue:16.0];

    [self.view addSubview:_rangeSlider];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 200) * 0.5, sliderFrame.origin.y + 50 + 160, 200, 50);
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitle:@"设置完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)clickedButton:(UIButton *)btn {
    NSString *leftStr = (NSInteger)_rangeSlider.lowerValue < 10 ? @"0" : @"";
    NSString *rightStr = (NSInteger)_rangeSlider.upperValue < 10 ? @"0" : @"";
    leftStr = [NSString stringWithFormat:@"%@%ld:00",leftStr,(NSInteger)_rangeSlider.lowerValue];
    rightStr = [NSString stringWithFormat:@"%@%ld:00",rightStr,(NSInteger)_rangeSlider.upperValue];
    NSLog(@"选择的时间是：%@---%@",leftStr,rightStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
