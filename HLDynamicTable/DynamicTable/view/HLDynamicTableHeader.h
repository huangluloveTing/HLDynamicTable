//
//  HLDynamicTableHeader.h
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentObject.h"

@class HLDynamicTableHeader;
@protocol HLDynamicHeaderDelegate <NSObject>

@optional
- (void) dynamicHeader:(HLDynamicTableHeader *)header Offset:(CGPoint)offset;

@end

@interface HLDynamicTableHeader : UIView

+ (instancetype) instanceWithContents:(NSArray<DynamicContentObject *>*)contents
                          AndDelegate:(id<HLDynamicHeaderDelegate>)delegate;

@property (nonatomic , assign) id<HLDynamicHeaderDelegate> delegate;
//header 所在的 section
@property (nonatomic , assign) NSInteger section;

//手动调整scrollView 的偏移量
- (void) performContentOffset:(CGPoint)offset;


@end
