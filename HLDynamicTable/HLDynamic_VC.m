//
//  HLDynamic_VC.m
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLDynamic_VC.h"
#import "HLDynamicTableView.h"

@interface HLDynamic_VC ()<HLDynamicTableViewDelegate , HLDynamicTableViewDataSource>

@property (nonatomic , strong) HLDynamicTableView *dynamicTableView;

@end

@implementation HLDynamic_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dynamicTableView = [[HLDynamicTableView alloc] initWithFrame:self.view.bounds ToTargetView:self.view Style:UITableViewStylePlain];
    
    self.dynamicTableView.dynamicDataSource = self;
    self.dynamicTableView.dynamicDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
- (NSInteger) numbersectionsForDynamicTableView:(HLDynamicTableView *)dynamicTableView {
    return 2;
}

- (NSInteger) numberRowsForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtSection:(NSInteger) section {
    return 3;
}

- (NSArray<DynamicContentObject *> *) perRowsDataForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object= [[DynamicContentObject alloc] init];
        if (i % 3 == 0) {
            object.content = [NSString stringWithFormat:@"content_sfhajhfakjfakjhfajkgfajkgfkjagfjkagfjafsfhskjfh%d" , i];
        }
        if (i % 3 == 1) {
            object.content = [NSString stringWithFormat:@"content_jkagfjafsfhskjfh%d" , i];
        }
        if (i % 3 == 2) {
            object.content = [NSString stringWithFormat:@"content_%d" , i];
        }
        
        object.width = 100;
        [tempArr addObject:object];
    }
    
    return tempArr;
}

- (NSArray<DynamicContentObject *> *) perHeaderDataForDynamicTableView:(HLDynamicTableView *)dynamicTableView AtSection:(NSInteger)section {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object= [[DynamicContentObject alloc] init];
        object.content = [NSString stringWithFormat:@"title_%d" , i];
        object.width = 100;
        [tempArr addObject:object];
    }
    
    return tempArr;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.dynamicTableView.frame = self.view.bounds;
}

@end
