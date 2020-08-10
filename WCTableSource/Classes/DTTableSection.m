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

+ (DTTableSection *)section
{
    return [self new];
}

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
        if ([row isKindOfClass:DTTableRowGroup.class]) {
            [self addRowGroup:(id)row];
        } else {
            [self.rowList addObject:row];
        }
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
            if ([row isKindOfClass:DTTableRowGroup.class]) {
                NSArray<DTTableRow *> *array = [(DTTableRowGroup *)row rowList];
                [array enumerateObjectsUsingBlock:^(DTTableRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.rowList insertObject:obj atIndex:index+idx];
                }];
            } else {
                [self.rowList insertObject:row atIndex:index];
            }
        } else {
            [self addRow:row];
        }
    }
}

// MARK: - UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.countBlock) {
        NSInteger count = self.countBlock(section);
        return MIN(count, self.rowList.count);
    } else {
        return self.rowList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableRow *row = [self rowForIndexPath:indexPath];
    return [row tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableRow *row = [self rowForIndexPath:indexPath];
    return [row tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableRow *row = [self rowForIndexPath:indexPath];
    [row tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.headerHeight > 0) {
        if (self.headerBlock) {
            return self.headerBlock(section);
        } else {
            return [self.class tableView:tableView headerFooterViewWithHeight:self.headerHeight];
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.footerHeight > 0) {
        if (self.footerBlock) {
            return self.footerBlock(section);
        } else {
            return [self.class tableView:tableView headerFooterViewWithHeight:self.footerHeight];
        }
    }
    return nil;
}

+ (UIView *)tableView:(UITableView *)tableView headerFooterViewWithHeight:(CGFloat)height
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
