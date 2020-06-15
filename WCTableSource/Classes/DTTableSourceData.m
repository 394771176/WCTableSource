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

- (DTTableSection *)addToLastSectionWithRowGroup:(DTTableRowGroup *)rowGroup
{
    DTTableSection *section = [self lastSection];
    [section addRowGroup:rowGroup];
    return section;
}

- (DTTableSection *)addToNewSectionWithRowGroup:(DTTableRowGroup *)rowGroup
{
    DTTableSection *section = [DTTableSection new];
    [section addRowGroup:rowGroup];
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
        NSInteger count = self.countBlock(tableView);
        return MIN(count, self.dataSource.count);
    } else {
        return self.dataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DTTableSection *sectionItem = [self sectionForIndex:section];
    return [sectionItem tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableSection *sectionItem = [self sectionForIndex:indexPath.section];
    return [sectionItem tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableSection *sectionItem = [self sectionForIndex:indexPath.section];
    return [sectionItem tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableSection *sectionItem = [self sectionForIndex:indexPath.section];
    return [sectionItem tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    DTTableSection *sectionItem = [self sectionForIndex:section];
    return [sectionItem tableView:tableView heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DTTableSection *sectionItem = [self sectionForIndex:section];
    return [sectionItem tableView:tableView viewForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    DTTableSection *sectionItem = [self sectionForIndex:section];
    return [sectionItem tableView:tableView heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    DTTableSection *sectionItem = [self sectionForIndex:section];
    return [sectionItem tableView:tableView viewForFooterInSection:section];
}

@end
