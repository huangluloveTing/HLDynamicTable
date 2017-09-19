//
//  DynamicLabel.m
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "DynamicLabel.h"

@interface DynamicLabel ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLine;
@property (weak, nonatomic) IBOutlet UILabel *leftLine;
@property (weak, nonatomic) IBOutlet UILabel *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *rightLine;

@end

@implementation DynamicLabel

- (void) setText:(NSString *)text {
    _text = text;
    self.contentLabel.text = text;
}

- (void) setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.contentLabel.textColor = textColor;
}

- (void) setTopLineColor:(UIColor *)topLineColor {
    _topLineColor = topLineColor;
    self.topLine.backgroundColor = topLineColor;
}

- (void) setLeftLineColor:(UIColor *)leftLineColor {
    _leftLineColor = leftLineColor;
    self.leftLine.backgroundColor = leftLineColor;
}

- (void) setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}

- (void) setRightLineColor:(UIColor *)rightLineColor {
    _rightLineColor = rightLineColor;
    self.rightLine.backgroundColor = rightLineColor;
}

- (void) setFont:(UIFont *)font {
    _font = font;
    self.contentLabel.font = font;
}

- (void) setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.contentLabel.textAlignment = textAlignment;
}


- (void) setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}
@end
