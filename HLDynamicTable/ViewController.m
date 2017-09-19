//
//  ViewController.m
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "ViewController.h"
#import "HLDynamicVC.h"
#import "HLMobileApprovalView.h"

@interface ViewController ()<HLMobileApprovalViewDelegate , HLMobileApprovalViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *targetView;

@property (nonatomic , strong) HLMobileApprovalView *approvalView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.approvalView = [[HLMobileApprovalView alloc] initWithFrame:self.targetView.bounds ToTargetView:self.targetView Style:UITableViewStylePlain];
    
    self.approvalView.dynamicDelegate = self;
    self.approvalView.dynamicDataSource = self;
}


//动态列表的个数
- (NSInteger) dynamicCellNumberRowsForHLMobileApprovalView:(HLMobileApprovalView*)approvalView {
    return 20;
}
//固定列表的个数
- (NSInteger) solidCellNumberRowsForHLMobileApprovalView:(HLMobileApprovalView*)approvalView {
    return 10;
}

//动态列数的数据源， 即 可以左右滑动的视图的数据源 -----> cell
- (NSArray<DynamicContentObject *> *) dynamicCellDataForHLMobileApprovalView:(HLMobileApprovalView*)approvalView AtRow:(NSInteger)row {
    NSMutableArray *tempArrr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object = [[DynamicContentObject alloc] init];
        object.content = @"sfalfhalfhaklhfalhfkajhfaklhflkafakflahf";
        object.width = i % 10 * 5 + 80;
        [tempArrr addObject:object];
    }
    
    return tempArrr;
}
//动态列数的数据源， 即 可以左右滑动的视图的数据源 ---- > header
- (NSArray<DynamicContentObject *> *) dynamicHeaderDataForHLMobileApprovalView:(HLMobileApprovalView*)approvalView {
    NSMutableArray *tempArrr = [NSMutableArray array];
    for (int i = 0 ; i < 10; i ++) {
        DynamicContentObject *object = [[DynamicContentObject alloc] init];
        object.content = @"title";
        object.width = i % 10 * 5 + 80;
        [tempArrr addObject:object];
    }
    
    return tempArrr;
}

//固定列数的数据源，即 不能左右滑动的视图的数据源 ----- > cell
- (NSArray<NSString *> *) solidCellDataForHLMobileApprovalView:(HLMobileApprovalView *)approvalView AtRow:(NSInteger)row {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 4; i ++ ) {
        NSString *content = @"afkhafhalkfhalkfhahfalhfalkhfkl";
        [tempArr addObject:content];
    }
    
    return tempArr;
}
//固定列数的数据源，即 不能左右滑动的视图的数据源  ---- > header
- (NSArray<NSString *> *) solidHeaderDataForHLMobileApprovalView:(HLMobileApprovalView *)approvalView {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0 ; i < 4; i ++ ) {
        NSString *content = @"内容";
        [tempArr addObject:content];
    }
    
    return tempArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnAction:(id)sender {
    
    
    HLDynamicVC *vc = [[HLDynamicVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
