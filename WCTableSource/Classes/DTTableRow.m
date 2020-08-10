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

+ (DTTableRow *)row
{
    return [self new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autoSetItem = YES;
    }
    return self;
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
            if (self.isXibCell) {
                [tableView registerNib:[UINib nibWithNibName:self.reuseCellId bundle:nil] forCellReuseIdentifier:self.reuseCellId];
                cell = [tableView dequeueReusableCellWithIdentifier:self.reuseCellId];
            } else {
                cell = [(UITableViewCell *)[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseCellId];
            }
            
            if (cell && self.initBlock) {
                self.initBlock(self, cell, indexPath);
            }
        }
    }
    return cell;
}

- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (cell) {
        if (self.configBlock) {
            self.configBlock(self, cell, indexPath);
        }
        
        if (self.dataMethod) {
            if ([cell respondsToSelector:self.dataMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [cell performSelector:self.dataMethod withObject:self.data];
#pragma clang diagnostic pop
            }
        } else if (self.autoSetItem && [cell respondsToSelector:@selector(setItem:)]) {
            //只是借助DTTableRow为替身，方便调setItem方法，而没有警告
            [(DTTableRow *)cell setItem:self.data];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.clickBlock(self, cell, indexPath);
    }
}

@end
