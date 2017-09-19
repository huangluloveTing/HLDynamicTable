//
//  DynamicUtils.m
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "DynamicUtils.h"

@implementation DynamicUtils

+ (CGSize)getStringSizeWith:(NSString *)goalString withStringFont:(CGFloat)font withWidthOrHeight:(CGFloat)fixedSize isWidthFixed:(BOOL)isWidth{
    
    CGSize   sizeC ;
    
    if (isWidth) {
        sizeC = CGSizeMake(fixedSize ,MAXFLOAT);
    }else{
        sizeC = CGSizeMake(MAXFLOAT ,fixedSize);
    }
    
    CGSize   sizeFileName = [goalString boundingRectWithSize:sizeC
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                                     context:nil].size;
    
    return sizeFileName;
}

@end
