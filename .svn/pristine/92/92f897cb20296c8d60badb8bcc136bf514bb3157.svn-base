//
//  PartSaleTaskViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-5-16.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "PartSaleTaskViewController.h"
#import "PartTaskModel.h"

@interface PartSaleTaskViewController ()

@end

@implementation PartSaleTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.baseTableView.frame = CGRectMake(0, 272, SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 272);
//    self.baseScrollView.contentSize = CGSizeMake(SCREENWIDTH/2, CGRectGetHeight(self.baseScrollView.frame)+1);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.baseTableView.separatorColor = [UIColor colorWithRed:37/255.0 green:169/255.0 blue:249/255.0 alpha:1];
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:@"分销任务"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = CLEARCOLOR;
        cell.contentView.backgroundColor = CLEARCOLOR;
    }
    PartTaskModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}



@end
