//
//  DTTableRow.m
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import "DTTableRow.h"

@interface DTTableRow () {
    
}

@property (nonatomic, strong) id item;

+ (CGFloat)cellHeightWithItem:(id)item tableView:(UITableView *)tableView;

@end

@implementation DTTableRow

+ (CGFloat)cellHeightWithItem:(id)item tableView:(UITableView *)tableView
{
    return 0;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self cellForIndexPath:indexPath];
    if (cell) {
        return cell.class;
    } else {
        return self.cellClass;
    }
}

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellBlock) {
        return self.cellBlock(self, indexPath);
    } else {
        return self.cell;
    }
}

// MARK: - UITableViewDelegate -
//只是消除警告，row 不负责该方法的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightBlock) {
        return self.heightBlock(self, indexPath);
    } else if (self.height > 0) {
        return self.height;
    } else {
        Class cla = [self cellClassForIndexPath:indexPath];
        if (cla && [cla respondsToSelector:@selector(cellHeightWithItem:tableView:)]) {
            return [cla cellHeightWithItem:self.data tableView:tableView];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self cellForIndexPath:indexPath];
    if (!cell && self.cellClass) {
        if (!self.reuseCellId) {
            self.reuseCellId = NSStringFromClass([self.cellClass class]);
        }
        cell = [tableView dequeueReusableCellWithIdentifier:self.reuseCellId];
        if (!cell) {
            cell = [(UITableViewCell *)[_cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseCellId];
            if (self.initBlock) {
                self.initBlock(self, cell, indexPath);
            }
        }
    }
    if (cell) {
        _currentCell = cell;
        _indexPath = indexPath;
    }
    return cell;
}

- (void)didConfigCell
{
    UITableViewCell *cell = _currentCell;
    NSIndexPath *indexPath = _indexPath;
    if (cell) {
        if (self.configBlock) {
            self.configBlock(self, cell, indexPath);
        }
        if ([cell respondsToSelector:@selector(setItem:)]) {
            //只是借助DTTableRow为替身，方便调setItem方法，而没有警告
            [(DTTableRow *)cell setItem:self.data];
        }
        if ([cell respondsToSelector:@selector(setUserInfo:)]) {
            [(DTTableRow *)cell setUserInfo:self.userInfo];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        self.clickBlock(self, self.currentCell, indexPath);
    }
}

@end
