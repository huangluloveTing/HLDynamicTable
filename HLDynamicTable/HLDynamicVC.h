//
//  HLDynamicVC.h
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentView.h"

@interface HLDynamicVC : UIViewController

@property (strong, nonatomic) UITableView *tableView;

//重写方法，在 TableView 中添加cell
- (UITableViewCell *)addDynamicTableViewCellAtIndexPath:(NSIndexPath *)indexPath;

- (void) registerCellForNibName:(NSString *)nibNam AndUID:(NSString *)uid;

//添加动态cell 的数据
- (NSArray <DynamicContentObject *> *)getContentsAtSection:(NSInteger)section;

//添加动态cell 的 header 的数据
- (NSArray <DynamicContentObject *> *)getHeadersAtSection:(NSInteger)section;


@end
