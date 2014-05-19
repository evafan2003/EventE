//
//  BaseNavigationController.m
//  modelTest
//
//  Created by 魔时网 on 13-10-31.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "BaseNavigationController.h"
#import "GlobalConfig.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
	// Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:NAVIMAGE] forBarMetrics:UIBarMetricsDefault];
    
    //标题字体变成白色
    if ([GlobalConfig versionIsIOS7]) {
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
