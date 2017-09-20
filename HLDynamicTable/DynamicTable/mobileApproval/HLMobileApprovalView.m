//
//  HLMobileApprovalView.m
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

/**
 公司项目视图，可以做参考，类似的可以直接使用
 */

#import "HLMobileApprovalView.h"
#import "DynamicDefine.h"
#import "HLDynamicTableCell.h"
#import "HLDynamicTableHeader.h"
#import "HLMobileApprovalMiddleCell.h"

@interface HLMobileApprovalView ()<UITableViewDelegate , UITableViewDataSource , HLDynamicCellDelegate , HLDynamicHeaderDelegate , HLMobleAprovalMiddleDelegate>

//动态列表的header
@property (nonatomic , strong) HLDynamicTableHeader *dynamicHeader;
//固定列数的header
@property (nonatomic , strong) HLDynamicTableHeader *solidHeader;

@end

@implementation HLMobileApprovalView

- (instancetype) initWithFrame:(CGRect)frame ToTargetView:(UIView *)targetView Style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self initViewsWithTarget:targetView];
    }
    
    return self;
}


#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) {
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(dynamicCellNumberRowsForHLMobileApprovalView:)]) {
            count = [self.dynamicDataSource dynamicCellNumberRowsForHLMobileApprovalView:self];
            return count;
        }
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(solidCellNumberRowsForHLMobileApprovalView:)]) {
            count = [self.dynamicDataSource solidCellNumberRowsForHLMobileApprovalView:self];
            return count;
        }
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSInteger section = indexPath.section;
    if (section == 0) {
        HLDynamicTableCell *dynamicCell = [tableView dequeueReusableCellWithIdentifier:HLDynamic_Cell_UID];
        NSArray *datas = [NSArray array];
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(dynamicCellDataForHLMobileApprovalView:AtRow:)]) {
            datas = [self.dynamicDataSource dynamicCellDataForHLMobileApprovalView:self AtRow:indexPath.row];
        }
        [dynamicCell performContents:datas];
        dynamicCell.delegate = self;
        cell = dynamicCell;
    }
    if (section == 1) {
        HLMobileApprovalMiddleCell *middleCell = [tableView dequeueReusableCellWithIdentifier:HLMobileApprovalMiddle_UID];
        middleCell.delegate = self;
        cell = middleCell;
    }
    
    if (section == 2) {
        HLDynamicTableCell *solidCell = [tableView dequeueReusableCellWithIdentifier:HLDynamic_Cell_UID];
        NSArray *solidDatas = [NSArray array];
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(solidCellDataForHLMobileApprovalView:AtRow:)]) {
            solidDatas = [self.dynamicDataSource solidCellDataForHLMobileApprovalView:self AtRow:indexPath.row];
        }
        
        [solidCell performContents:[self configSoildCellDataForDatas:solidDatas]];
        solidCell.delegate = self;
        cell = solidCell;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *headerDatas = [NSArray array];
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(dynamicHeaderDataForHLMobileApprovalView:)]) {
            headerDatas = [self.dynamicDataSource dynamicHeaderDataForHLMobileApprovalView:self];
        }
        self.dynamicHeader = [HLDynamicTableHeader instanceWithContents:headerDatas AndDelegate:self];
        
        return self.dynamicHeader;
    }
    
    if (section == 2) {
        NSArray *headerDatas = [NSArray array];
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(dynamicHeaderDataForHLMobileApprovalView:)]) {
            headerDatas = [self.dynamicDataSource solidHeaderDataForHLMobileApprovalView:self];
        }
        self.solidHeader = [HLDynamicTableHeader instanceWithContents:[self configSoildCellDataForDatas:headerDatas] AndDelegate:nil];
        
        return self.solidHeader;
    }
    
    return [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - HLMobileApprovalCellDelegate
//点击驳回指定节点按钮
- (void) didTapBohuiNodeForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell {
    if (self.dynamicDelegate && [self.dynamicDelegate respondsToSelector:@selector(didTapBohuiNodeForApprovalView:)]) {
        [self.dynamicDelegate didTapBohuiNodeForApprovalView:self];
    }
}
//点击沟通按钮
- (void) didTapChatForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell {
    if (self.dynamicDelegate && [self.dynamicDelegate respondsToSelector:@selector(didTapChatForHLMobileApprovalMiddleCell:)]) {
        [self.dynamicDelegate didChatForApprovalView:self];
    }
}
//点击驳回发起人按钮
- (void) didTapBohuiBackForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell {
    if (self.dynamicDelegate && [self.dynamicDelegate respondsToSelector:@selector(didTapBohuiBackForApprovalView:)]) {
        [self.dynamicDelegate didTapBohuiBackForApprovalView:self];
    }
}
//点击审批通过按钮
- (void) didTapApprovalAgreeForHLMobileApprovalMiddleCell:(HLMobileApprovalMiddleCell *)cell {
    if (self.dynamicDelegate && [self.dynamicDelegate respondsToSelector:@selector(didTapApprovalAgressForApprovalView:)]) {
        [self.dynamicDelegate didTapApprovalAgressForApprovalView:self];
    }
}
//完成输入的回调
- (void) didInputForHLMobileApprovalCell:(HLMobileApprovalMiddleCell *)cell WithInputContent:(NSString *)content {
    if (self.dynamicDelegate && [self.dynamicDelegate respondsToSelector:@selector(didFinishedTextForApprovalView:WithContent:)]) {
        [self.dynamicDelegate didFinishedTextForApprovalView:self WithContent:content];
    }
}

#pragma mark - HLDynamicCellDelegate
- (void) dynamicCell:(HLDynamicTableCell *)cell Offset:(CGPoint)offset {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath.section == 0) {
        [self scrollAllVisibleCellsToOffset:offset];
        [self scrollDynamicHeaderOffset:offset];
    }
}

#pragma mark - HLDynamicCellDelegate
- (void) dynamicHeader:(HLDynamicTableHeader *)header Offset:(CGPoint)offset {
    if (header == self.dynamicHeader) {
        [self scrollAllVisibleCellsToOffset:offset];
    }
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    offset.y = 0;
    [self scrollAllVisibleCellsToOffset:offset];
    [self scrollDynamicHeaderOffset:offset];
}

#pragma mark - Private Method
- (void) registerCellForNibName:(NSString *)nibNam AndUID:(NSString *)uid {
    [self registerNib:[UINib nibWithNibName:nibNam bundle:nil] forCellReuseIdentifier:uid];
}

//配置固定列数的cell 的数据格式
- (NSArray <DynamicContentObject *>*) configSoildCellDataForDatas:(NSArray *)datas  {
    NSMutableArray *soildData = [NSMutableArray array];
    for (NSString *content in datas) {
        DynamicContentObject *object = [[DynamicContentObject alloc] init];
        NSInteger index = [datas indexOfObject:content];
        CGFloat width = CGRectGetWidth(self.frame) / 4;
        if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(solidWidthForHLMobileApprovalView:AtColumn:)]) {
            width = [self.dynamicDataSource solidWidthForHLMobileApprovalView:self AtColumn:index];
        }
        object.content = content;
        object.width = width;
        [soildData addObject:object];
    }
    
    return soildData;
}

//移动所有可见的cell
- (void) scrollAllVisibleCellsToOffset:(CGPoint)offset {
    NSArray *cells = [self visibleCells];
    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[HLDynamicTableCell class]]) {
            [self scrollCell:(HLDynamicTableCell *)cell Offset:offset];
        }
    }
}

//动态header 的偏移量
- (void) scrollDynamicHeaderOffset:(CGPoint)offset {
    [self.dynamicHeader performContentOffset:offset];
}


- (void) scrollCell:(HLDynamicTableCell *)cell Offset:(CGPoint)offset {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if ([cell isKindOfClass:[HLDynamicTableCell class]] && indexPath.section == 0) {
        [cell performContentOffset:offset];
    }
}

- (void) initViewsWithTarget:(UIView *)target {
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.estimatedRowHeight = 44;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedSectionHeaderHeight = 2;
    self.sectionHeaderHeight = UITableViewAutomaticDimension;
    [self registerCellForNibName:@"HLDynamicTableCell" AndUID:HLDynamic_Cell_UID];
    [self registerCellForNibName:@"HLMobileApprovalMiddleCell" AndUID:HLMobileApprovalMiddle_UID];
    self.delegate = self;
    self.dataSource = self;
    self.frame = target.bounds;
    [target addSubview:self];
}

@end
