//
//  DTTableSection.m
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import "DTTableSection.h"

@interface DTTableRow ()

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger rowIndex;

@end

@interface DTTableSection ()

@property (nonatomic, assign) NSInteger sectionIndex;

@end

@implementation DTTableSection

- (NSMutableArray<DTTableRow *> *)rowList
{
    if (!_rowList) {
        _rowList = [NSMutableArray array];
    }
    return _rowList;
}

- (DTTableRow *)lastRow
{
    if (self.rowList.count) {
        return [self.rowList lastObject];
    } else {
        return nil;
    }
}

- (DTTableRow *)rowForIndex:(NSInteger)index
{
    if (index >= 0 && index < self.rowList.count) {
        return [self.rowList objectAtIndex:index];
    } else {
        return nil;
    }
}

- (DTTableRow *)rowForIndexPath:(NSIndexPath *)indexPath
{
    return [self rowForIndex:indexPath.row];
}

//添加单个row
- (void)addRow:(DTTableRow *)row
{
    if (row) {
        [self.rowList addObject:row];
    }
}

//添加一组row
- (void)addRowGroup:(DTTableRowGroup *)group
{
    if (group) {
        [self addRowList:group.rowList];
    }
}

//添加row列表，多条
- (void)addRowList:(NSArray<DTTableRow *> *)rowList
{
    if (rowList.count) {
        [self.rowList addObjectsFromArray:rowList];
    }
}

//如果index大于rowlist.count, 则插在末尾
- (void)insertRow:(DTTableRow *)row withIndex:(NSInteger)index
{
    if (row) {
        if (index >= 0 && index < self.rowList.count) {
            [self.rowList insertObject:row atIndex:index];
        } else {
            [self addRow:row];
        }
    }
}

@end
