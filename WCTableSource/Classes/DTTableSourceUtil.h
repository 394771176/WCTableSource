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

- (DTTableRow * (^)(BOOL isXib))withIsXib;

- (DTTableRow * (^)(CGFloat height))withHeight;

- (DTTableRow * (^)(SEL method))withDataMethod;
- (DTTableRow * (^)(BOOL autoSet))withAutoSetItem;

//以下方法会转为section,建议row配置完成后才调用
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

- (DTTableSection * (^)(CGFloat height))withHeaderHeight;
- (DTTableSection * (^)(CGFloat height))withFooterHeight;

- (DTTableSection * (^)(DTTableRow *rowItem))withAddRow;
- (DTTableSection * (^)(NSArray<DTTableRow *> *rowList))withAddRowList;
- (DTTableSection * (^)(DTTableRow *rowItem, NSInteger index))withInsertRow;

- (DTTableSection * (^)(DTTableSourceData *sourceItem))addToSource;
- (DTTableSection * (^)(DTTableSourceData *sourceItem, NSInteger index))insertToSource;

@end


@interface DTTableSourceData (Util)

@end

