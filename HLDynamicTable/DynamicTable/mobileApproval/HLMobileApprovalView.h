//
//  HLMobileApprovalView.h
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentObject.h"

@class HLMobileApprovalView;
@protocol HLMobileApprovalViewDelegate <NSObject>

@optional
//点击cell
-(void) didTapMobileApprovalView:(HLMobileApprovalView *)approvalView AtIndexPath:(NSIndexPath *)indexPath;

//点击驳回审批
-(void) didTapBohuiNodeForApprovalView:(HLMobileApprovalView *)approvalView;

//点击沟通
-(void) didChatForApprovalView:(HLMobileApprovalView *)approvalView;

//点击驳回发起人
-(void) didTapBohuiBackForApprovalView:(HLMobileApprovalView *)approvalView;

//点击审批通过
-(void) didTapApprovalAgressForApprovalView:(HLMobileApprovalView *)approvalView;

//完成输入框的操作
-(void) didFinishedTextForApprovalView:(HLMobileApprovalView *)approvalView WithContent:(NSString *)content;

@end

@protocol HLMobileApprovalViewDataSource <NSObject>
//动态列表的个数
- (NSInteger) dynamicCellNumberRowsForHLMobileApprovalView:(HLMobileApprovalView*)approvalView;
//固定列表的个数
- (NSInteger) solidCellNumberRowsForHLMobileApprovalView:(HLMobileApprovalView*)approvalView;

//动态列数的数据源， 即 可以左右滑动的视图的数据源 -----> cell
- (NSArray<DynamicContentObject *> *) dynamicCellDataForHLMobileApprovalView:(HLMobileApprovalView*)approvalView AtRow:(NSInteger)row;
//动态列数的数据源， 即 可以左右滑动的视图的数据源 ---- > header
- (NSArray<DynamicContentObject *> *) dynamicHeaderDataForHLMobileApprovalView:(HLMobileApprovalView*)approvalView;

//固定列数的数据源，即 不能左右滑动的视图的数据源 ----- > cell
- (NSArray<NSString *> *) solidCellDataForHLMobileApprovalView:(HLMobileApprovalView *)approvalView AtRow:(NSInteger)row;
//固定列数的数据源，即 不能左右滑动的视图的数据源  ---- > header
- (NSArray<NSString *> *) solidHeaderDataForHLMobileApprovalView:(HLMobileApprovalView *)approvalView;

@optional
//固定列数的cell 的每个 item 的宽度， 可选， 不实现，就默认等宽
- (CGFloat) solidWidthForHLMobileApprovalView:(HLMobileApprovalView *)approvalView AtColumn:(NSInteger)column;

@end

@interface HLMobileApprovalView : UITableView

@property (nonatomic , assign) id<HLMobileApprovalViewDelegate> dynamicDelegate;

@property (nonatomic , assign) id<HLMobileApprovalViewDataSource> dynamicDataSource;

- (instancetype) initWithFrame:(CGRect)frame ToTargetView:(UIView *)targetView Style:(UITableViewStyle)style;

@end
