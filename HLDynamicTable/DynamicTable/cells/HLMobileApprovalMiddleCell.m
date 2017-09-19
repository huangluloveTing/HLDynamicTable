//
//  HLMobileApprovalMiddleCell.m
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLMobileApprovalMiddleCell.h"
#import "FSTextView.h"
#import "DynamicDefine.h"


@interface HLMobileApprovalMiddleCell ()
//输入框
@property (weak, nonatomic) IBOutlet FSTextView *textView;
//驳回指定节点按钮
@property (weak, nonatomic) IBOutlet UIButton *bohuiBtn;
//沟通按钮
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;

//审批通过按钮
@property (weak, nonatomic) IBOutlet UIButton *approvalAgreeBtn;
//驳回发起人按钮
@property (weak, nonatomic) IBOutlet UIButton *bohuiBackBtn;

@end

@implementation HLMobileApprovalMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configViewsAllView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


//配置页面
- (void) configViewsAllView {
    self.textView.layer.masksToBounds = YES;
    self.textView.borderColor = CustomerColor(121, 121, 121);
    self.textView.borderWidth = 1;
    self.textView.cornerRadius = 1;
    self.textView.placeholder = @"请填写审批意见...";
    self.textView.placeholderColor = CustomerColor(121, 121, 121);
    
    self.bohuiBtn.layer.masksToBounds = YES;
    self.bohuiBtn.layer.cornerRadius = 2;
    
    self.chatBtn.layer.masksToBounds = YES;
    self.chatBtn.layer.cornerRadius = 2;
    
    self.approvalAgreeBtn.layer.masksToBounds = YES;
    self.approvalAgreeBtn.layer.cornerRadius = 2;
    
    self.bohuiBackBtn.layer.masksToBounds = YES;
    self.bohuiBackBtn.layer.cornerRadius = 2;
    
    [self.textView addTextDidChangeHandler:^(FSTextView *textView) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didInputForHLMobileApprovalCell:WithInputContent:)]) {
            [self.delegate didInputForHLMobileApprovalCell:self WithInputContent:textView.text];
        }
    }];
    
}
//驳回指定节点
- (IBAction)bohuiNodeAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapBohuiNodeForHLMobileApprovalMiddleCell:)]) {
        [self.delegate didTapBohuiNodeForHLMobileApprovalMiddleCell:self];
    }
}
//沟通
- (IBAction)chatAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapChatForHLMobileApprovalMiddleCell:)]) {
        [self.delegate didTapChatForHLMobileApprovalMiddleCell:self];
    }
}
//驳回发起人
- (IBAction)bohuiBackAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapBohuiBackForHLMobileApprovalMiddleCell:)]) {
        [self.delegate didTapBohuiBackForHLMobileApprovalMiddleCell:self];
    }
}
//审批通过
- (IBAction)approvalAgreeAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapApprovalAgreeForHLMobileApprovalMiddleCell:)]) {
        [self.delegate didTapApprovalAgreeForHLMobileApprovalMiddleCell:self];
    }
}

@end
