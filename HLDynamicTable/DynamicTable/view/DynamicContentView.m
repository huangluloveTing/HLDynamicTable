//
//  DynamicContentView.m
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "DynamicContentView.h"
#import "DynamicUtils.h"
#import "DynamicLabel.h"

#define Per_Width (50)  //默认的每个label 的高度

@interface DynamicContentView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrolView;

//每一行的最高高度
@property (nonatomic , assign) CGFloat maxHeight;

//改视图所有的label
@property (nonatomic , strong) NSMutableArray *labels;

@end

@implementation DynamicContentView


- (void) awakeFromNib {
    [super awakeFromNib];
    self.scrolView.delegate = self;
    self.scrolView.showsVerticalScrollIndicator = NO;
    self.scrolView.showsHorizontalScrollIndicator = NO;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.scrolView.frame.size.width, self.maxHeight);
}


- (void) performToAddContents:(NSArray<DynamicContentObject *> *)contents {
    [self addLabelToScrolViewWithContents:contents];
    [self invalidateIntrinsicContentSize];
}


- (void) addLabelToScrolViewWithContents:(NSArray <DynamicContentObject *> *)contents {
    [self.labels removeAllObjects];
    [self removeSubViewsOnScrolView];
    [self addSubview:self.scrolView];
    int count = (int)contents.count;
    CGFloat totalWidth = 0 ;
    CGFloat maxHeight = 0;
    
    //水平间距 ， 和 垂直间距
    CGFloat padding_hori =  0;
    CGFloat padding_vert =  0;
    
    for (int i = 0 ; i < count; i ++) {
        DynamicContentObject * content = contents[i];
        NSAssert([content isKindOfClass:[DynamicContentObject class]], @"传入的数据必须是 DynamicContentObject 类型");
        
        CGFloat width = content.width != 0 ? content.width : Per_Width;
        CGFloat l_x = totalWidth; //每个label 的 x 坐标
        CGFloat l_y = padding_vert;
        
        DynamicLabel *label = [self getContentLabelWithContent:content.content
                                                       AtIndex:i];
        
        CGSize labelSize = [DynamicUtils getStringSizeWith:content.content
                                            withStringFont:label.font.pointSize
                                         withWidthOrHeight:width - 12
                                              isWidthFixed:YES];
        
        CGRect frame = CGRectMake(l_x, l_y, width , labelSize.height + 20);
        label.frame = frame;
        [self.scrolView addSubview:label];
        [self.labels addObject:label];
        totalWidth += (width + padding_hori);
        if (maxHeight <= labelSize.height + 20) {
            maxHeight = labelSize.height + 20;
        }
    }
    
    for (UILabel *label in self.labels) {
        CGRect frame =label.frame;
        frame.size.height = maxHeight;
        label.frame = frame;
    }
    
    self.maxHeight = maxHeight + 2 * padding_vert;
    CGSize contentSize = CGSizeMake(totalWidth, maxHeight);
    self.scrolView.contentSize = contentSize;
}

- (void) performContentViewOffset:(CGPoint)offset {
    self.scrolView.contentOffset = offset;
}


//获取label
- (DynamicLabel *)getContentLabelWithContent:(NSString *)content
                                     AtIndex:(NSInteger)index {
    DynamicLabel *label = [[NSBundle mainBundle] loadNibNamed:@"DynamicView" owner:nil options:nil][1];
    //字体颜色
    UIColor *titleColor = [UIColor blackColor];
    //字体font
    UIFont *font = [UIFont systemFontOfSize:16];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleColorForDynamicContentView:AtColumn:)]) {
        titleColor = [self.dataSource titleColorForDynamicContentView:self AtColumn:index] ?: titleColor;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleFontForDynamicContentView:AtColumn:)]) {
        font = [self.dataSource titleFontForDynamicContentView:self AtColumn:index] ?: font;
    }
    UIColor *bgColor = [UIColor whiteColor];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(backgroundColorForDynamicContentView:)]) {
        bgColor = [self.dataSource backgroundColorForDynamicContentView:self] ?: bgColor;
    }
    NSTextAlignment textAlignment = NSTextAlignmentCenter;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(textAlignmentForDynamicContentView:AtColumn:)]) {
        textAlignment = [self.dataSource textAlignmentForDynamicContentView:self AtColumn:index] ?: textAlignment;
    }
    label.bgColor = bgColor;
    label.textColor = titleColor;
    label.font = font;
    label.text = content;
    
    label.textAlignment = textAlignment;
    label.topLineColor = bgColor;
    label.leftLineColor = [UIColor lightGrayColor];
    label.bottomLineColor = [UIColor lightGrayColor];
    label.rightLineColor = bgColor;
    
    return label;
}

- (NSMutableArray *)labels {
    if(! _labels) {
        _labels = [NSMutableArray array];
        
        
    }
    
    return _labels;
}

- (UIScrollView *)scrolView {
    if (!_scrolView) {
        _scrolView = [[UIScrollView alloc] initWithFrame:self.bounds];
    }
    
    return _scrolView;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.scrolView.frame = self.bounds;
    [self invalidateIntrinsicContentSize];
}

- (void) removeSubViewsOnScrolView {
    NSArray *subViews = self.scrolView.subviews;
    for (UIView *sub_view in subViews) {
        if ([sub_view isKindOfClass:[DynamicLabel class]]) {
            [sub_view removeFromSuperview];
        }
    }
}

#pragma mark - UIScrolViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicContentView:Offset:)]) {
        [self.delegate dynamicContentView:self Offset:scrollView.contentOffset];
    }
}

@end

