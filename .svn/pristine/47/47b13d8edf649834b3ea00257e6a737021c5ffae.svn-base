//
//  StatisticalViewController.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Activity.h"


@interface StatisticalViewController : BaseTableViewController
{
    Activity *_act;
    UILabel *_titleLabel;
    NSInteger labelNumber;//列表头含有label的个数 如果修改则在viewdidload修改
}

- (id) initWithActivity:(Activity *)act dataArray:(NSMutableArray *)array;

/*
 列表标题（来源 到访量。。。） 子类必须重写
 */
- (NSString *) listLabelName:(NSInteger)index;

/*
 行中各列名称
 indexPath 行坐标
 index 列坐标 应小于labelNumber
 子类必须重写
 */
- (NSString *) contentOfCellInIndexPath:(NSIndexPath *)indexPath labelIndex:(NSInteger)index;


/*
 行中各列label的rect
 integer label的列数 
 height label的高
 如果不符合要求 子类可以重写
 */
- (CGRect) rectOfLabel:(NSInteger)integer height:(CGFloat)height;

@end
