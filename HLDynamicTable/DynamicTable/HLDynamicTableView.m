//
//  HLDynamicTableView.m
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLDynamicTableView.h"
#import "HLDynamicTableCell.h"
#import "HLDynamicTableHeader.h"

@interface HLDynamicTableView ()<UITableViewDelegate , UITableViewDataSource , HLDynamicCellDelegate , UIScrollViewDelegate , HLDynamicHeaderDelegate>

//存储tableView 中section 对应 的 offset
@property (nonatomic , strong) NSMutableDictionary *offsetsDic;

@property (nonatomic , strong) NSMutableDictionary *headerDic;

@end

@implementation HLDynamicTableView

- (instancetype) initWithFrame:(CGRect)frame ToTargetView:(UIView *)targetView Style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self configViewsWithTargetView:targetView];
    }
    
    return self;
}

#pragma mark - Public Method
- (void) registerCellForNibName:(NSString *)nibNam AndUID:(NSString *)uid {
    [self registerNib:[UINib nibWithNibName:nibNam bundle:nil] forCellReuseIdentifier:uid];
}

- (NSArray <DynamicContentObject *> *)getContentsAtSection:(NSIndexPath *)indexPath {
    if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(perRowsDataForDynamicTableView:AtIndexPath:)]) {
        return [self.dynamicDataSource perRowsDataForDynamicTableView:self AtIndexPath:indexPath];
    }
    
    return nil;
}

- (NSArray <DynamicContentObject *> *)getHeadersAtSection:(NSInteger)section {
    if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(perHeaderDataForDynamicTableView:AtSection:)]) {
        return [self.dynamicDataSource perHeaderDataForDynamicTableView:self AtSection:section];
    }
    
    return nil;
}

- (void) configViewsWithTargetView:(UIView *)targetView {
    self.offsetsDic = [NSMutableDictionary dictionary];
    self.headerDic = [NSMutableDictionary dictionary];
    self.estimatedRowHeight = 44;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedSectionHeaderHeight = 44;
    self.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerCellForNibName:@"HLDynamicTableCell" AndUID:HLDynamic_Cell_UID];
    self.delegate = self;
    self.dataSource = self;
    [targetView addSubview:self];
}


#pragma mark - TableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(numbersectionsForDynamicTableView:)]) {
        return [self.dynamicDataSource numbersectionsForDynamicTableView:self];
    }
    
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dynamicDataSource && [self.dynamicDataSource respondsToSelector:@selector(numberRowsForDynamicTableView:AtSection:)]) {
        return [self.dynamicDataSource numberRowsForDynamicTableView:self AtSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HLDynamicTableHeader *header = [HLDynamicTableHeader instanceWithContents:[self getHeadersAtSection:section]
                                                                  AndDelegate:self];
    header.section = section;
    [self.headerDic setValue:header
                      forKey:[self getStringFromIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
    return header;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLDynamicTableCell *cell = [self dequeueReusableCellWithIdentifier:HLDynamic_Cell_UID];
    [cell performContents:[self getContentsAtSection:indexPath]];
    cell.delegate = self;
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self scrollAllVisibleCells];
    [self scrollAllVisibleHeaders];
}

#pragma mark -
//cell 中scrollView 滑动时，对应的委托
- (void) dynamicHeader:(HLDynamicTableHeader *)header Offset:(CGPoint)offset {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:header.section];
    [self.offsetsDic setValue:NSStringFromCGPoint(offset) forKey:[self getStringFromIndexPath:indexPath]];
    [self scrollAllVisibleCells];
}
- (void)dynamicCell:(HLDynamicTableCell *)cell Offset:(CGPoint)offset {
    
    NSIndexPath *index = [self indexPathForCell:cell];
    //根据section 保存 offset
    [self.offsetsDic setValue:NSStringFromCGPoint(offset) forKey:[self getStringFromIndexPath:index]];
    
    [self scrollAllVisibleCells];
    [self scrollAllVisibleHeaders];
}

//根据cell 获取 indexPath
- (NSIndexPath *) getIndexPathForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    
    return indexPath;
}

//移动所有可见的cell
- (void) scrollAllVisibleCells{
    NSArray *cells = [self visibleCells];
    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[HLDynamicTableCell class]]) {
            [self scrollCell:(HLDynamicTableCell *)cell];
        }
    }
}
//移动所有 header
- (void) scrollAllVisibleHeaders {
    NSInteger sectionCount = [self numberOfSections];
    for (int i = 0 ; i < sectionCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        HLDynamicTableHeader *header = [self.headerDic valueForKey:[self getStringFromIndexPath:indexPath]];
        if (header && [header isKindOfClass:[HLDynamicTableHeader class]]) {
            CGPoint offSet = CGPointFromString([self.offsetsDic valueForKey:[self getStringFromIndexPath:indexPath]]);
            [header performContentOffset:offSet];
        }
    }
}

- (void) scrollCell:(HLDynamicTableCell *)cell {
    if ([cell isKindOfClass:[HLDynamicTableCell class]]) {
        CGPoint offset =  CGPointFromString([self.offsetsDic valueForKey:[self getStringFromIndexPath:[self getIndexPathForCell:cell]]]);
        [cell performContentOffset:offset];
    }
}

//把indexPath 转为字符串
- (NSString *) getStringFromIndexPath:(NSIndexPath *)indexPath {
    NSRange range = NSMakeRange(indexPath.section, 0);
    return NSStringFromRange(range);
}
//把indexPath 的字符串转为 indexPath 对象
- (NSIndexPath *) getIndexPathFromString:(NSString *)indexPathStr {
    NSRange range = NSRangeFromString(indexPathStr);
    return [NSIndexPath indexPathForRow:0 inSection:range.location];
}
@end
