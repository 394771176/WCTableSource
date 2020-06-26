//
//  DTTableRowGroup.h
//  WCTableSource
//
//  Created by cheng on 2020/6/13.
//

#import <Foundation/Foundation.h>
#import "DTTableRow.h"

@interface DTTableRowGroup : DTTableRow

@property (nonatomic, strong) NSArray *cellList;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSArray *heightList;

+ (DTTableRowGroup *)group;

- (NSArray<DTTableRow *> *)rowList;

@end
