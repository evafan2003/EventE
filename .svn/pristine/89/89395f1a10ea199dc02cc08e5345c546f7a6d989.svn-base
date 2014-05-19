//
//  MoshPickerView.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-6.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>

//frame为固定值（x,x,320,216+30）;

@protocol MoshPickerViewDelegate;

@interface MoshPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSArray   *startArray;//初始值【0，1，2，3】
@property (nonatomic, strong) NSArray   *dataArray;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) id<MoshPickerViewDelegate>  delegate;

- (id)initWithArray:(NSArray *)array;

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;

- (void) showPickerViewWithstartArray:(NSArray *)array animated:(BOOL)animated;

- (void) showPickerView;

- (void) hiddenPickerView;

@end

@protocol MoshPickerViewDelegate <NSObject>

/*
 array中的结构为【1，2，3，4，...】number类型
 分别对应component 0,1,2,3,...
 */

- (void) selectArray:(NSArray *)array startArray:(NSArray *)startArray;

@optional
/*
    当代理类实现了此方法，pickerView就调用代理类内此方法；
 如果代理类没有实现此方法，pickerView的component为0，row为dataArray.count ,pickerView的title调用dataArray的值，dataArray中必须为nsstring类型；
 */
- (NSInteger) moshPickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *) moshPickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSInteger) moshNumberOfComponentsInPickerView:(UIPickerView *)pickerView;

@end
