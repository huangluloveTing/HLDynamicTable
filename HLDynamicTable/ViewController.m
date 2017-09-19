//
//  ViewController.m
//  HLDynamicTable
//
//  Created by 黄露 on 2017/9/19.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "ViewController.h"
#import "HLDynamicVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(id)sender {
    HLDynamicVC *vc = [[HLDynamicVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
