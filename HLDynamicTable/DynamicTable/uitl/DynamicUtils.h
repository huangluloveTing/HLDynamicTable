//
//  DynamicUtils.h
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicUtils : NSObject

#pragma mark - 根据一定高度/宽度返回宽度/高度
/**
 *  @brief  根据一定高度/宽度返回宽度/高度
 *  @category
 *  @param  goalString           目标字符串
 *  @param  font                 字号
 *  @param  fixedSize            固定的宽/高
 *  @param  isWidth              是否是宽固定(用于区别宽/高)
 **/
+ (CGSize)getStringSizeWith:(NSString *)goalString
             withStringFont:(CGFloat)font
          withWidthOrHeight:(CGFloat)fixedSize
               isWidthFixed:(BOOL)isWidth;
@end
