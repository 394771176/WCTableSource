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

typedef NSInteger (^SectionCount)(UITableView *tableView);

@interface DTTableSourceData : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) NSMutableArray<DTTableSection *> *dataSource;

@property (nonatomic, strong) SectionCount countBlock;

- (DTTableSection *)lastSection;
- (DTTableSection *)sectionForIndex:(NSInteger)index;
- (DTTableRow *)rowForIndexPath:(NSIndexPath *)indexPath;

- (DTTableSection *)addNewSection;

- (DTTableSection *)addSection:(DTTableSection *)section;
- (DTTableSection *)insertSection:(DTTableSection *)section toIndex:(NSInteger)index;

- (DTTableSection *)addToLastSectionWithRow:(DTTableRow *)rowItem;
- (DTTableSection *)addToNewSectionWithRow:(DTTableRow *)rowItem;

- (DTTableSection *)addToLastSectionWithRowList:(NSArray<DTTableRow *> *)rowList;
- (DTTableSection *)addToNewSectionWithRowList:(NSArray<DTTableRow *> *)rowList;

@end
