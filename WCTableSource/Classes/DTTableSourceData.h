//
//  DTTableSourceData.h
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTTableSection.h"
#import "DTTableRow.h"
#import "DTTableRowGroup.h"

typedef NSInteger (^SectionCount)(UITableView *tableView);

@interface DTTableSourceData : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) NSMutableArray<DTTableSection *> *dataSource;

//默认count = dataSource.count,但是有时可能有其他条件，需要自定义count， 但count 不得超过dataSource.count
@property (nonatomic, strong) SectionCount countBlock;

@property (nonatomic, strong) NSMutableArray *notSetItemClassList;

- (void)clearDataSource;

- (void)addNotSetItemClass:(Class)cla;

- (DTTableSection *)lastSection;
- (DTTableSection *)sectionForIndex:(NSInteger)index;

- (DTTableRow *)lastRow;
- (DTTableRow *)rowForIndexPath:(NSIndexPath *)indexPath;

- (DTTableSection *)addNewSection;

- (DTTableSection *)addSection:(DTTableSection *)section;
- (DTTableSection *)insertSection:(DTTableSection *)section toIndex:(NSInteger)index;

- (DTTableSection *)addToLastSectionWithRow:(DTTableRow *)rowItem;
- (DTTableSection *)addToNewSectionWithRow:(DTTableRow *)rowItem;

- (DTTableSection *)addToLastSectionWithRowList:(NSArray<DTTableRow *> *)rowList;
- (DTTableSection *)addToNewSectionWithRowList:(NSArray<DTTableRow *> *)rowList;

@end
