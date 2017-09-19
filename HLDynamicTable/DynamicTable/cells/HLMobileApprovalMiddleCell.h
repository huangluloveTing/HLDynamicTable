//
//  HLMobileApprovalMiddleCell.h
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLMobileApprovalMiddleCell;
@protocol HLMobleAprovalMiddleDelegate <NSObject>

@optional
//点击驳回指定节点按钮
- (void) didTapBohuiNodeForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell;
//点击沟通按钮
- (void) didTapChatForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell;
//点击驳回发起人按钮
- (void) didTapBohuiBackForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell;
//点击审批通过按钮
- (void) didTapApprovalAgreeForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell;
//完成输入的回调
- (void) didInputForHLMobileApprovalCell:(HLMobileApprovalMiddleCell *)cell WithInputContent:(NSString *)content;

@end

static NSString *HLMobileApprovalMiddle_UID = @"HLMobileApprovalMiddleCell";

@interface HLMobileApprovalMiddleCell : UITableViewCell

@property (nonatomic , assign) id<HLMobleAprovalMiddleDelegate> delegate;

@end
