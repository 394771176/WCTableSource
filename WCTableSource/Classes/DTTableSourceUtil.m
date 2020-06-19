//
//  DTTableSourceUtil.m
//  SourcesTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import "DTTableSourceUtil.h"

@implementation DTTableSourceUtil

@end

@implementation DTTableRow (Util)

+ (DTTableRow * (^)(void))row
{
    return ^(){
        return [self new];
    };
}

- (DTTableRow * (^)(NSString *cellId))withReuseCellId
{
    return ^(NSString *cellId) {
        self.reuseCellId = cellId;
        return self;
    };
}

- (DTTableRow * (^)(id data))withData
{
    return ^(id data) {
        self.data = data;
        return self;
    };
}

- (DTTableRow * (^)(NSInteger acttionType))withActionType
{
    return ^(NSInteger acttionType) {
        self.actionType = acttionType;
        return self;
    };
}

- (DTTableRow * (^)(id userInfo))withUserInfo
{
    return ^(id userInfo) {
        self.userInfo = userInfo;
        return self;
    };
}

- (DTTableRow * (^)(UITableViewCell *cell))withCell
{
    return ^(UITableViewCell * cell) {
        self.cell = cell;
        return self;
    };
}

- (DTTableRow * (^)(Class cla))withCellClass
{
    return ^(Class cla) {
        self.cellClass = cla;
        return self;
    };
}

- (DTTableRow * (^)(CellItem cellBlock))withCellBlock
{
    return ^(CellItem cellBlock) {
        self.cellBlock = cellBlock;
        return self;
    };
}

- (DTTableRow * (^)(CGFloat height))withHeight
{
    return ^(CGFloat height) {
        self.height = height;
        return self;
    };
}

- (DTTableRow * (^)(CellHeight heightBlock))withHeightBlock
{
    return ^(CellHeight heightBlock) {
        self.heightBlock = heightBlock;
        return self;
    };
}

- (DTTableRow * (^)(CellConfig initBlock))withInitBlock
{
    return ^(CellConfig initBlock) {
        self.initBlock = initBlock;
        return self;
    };
}

- (DTTableRow * (^)(CellConfig configBlock))withConfigBlock
{
    return ^(CellConfig configBlock) {
        self.configBlock = configBlock;
        return self;
    };
}

- (DTTableRow * (^)(CellClick clickBlock))withClickBlock
{
    return ^(CellClick clickBlock) {
        self.clickBlock = clickBlock;
        return self;
    };
}

- (DTTableSection * (^)(DTTableSection *sectionItem))addToSection;
{
    return ^(DTTableSection *sectionItem){
        [sectionItem addRow:self];
        return sectionItem;
    };
}

- (DTTableSection * (^)(DTTableSection *sectionItem, NSInteger index))insertToSection
{
    return ^(DTTableSection *sectionItem, NSInteger index){
        [sectionItem insertRow:self withIndex:index];
        return sectionItem;
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToLastSection
{
    return ^(DTTableSourceData *sourceItem){
        return [sourceItem addToLastSectionWithRow:self];
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToNewSection
{
    return ^(DTTableSourceData *sourceItem){
        return [sourceItem addToNewSectionWithRow:self];
    };
}

@end


@implementation DTTableRowGroup (Util)

+ (DTTableRowGroup * (^)(void))group
{
    return ^(){
        return [self new];
    };
}

- (DTTableRowGroup * (^)(NSArray *dataList))withDataList
{
    return ^(NSArray *dataList) {
        self.dataList = dataList;
        return self;
    };
}

- (DTTableRowGroup * (^)(NSArray *cellList))withCellList
{
    return ^(NSArray *cellList) {
        self.cellList = cellList;
        return self;
    };
}
- (DTTableRowGroup * (^)(NSArray *heightList))withHeightList
{
    return ^(NSArray *heightList) {
        self.heightList = heightList;
        return self;
    };
}

- (DTTableSection * (^)(DTTableSection *sectionItem))addToSection;
{
    return ^(DTTableSection *sectionItem){
        [sectionItem addRowGroup:self];
        return sectionItem;
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToLastSection
{
    return ^(DTTableSourceData *sourceItem){
        [sourceItem.lastSection addRowGroup:self];
        return [sourceItem lastSection];
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToNewSection
{
    return ^(DTTableSourceData *sourceItem){
        DTTableSection *section = [DTTableSection new];
        [section addRowGroup:self];
        [sourceItem addSection:section];
        return section;
    };
}

@end

@implementation DTTableSection (Util)

+ (DTTableSection * (^)(void))section
{
    return ^(){
        return [self new];
    };
}

- (DTTableSection * (^)(SectionRowCount countBlock))withCountBlock
{
    return ^(SectionRowCount countBlock) {
        self.countBlock = countBlock;
        return self;
    };
}

- (DTTableSection * (^)(CGFloat height))withHeaderHeight
{
    return ^(CGFloat height) {
        self.headerHeight = height;
        return self;
    };
}

- (DTTableSection * (^)(CGFloat height))withFooterHeight
{
    return ^(CGFloat height) {
        self.footerHeight = height;
        return self;
    };
}

- (DTTableSection * (^)(SectionHeaderFooter headerBlock))withHeaderBlock
{
    return ^(SectionHeaderFooter headerBlock) {
        self.headerBlock = headerBlock;
        return self;
    };
}

- (DTTableSection * (^)(SectionHeaderFooter footerBlock))withFooterBlock
{
    return ^(SectionHeaderFooter footerBlock) {
        self.footerBlock = footerBlock;
        return self;
    };
}

- (DTTableSection * (^)(DTTableRow *row))withAddRow
{
    return ^(DTTableRow *row) {
        [self addRow:row];
        return self;
    };
}

- (DTTableSection * (^)(NSArray<DTTableRow *> *rowList))withAddRowList
{
    return ^(NSArray<DTTableRow *> *rowList) {
        [self addRowList:rowList];
        return self;
    };
}

- (DTTableSection * (^)(DTTableRow *row, NSInteger index))withInsertRow
{
    return ^(DTTableRow *row, NSInteger index) {
        [self insertRow:row withIndex:index];
        return self;
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToSource
{
    return ^(DTTableSourceData *sourceItem){
        [sourceItem addSection:self];
        return self;
    };
}

- (DTTableSection * (^)(DTTableSourceData *sourceItem, NSInteger index))insertToSource
{
    return ^(DTTableSourceData *sourceItem, NSInteger index){
        [sourceItem insertSection:self toIndex:index];
        return self;
    };
}

@end

@implementation DTTableSourceData (Util)

@end

