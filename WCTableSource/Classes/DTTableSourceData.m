//
//  DTTableSourceData.m
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import "DTTableSourceData.h"

@implementation DTTableSourceData

@synthesize dataSource = _dataSource;

- (NSMutableArray<DTTableSection *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (DTTableSection *)lastSection
{
    if (self.dataSource.count) {
        return [self.dataSource lastObject];
    } else {
        return nil;
    }
}

- (DTTableSection *)sectionForIndex:(NSInteger)index
{
    if (index >= 0 && index < self.dataSource.count) {
        return [self.dataSource objectAtIndex:index];
    } else {
        return nil;
    }
}

- (DTTableRow *)rowForIndexPath:(NSIndexPath *)indexPath
{
    DTTableSection *section = [self sectionForIndex:indexPath.section];
    if (section) {
        return [section rowForIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (DTTableSection *)addNewSection
{
    DTTableSection *section = [DTTableSection new];
    return [self addSection:section];
}

- (DTTableSection *)addSection:(DTTableSection *)section
{
    if (section) {
        [self.dataSource addObject:section];
    }
    return section;
}

- (DTTableSection *)insertSection:(DTTableSection *)section toIndex:(NSInteger)index
{
    if (section) {
        if (index >= 0 && index <= self.dataSource.count) {
            [self.dataSource insertObject:section atIndex:index];
        } else {
            [self addSection:section];
        }
    }
    return section;
}

- (DTTableSection *)addToLastSectionWithRow:(DTTableRow *)rowItem
{
    DTTableSection *section = [self lastSection];
    [section addRow:rowItem];
    return section;
}

- (DTTableSection *)addToNewSectionWithRow:(DTTableRow *)rowItem
{
    DTTableSection *section = [DTTableSection new];
    [section addRow:rowItem];
    return section;
}

- (DTTableSection *)addToLastSectionWithRowList:(NSArray<DTTableRow *> *)rowList
{
    DTTableSection *section = [self lastSection];
    [section addRowList:rowList];
    return section;
}

- (DTTableSection *)addToNewSectionWithRowList:(NSArray<DTTableRow *> *)rowList
{
    DTTableSection *section = [DTTableSection new];
    [section addRowList:rowList];
    return section;
}

// MARK: - UITableViewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.countBlock) {
        return self.countBlock(tableView);
    }
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_heightBlock) {
//        return _heightBlock(self, indexPath);
//    } else if (_height > 0) {
//        return _height;
//    } else {
//        Class cla = [self cellClassForIndexPath:indexPath];
//        if (cla && [cla respondsToSelector:@selector(cellHeightWithItem:tableView:)]) {
//            return [cla cellHeightWithItem:self.data tableView:tableView];
//        }
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self cellForIndexPath:indexPath];
//    if (!cell && _cellClass) {
//        if (!self.reuseCellId) {
//            self.reuseCellId = NSStringFromClass([self.cellClass class]);
//        }
//        cell = [tableView dequeueReusableCellWithIdentifier:self.reuseCellId];
//        if (!cell) {
//            cell = [(UITableViewCell *)[_cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseCellId];
//        }
//    }
//
//    if (cell) {
//        if (_configBlock) {
//            _configBlock(self, cell, indexPath);
//        }
//        if ([cell respondsToSelector:@selector(setItem:)]) {
//            //只是借助DTTableRow为替身，方便调setItem方法，而没有警告
//            [(DTTableRow *)cell setItem:self.data];
//        }
//        if ([cell respondsToSelector:@selector(setUserInfo:)]) {
//            [(DTTableRow *)cell setUserInfo:self.userInfo];
//        }
//    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.clickBlock) {
//        self.clickBlock(self, indexPath);
//    }
}

@end
