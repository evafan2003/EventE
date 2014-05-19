//
//  InfoViewController.m
//  MoshTicket
//
//  Created by evafan2003 on 12-5-13.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize scrollView;
@synthesize howToGetAccount;
@synthesize loginFail;
@synthesize transFromFail;
@synthesize infoType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.infoType == InfoTypeHowToGetAccount) {
        self.howToGetAccount.hidden = NO;
        
    }else if (self.infoType == InfoTypeLoginFail) {
        self.loginFail.hidden = NO;        
    } else {
        self.transFromFail.hidden = NO;
    }
    self.scrollView.contentSize = CGSizeMake(320, 461);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setHowToGetAccount:nil];
    [self setLoginFail:nil];
    [self setTransFromFail:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
