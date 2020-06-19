//
//  DTTableSection.h
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTTableRow.h"
#import "DTTableRowGroup.h"

typedef NSInteger (^SectionRowCount)(NSInteger section);
typedef UIView * (^SectionHeaderFooter)(NSInteger section);

@interface DTTableSection : NSObject<UITableViewDelegate, UITableViewDataSource>

//row列表
@property (nonatomic, strong) NSMutableArray<DTTableRow *> *rowList;

//默认count = rowlist.count,但是有时可能有其他条件，需要自定义count， 但count 不得超过rowList.count
@property (nonatomic, strong) SectionRowCount countBlock;

// section header height
@property (nonatomic, assign) CGFloat headerHeight;
// section footer height
@property (nonatomic, assign) CGFloat footerHeight;

// section header view
@property (nonatomic, strong) SectionHeaderFooter headerBlock;
// section footer view
@property (nonatomic, strong) SectionHeaderFooter footerBlock;

- (DTTableRow *)lastRow;
- (DTTableRow *)rowForIndex:(NSInteger)index;
- (DTTableRow *)rowForIndexPath:(NSIndexPath *)indexPath;

//添加单个row
- (void)addRow:(DTTableRow *)row;
- (void)addRowGroup:(DTTableRowGroup *)group;

//添加单个row列表，多条
- (void)addRowList:(NSArray<DTTableRow *> *)rowList;

//如果index大于rowlist.count, 则插在末尾
- (void)insertRow:(DTTableRow *)row withIndex:(NSInteger)index;

@end
