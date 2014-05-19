//
//  RoundViewController.h
//  MoshTicket
//
//  Created by evafan2003 on 12-7-10.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoundDelegate;


@interface RoundViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *roundList;
@property (strong, nonatomic) NSMutableArray *selectList;
@property (assign, nonatomic) BOOL  isSelctAll;

@property (assign, nonatomic) id<RoundDelegate> rdeleage;

@end

@protocol RoundDelegate

-(void) returnRound:(NSMutableArray *)array;

@end