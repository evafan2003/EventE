//
//  ResourceStatisticalViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ResourceStatisticalViewController.h"
#import "ResourceStatistical.h"
#import "ControllerFactory.h"


@interface ResourceStatisticalViewController ()

@end

@implementation ResourceStatisticalViewController

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
    
    self.title = NAVTITLE_TOP10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) listLabelName:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"来源";
            case 1:
            return @"到访量";
            case 2:
            return @"成单量";
            case 3:
            return @"转化率";
        default:
            return @"";
            break;
    }
}

- (NSString *) contentOfCellInIndexPath:(NSIndexPath *)indexPath labelIndex:(NSInteger)index
{
    ResourceStatistical *resource = (ResourceStatistical *)self.dataArray[indexPath.row];
    switch (index) {
        case 0:
            return resource.name;
            break;
            case 1:
            return resource.totalCount;
            break;
            case 2:
            return resource.sucOrder;
            break;
            case 3:
            return resource.sucPercent;
            break;
        default:
            return @"";
            break;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ResourceStatistical *res = (ResourceStatistical *)self.dataArray[indexPath.row];
    [self.navigationController pushViewController:[ControllerFactory singleresourceStaViewControllerWithResourceStatistical:res] animated:YES];
}

@end
