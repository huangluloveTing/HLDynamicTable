//
//  HLDynamicTableCell.m
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLDynamicTableCell.h"


@interface HLDynamicTableCell ()<DynamicContentViewDataSource , DynamicContentViewDelegate>

@property (weak, nonatomic) IBOutlet DynamicContentView *dynamicView;

@end

@implementation HLDynamicTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dynamicView.dataSource = self;
    self.dynamicView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void) performContents:(NSArray<DynamicContentObject *> *)contents {
    [self.dynamicView performToAddContents:contents];
}

#pragma mark - Delegate
- (void) dynamicContentView:(DynamicContentView *)dynamicView Offset:(CGPoint)offset {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicCell:Offset:)]) {
        [self.delegate dynamicCell:self Offset:offset];
    }
}

#pragma mark - DataSource
- (UIColor *)backgroundColorForDynamicContentView:(DynamicContentView *)dynamicContentView {
    return [UIColor whiteColor];
}

- (UIFont *) titleFontForDynamicContentView:(DynamicContentView *)dynamicContentView AtColumn:(NSInteger)column {
    return [UIFont systemFontOfSize:14];
}

- (void) performContentOffset:(CGPoint)offset {
    [self.dynamicView performContentViewOffset:offset];
}

@end
