//
//  DynamicContentView.h
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentObject.h"


@class DynamicContentView;
@protocol DynamicContentViewDelegate <NSObject>

- (void) dynamicContentView:(DynamicContentView *)dynamicView Offset:(CGPoint)offset;

@end

@protocol DynamicContentViewDataSource <NSObject>

@optional
//在动态视图里面，第column 列的字体颜色
- (UIColor *) titleColorForDynamicContentView:(DynamicContentView*)dynamicContentView AtColumn:(NSInteger)column;
//在动态视图里面，第column 列的字体font
- (UIFont *) titleFontForDynamicContentView:(DynamicContentView *)dynamicContentView AtColumn:(NSInteger)column;
//动态视图里面 ， 第 column 列的展示testAlignment
- (NSTextAlignment) textAlignmentForDynamicContentView:(DynamicContentView *)dynamicContentView AtColumn:(NSInteger)column;
//背景颜色
- (UIColor *) backgroundColorForDynamicContentView:(DynamicContentView *)dynamicContentView;

@end

@interface DynamicContentView : UIView

@property (nonatomic , assign) id<DynamicContentViewDataSource> dataSource;

@property (nonatomic , assign) id<DynamicContentViewDelegate> delegate;

- (void) performToAddContents:(NSArray<DynamicContentObject *> *)contents;

- (void) performContentViewOffset:(CGPoint)offset;

@end
