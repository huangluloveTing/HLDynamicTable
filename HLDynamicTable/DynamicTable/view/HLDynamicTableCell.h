//
//  HLDynamicTableCell.h
//  LRTableView
//
//  Created by 黄露 on 2017/9/18.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicContentView.h"

@class HLDynamicTableCell;
@protocol HLDynamicCellDelegate <NSObject>

- (void) dynamicCell:(HLDynamicTableCell *)cell Offset:(CGPoint)offset;

@end


static NSString *HLDynamic_Cell_UID = @"HLDynamicTableCell__UID";

@interface HLDynamicTableCell : UITableViewCell


@property (nonatomic , assign) id<HLDynamicCellDelegate> delegate;

- (void) performContents:(NSArray<DynamicContentObject *>*)contents;

- (void) performContentOffset:(CGPoint)offset;


@end
/**
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
*/
