//
//  HLDynamicTableHeader.m
//  DynamicDemo
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "HLDynamicTableHeader.h"
#import "DynamicContentView.h"

@interface HLDynamicTableHeader ()<DynamicContentViewDelegate , DynamicContentViewDataSource>
@property (weak, nonatomic) IBOutlet DynamicContentView *dynamicView;

@end

@implementation HLDynamicTableHeader

+ (instancetype) instanceWithContents:(NSArray<DynamicContentObject *> *)contents
                          AndDelegate:(id<HLDynamicHeaderDelegate>)delegate {
    HLDynamicTableHeader *header = [[NSBundle mainBundle] loadNibNamed:@"DynamicView" owner:nil options:nil][2];
    [header performContents:contents];
    header.delegate = delegate;
    return header;
}

- (void) performContents:(NSArray<DynamicContentObject *> *)contents {
    self.dynamicView.delegate = self;
    self.dynamicView.dataSource= self;
    [self.dynamicView performToAddContents:contents];
}

#pragma mark - Delegate
- (void) dynamicContentView:(DynamicContentView *)dynamicView Offset:(CGPoint)offset {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicHeader:Offset:)]) {
        [self.delegate dynamicHeader:self Offset:offset];
    }
}


#pragma mark - DataSource
- (UIColor *) backgroundColorForDynamicContentView:(DynamicContentView *)dynamicContentView {
    return [UIColor darkGrayColor];
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void) performContentOffset:(CGPoint)offset {
    [self.dynamicView performContentViewOffset:offset];
}


@end
