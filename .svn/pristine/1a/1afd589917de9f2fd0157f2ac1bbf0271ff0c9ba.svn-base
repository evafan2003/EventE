//
//  MoshPickerView.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-6.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "MoshPickerView.h"
#import "GlobalConfig.h"

static CGFloat  toolBarHeight = 30.0f;
static CGFloat  animationTime = 0.5f;
static CGFloat pickerViewHeight = 246.0f;

@implementation MoshPickerView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = array;
    }
    return self;
}

- (id)initWithArray:(NSArray *)array
{
    self = [super initWithFrame:CGRectMake(POINT_X, SCREENHEIGHT, SCREENWIDTH,pickerViewHeight)];
    if (self) {
        self.dataArray = array;
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(POINT_X,0, SCREENWIDTH, toolBarHeight)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    toolBar.items = [NSArray arrayWithObjects:space,done, nil];
    [self addSubview:toolBar];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(POINT_X, toolBarHeight, SCREENWIDTH, self.frame.size.height - toolBarHeight)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = WHITECOLOR;
    [self addSubview:self.pickerView];
}

- (void) done
{
    
    if([self.delegate respondsToSelector:@selector(selectArray:startArray:)]) {
        
        NSInteger component = [self numberOfComponentsInPickerView:self.pickerView];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ;i < component;i++) {
            [array addObject:[NSNumber numberWithInteger:[self.pickerView selectedRowInComponent:i]]];
        }
        
        [self.delegate selectArray:array startArray:self.startArray];
    }
    [self hiddenPickerView];
}

#pragma  mark publicAction -

- (void) setArray:(NSArray *)array animated:(BOOL)animated
{
    self.startArray = array;
    for (int i = 0; i < array.count; i++) {
        NSNumber *number = [GlobalConfig convertToNumber:array[i]];
      [self.pickerView selectRow:[number integerValue] inComponent:i animated:animated];
    }
  
}

- (void) showPickerViewWithstartArray:(NSArray *)array animated:(BOOL)animated
{
    self.hidden = NO;
    [UIView animateWithDuration:animationTime
                     animations:^{
                         self.frame = CGRectOffset(self.frame, 0, -self.frame.size.height);
                     }
                     completion:^(BOOL finish) {
                         if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:array]) {
                             [self setArray:array animated:YES];
                         }
                     }];
}

- (void) showPickerView
{
    self.hidden = NO;
    [UIView animateWithDuration:animationTime
                     animations:^{
                         self.frame = CGRectOffset(self.frame, 0, -self.frame.size.height);
                     }];

}

- (void) hiddenPickerView
{
    
    [UIView animateWithDuration:animationTime animations:^{
        self.frame = CGRectOffset(self.frame, 0, self.frame.size.height);
    } completion:^(BOOL finish) {
        self.hidden = YES;
    }];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(moshPickerView:numberOfRowsInComponent:)]) {
        return [self.delegate moshPickerView:pickerView numberOfRowsInComponent:component];
    }
    
    else {
        return self.dataArray.count;
    }
}
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([self.delegate respondsToSelector:@selector(moshPickerView:titleForRow:forComponent:)]) {
        return [self.delegate moshPickerView:pickerView titleForRow:row forComponent:component];
    }
    
    else {
        if (row < self.dataArray.count && row >= 0) {
            return [GlobalConfig convertToString:self.dataArray[row]];
        }
        else {
            return @"";
        }
    }
   
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.delegate respondsToSelector:@selector(moshNumberOfComponentsInPickerView:)]) {
        return [self.delegate moshNumberOfComponentsInPickerView:pickerView];
    }
    
    else {
        return 1;
    }
}

@end



