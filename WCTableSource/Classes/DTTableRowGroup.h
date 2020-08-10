//
//  DTTableRowGroup.h
//  WCTableSource
//
//  Created by cheng on 2020/6/13.
//

#import <Foundation/Foundation.h>
#import "DTTableRow.h"

//多个具有类似属性的 连续的cell，具有row的全部属性
@interface DTTableRowGroup : DTTableRow

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSArray<UITableViewCell *> *cellList;

@property (nonatomic, strong) NSArray *heightList;

+ (DTTableRowGroup *)group;

- (NSArray<DTTableRow *> *)rowList;

@end
