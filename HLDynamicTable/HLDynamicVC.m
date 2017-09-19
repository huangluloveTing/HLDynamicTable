//
//  HLDynamicVC.m
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLDynamicVC.h"

#import "HLDynamicTableCell.h"
#import "HLDynamicTableHeader.h"

#import "HLDynamic_VC.h"

@interface HLDynamicVC ()<UITableViewDataSource , UITableViewDelegate, HLDynamicCellDelegate , UIScrollViewDelegate , HLDynamicHeaderDelegate>

@property (nonatomic , assign) CGPoint offset;

//存储tableView 中section 对应 的 offset
@property (nonatomic , strong) NSMutableDictionary *offsetsDic;

@property (nonatomic , strong) NSMutableDictionary *headerDic;

@end

@implementation HLDynamicVC


#pragma mark - Public Method
- (void) registerCellForNibName:(NSString *)nibNam AndUID:(NSString *)uid {
    [self.tableView registerNib:[UINib nibWithNibName:nibNam bundle:nil] forCellReuseIdentifier:uid];
}

#pragma mark - 待重写的方法
- (UITableViewCell *) addDynamicTableViewCellAtIndexPath:(NSIndexPath *)indexPath {
    //TODO
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void) rightButton:(UIBarButtonItem *)item {
    HLDynamic_VC *vc = [[HLDynamic_VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//TODO :
- (NSArray <DynamicContentObject *> *)getContentsAtSection:(NSInteger)section {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object = [[DynamicContentObject alloc] init];
        object.content = [NSString stringWithFormat:@"这是sfajfkajkfhkahflakjhfaklhl内容，%d" , i];
        object.width = 100;
        [tempArr addObject:object];
    }
    
    return tempArr;
}

//TODO :
- (NSArray <DynamicContentObject *> *)getHeadersAtSection:(NSInteger)section {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object = [[DynamicContentObject alloc] init];
        object.content = [NSString stringWithFormat:@" title%d " , i];
        object.width = 100;
        [tempArr addObject:object];
    }
    
    return tempArr;
}

- (void) configViews {
    [self.view addSubview:self.tableView];
    self.offsetsDic = [NSMutableDictionary dictionary];
    self.headerDic = [NSMutableDictionary dictionary];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 44;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerCellForNibName:@"HLDynamicTableCell" AndUID:HLDynamic_Cell_UID];
}


#pragma mark - TableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
    }
    HLDynamicTableHeader *header = [HLDynamicTableHeader instanceWithContents:[self getHeadersAtSection:section]
                                                                  AndDelegate:self];
    header.section = section;
    [self.headerDic setValue:header
                      forKey:[self getStringFromIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
    return header;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [self addDynamicTableViewCellAtIndexPath:indexPath];
    HLDynamicTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:HLDynamic_Cell_UID];
    [cell performContents:[self getContentsAtSection:indexPath.section]];
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
    
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    //根据section 保存 offset
    [self.offsetsDic setValue:NSStringFromCGPoint(offset) forKey:[self getStringFromIndexPath:index]];
    
    [self scrollAllVisibleCells];
    [self scrollAllVisibleHeaders];
}

//根据cell 获取 indexPath
- (NSIndexPath *) getIndexPathForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    return indexPath;
}

//移动所有可见的cell
- (void) scrollAllVisibleCells{
    NSArray *cells = [self.tableView visibleCells];
    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[HLDynamicTableCell class]]) {
            [self scrollCell:(HLDynamicTableCell *)cell];
        }
    }
}
//移动所有 header
- (void) scrollAllVisibleHeaders {
    NSInteger sectionCount = [self.tableView numberOfSections];
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

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
