//
//  DTTableRowGroup.m
//  WCTableSource
//
//  Created by cheng on 2020/6/13.
//

#import "DTTableRowGroup.h"

@implementation DTTableRowGroup

- (DTTableRow *)getRowWithIndex:(NSInteger)index
{
    DTTableRow *row = [DTTableRow new];
    row.reuseCellId = self.reuseCellId;
    row.cellClass = self.cellClass;
    row.cellBlock = self.cellBlock;
    row.isXibCell = self.isXibCell;
    row.actionType = self.actionType;
    row.userInfo = self.userInfo;
    row.heightBlock = self.heightBlock;
    row.initBlock = self.initBlock;
    row.configBlock = self.configBlock;
    row.clickBlock = self.clickBlock;
    row.dataMethod = self.dataMethod;
    row.autoSetItem = self.autoSetItem;
    
    row.cell = [self cellWithIndex:index];
    row.data = [self dataWithIndex:index];
    row.height = [self heightWithIndex:index];
    return self;
}

- (UITableViewCell *)cellWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.cellList.count) {
        return [self.cellList objectAtIndex:index];
    } else {
        return self.cell;
    }
}

- (id)dataWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.dataList.count) {
        return [self.dataList objectAtIndex:index];
    } else {
        return self.data;
    }
}

- (CGFloat)heightWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.heightList.count) {
        return [[self.heightList objectAtIndex:index] floatValue];
    } else {
        return self.height;
    }
}

- (NSArray<DTTableRow *> *)rowList
{
    if (self.dataList.count || self.cellList.count) {
        NSMutableArray *array = [NSMutableArray array];
        NSInteger count = MAX(self.dataList.count, self.cellList.count);
        for (int i=0; i<count; i++) {
            [array addObject:[self getRowWithIndex:i]];
        }
        return array;
    } else {
        return nil;
    }
}

@end
