//
//  DTTableRowGroup.m
//  WCTableSource
//
//  Created by cheng on 2020/6/13.
//

#import "DTTableRowGroup.h"
#import <objc/runtime.h>

@implementation DTTableRowGroup

+ (DTTableRowGroup *)group
{
    return [self new];
}

- (DTTableRow *)createRowWithIndex:(NSInteger)index
{
    DTTableRow *row = [DTTableRow new];
    //动态拷贝group的属性 到 row
    // 1.获取属性列表
    unsigned int propertyCount = 0;
    objc_property_t * propertyArray = class_copyPropertyList([row class], &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t  property = propertyArray[i];

        // 2.属性名字
        const char * propertyName = property_getName(property);
        NSString * key = [NSString stringWithUTF8String:propertyName];
        
        // 3.通过属性名拿到属性值
        id value=[self valueForKey:key];
        
        // 4.判断 值对象是否响应copyWithZone
        if ([value respondsToSelector:@selector(copyWithZone:)]) {
            //5. 设置属性值
            [row setValue:[value copy] forKey:key];
        } else {
            [row setValue:value forKey:key];
        }
    }
    //*****切记需要手动释放
    free(propertyArray);
    
    row.cell = [self cellWithIndex:index];
    row.data = [self dataWithIndex:index];
    row.height = [self heightWithIndex:index];
    return row;
}

- (UITableViewCell *)cellWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.cellList.count) {
        return [self.cellList objectAtIndex:index];
    } else {
        return self.cell;
    }
}

- (id)dataWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.dataList.count) {
        return [self.dataList objectAtIndex:index];
    } else {
        return self.data;
    }
}

- (CGFloat)heightWithIndex:(NSInteger)index
{
    if (index >= 0 && index < self.heightList.count) {
        return [[self.heightList objectAtIndex:index] floatValue];
    } else {
        return self.height;
    }
}

- (NSArray<DTTableRow *> *)rowList
{
    if (self.dataList.count || self.cellList.count) {
        NSMutableArray *array = [NSMutableArray array];
        NSInteger count = MAX(self.dataList.count, self.cellList.count);
        for (int i=0; i<count; i++) {
            [array addObject:[self createRowWithIndex:i]];
        }
        return array;
    } else {
        return nil;
    }
}

@end
