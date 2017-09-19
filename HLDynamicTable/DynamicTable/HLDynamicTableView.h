//
//  HLDynamicTableView.h
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentObject.h"

@class HLDynamicTableView;
@protocol HLDynamicTableViewDataSource <NSObject>

- (NSInteger) numbersectionsForDynamicTableView:(HLDynamicTableView *)dynamicTableView;

- (NSInteger) numberRowsForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtSection:(NSInteger) section;

- (NSArray<DynamicContentObject *> *) perRowsDataForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<DynamicContentObject *> *) perHeaderDataForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtSection:(NSInteger)section;

@end

@protocol HLDynamicTableViewDelegate <NSObject>

@optional
- (void) dynamicTableView:(HLDynamicTableView *)dynamicTableView didSelectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface HLDynamicTableView : UITableView

@property (nonatomic , assign) id<HLDynamicTableViewDelegate> dynamicDelegate;

@property (nonatomic , assign) id<HLDynamicTableViewDataSource> dynamicDataSource;

- (instancetype) initWithFrame:(CGRect)frame ToTargetView:(UIView *)targetView Style:(UITableViewStyle)style;

@end
