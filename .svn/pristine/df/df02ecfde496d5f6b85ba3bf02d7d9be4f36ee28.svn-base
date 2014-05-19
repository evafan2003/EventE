//
//  RoundViewController.m
//  MoshTicket
//
//  Created by evafan2003 on 12-7-10.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "RoundViewController.h"
#import "MoshDefine.h"
#import "TicketType.h"

@interface RoundViewController ()

@end

@implementation RoundViewController
@synthesize roundList;
@synthesize selectList;
@synthesize rdeleage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)selectAll {
    
//    [self dismissModalViewControllerAnimated:YES];
    
    if (self.isSelctAll) {
        [self.selectList removeAllObjects];
    }
    else {
        [self.selectList removeAllObjects];
        [self.selectList addObjectsFromArray:self.roundList];
    }
    
    
    [self updateLeftButton];
    [self.tableView reloadData];
}

-(void)confirm {

//    if (self.selectList.count > 0) {
    
        [rdeleage returnRound:self.selectList];
        
//    }

    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateLeftButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:BUTTON_OK style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    
    self.title = NAVTITLE_CHOOSE;
    
    if (self.selectList == nil) {
        
        self.selectList = [NSMutableArray array];
        
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) updateLeftButton
{
    self.isSelctAll = NO;
    if (self.selectList.count == self.roundList.count) {
        self.isSelctAll = YES;
    }
    
    NSString *title = BUTTON_ALLSELECT;
    if (self.isSelctAll) {
        title = BUTTON_ALLDEL;
    }
    
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(selectAll)] ;
    }
    else {
        self.navigationItem.leftBarButtonItem.title = title;
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.roundList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TicketType *tType = [self.roundList objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = tType.tTypeName;
    cell.accessoryType = UITableViewCellSelectionStyleNone;    
    
    
    for (TicketType *t in self.selectList) {
        
        if ([t.tTypeID isEqualToString:tType.tTypeID]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TicketType *tType = [self.roundList objectAtIndex:indexPath.row];
    
    BOOL insert = NO;
    
    for (TicketType *ticket in self.selectList) {
        
        
        if ([ticket.tTypeID isEqualToString:tType.tTypeID]) {
            //
            insert = YES;
        }
    }
    
    if (insert) {

        [self.selectList removeObject:tType];
        
    } else {
        
        [self.selectList addObject:tType];
    }
    
    [self.tableView reloadData];
    
    [self updateLeftButton];
    
//    NSLog(@"%@",self.activeList);
}

@end
