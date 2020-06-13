//
//  DTTableSourceUtil.h
//  SourcesTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTTableSourceData.h"
#import "DTTableSection.h"
#import "DTTableRow.h"
#import "DTTableRowGroup.h"

@interface DTTableSourceUtil : NSObject

@end

@interface DTTableRow (Util)

- (DTTableRow * (^)(NSString *cellId))withReuseCellId;

- (DTTableRow * (^)(id data))withData;
- (DTTableRow * (^)(NSInteger acttionType))withActionType;
- (DTTableRow * (^)(id userInfo))withUserInfo;

- (DTTableRow * (^)(UITableViewCell *cell))withCell;
- (DTTableRow * (^)(Class cla))withCellClass;
- (DTTableRow * (^)(CellItem cellBlock))withCellBlock;

- (DTTableRow * (^)(CGFloat height))withCellHeight;
- (DTTableRow * (^)(CellHeight heightBlock))withCellHeightBlock;

- (DTTableRow * (^)(CellConfig configBlock))withCellConfigBlock;

- (DTTableRow * (^)(CellClick clickBlock))withCellClickBlock;

- (DTTableSection * (^)(DTTableSection *sectionItem))addToSection;
- (DTTableSection * (^)(DTTableSection *sectionItem, NSInteger index))insertToSection;

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToLastSection;
- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToNewSection;

@end

@interface DTTableRowGroup (Util)

- (DTTableRowGroup * (^)(NSArray *dataList))withDataList;
- (DTTableRowGroup * (^)(NSArray *cellList))withCellList;
- (DTTableRowGroup * (^)(NSArray *heightList))withHeightList;

@end


@interface DTTableSection (Util)

//- (DTTableSection * (^)(id data))withData;
//- (DTTableSection * (^)(NSArray *dataList))withDataList;

- (DTTableSection * (^)(SectionRowCount countBlock))withCountBlock;

- (DTTableSection * (^)(CGFloat height))withHeaderHeight;
- (DTTableSection * (^)(CGFloat height))withFooterHeight;
- (DTTableSection * (^)(SectionHeaderFooter headerBlock))withHeaderBlock;
- (DTTableSection * (^)(SectionHeaderFooter footerBlock))withFooterBlock;


- (DTTableSection * (^)(DTTableRow *rowItem))withAddRow;
- (DTTableSection * (^)(NSArray<DTTableRow *> *rowList))withAddRowList;
- (DTTableSection * (^)(DTTableRow *rowItem, NSInteger index))withInsertRow;

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToSource;
- (DTTableSection * (^)(DTTableSourceData *sourceItem, NSInteger index))insertToSource;

@end
