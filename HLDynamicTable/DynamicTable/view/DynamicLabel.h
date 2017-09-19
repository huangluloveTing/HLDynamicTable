//
//  DynamicLabel.h
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicLabel : UIView

//文字内容
@property (nonatomic , copy) NSString *text;
//文字颜色
@property (nonatomic , strong) UIColor *textColor;
//上部线条的颜色
@property (nonatomic , strong) UIColor *topLineColor;
//左边线条延伸
@property (nonatomic , strong) UIColor *leftLineColor;
//下边线条颜色
@property (nonatomic , strong) UIColor *bottomLineColor;
//右边线条颜色
@property (nonatomic , strong) UIColor *rightLineColor;
//字体font
@property (nonatomic , strong) UIFont *font;

//
@property (nonatomic , assign) NSTextAlignment textAlignment;

@property (nonatomic , strong) UIColor *bgColor;

@end
