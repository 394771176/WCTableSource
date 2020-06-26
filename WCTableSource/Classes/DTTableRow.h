//
//  DTTableRow.h
//  SourceTable
//
//  Created by cheng on 2020/6/12.
//  Copyright © 2020 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DTTableRow;

typedef CGFloat (^CellHeight)(DTTableRow *rowItem, NSIndexPath *indexPath);
typedef UITableViewCell * (^CellItem)(DTTableRow *rowItem, NSIndexPath *indexPath);
typedef void (^CellConfig)(DTTableRow *rowItem, id cell, NSIndexPath *indexPath);
typedef void (^CellClick)(DTTableRow *rowItem, id cell, NSIndexPath *indexPath);

@interface DTTableRow : NSObject<UITableViewDelegate, UITableViewDataSource>

//cell 复用id, 当cellclass时，= cellclass str
@property (nonatomic, strong) NSString *reuseCellId;

//cell, 优先级cellBlock > cell > cellClass，正常三选一即可
@property (nonatomic, strong) UITableViewCell   *cell;
@property (nonatomic, strong) Class             cellClass;
@property (nonatomic, strong) CellItem          cellBlock;
//是否xib cell
@property (nonatomic, assign) BOOL isXibCell;

//cell 数据
@property (nonatomic, strong) id data;

//cell响应事件类型类型
@property (nonatomic, assign) NSInteger actionType;
//celle附加信息
@property (nonatomic, strong) id userInfo;

//cell 高度
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) CellHeight    heightBlock;

//cell 初始化配置, 每个cell仅初始化时，执行一次
@property (nonatomic, strong) CellConfig    initBlock;
//cell 配置，复用时都会调用
@property (nonatomic, strong) CellConfig    configBlock;

//cell data传递, 必须是支持一个参数的方法，参数为data, 如果nil = setItem:
@property (nonatomic, assign) SEL dataMethod;
//是否自动默认的数据赋值方法setItem:,默认yes
@property (nonatomic, assign) BOOL autoSetItem;

//cell 点击
@property (nonatomic, strong) CellClick     clickBlock;

@property (nonatomic, weak, readonly) UITableViewCell *currentCell;

+ (DTTableRow *)row;

@end
