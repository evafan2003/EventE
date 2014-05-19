//
//  BaseTableViewController.h
//  modelTest
//
//  Created by mosh on 13-10-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic, strong) UITableView   *baseTableView;

//数据
@property (nonatomic, assign) int                   page;
@property (nonatomic, assign) BOOL                  hasMore;
@property (nonatomic, assign) NSInteger             cellHeight;

//其他
@property (strong, nonatomic) UISearchBar           *searchBar;

//分页和下拉刷新
@property (strong, nonatomic) EGORefreshTableHeaderView *headerView;
@property (assign, nonatomic) BOOL isLoading;

/*
 改变tableview的frame
 */
- (CGRect) returnBaseTableViewFrame;
/*
 改变tableView的类型
 */
- (UITableViewStyle) returnBaseTableViewStyle;

/*
 初始化/重新加载
 */
- (id) initWithData:(NSArray *)array;
- (void) reloadWithData:(NSArray *)array;

/*
 添加下拉刷新控件
 */
-(void)addEGORefreshOnTableView:(UITableView *)tableView;

/*
 加载完成解析
 */
-(void)listFinishWithDataArray:(NSArray *)tmpArr;

/*
 加载数据（子类重写）
 加载更多 color为nil代表不需要显示“加载更多“内容
 */
- (void) downloadMore:(NSIndexPath *)indexPath textColor:(UIColor *)color;

/*
 下拉刷新
 */
- (void) refresh;

/*
 创建搜索栏
 */
- (void) createSearchBar;
@end