//
//  PieChartView.h
//  PieChartViewDemo
//
//  Created by Strokin Alexey on 8/27/13.
//  Copyright (c) 2013 Strokin Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTOneFingerRotationGestureRecognizer.h"

@protocol PieChartViewDelegate;
@protocol PieChartViewDataSource;

@interface PieChartView : UIView
{
    NSMutableArray *_angleArray;
    KTOneFingerRotationGestureRecognizer *_gesture;
    CGFloat _currentRotation;//当前旋转弧度
}

@property (nonatomic, assign) id <PieChartViewDataSource> datasource;
@property (nonatomic, assign) id <PieChartViewDelegate> delegate;

-(void)reloadData;

@end


@protocol PieChartViewDelegate <NSObject>

//圆环内半径
- (CGFloat)centerCircleRadius;

//旋转中底部的index值
- (void) rotatingWithIndex:(NSInteger)index;

//初始化后底部的index值（旋转前）
- (void) drawRectFinishWithIndex:(NSInteger)index;

@end



@protocol PieChartViewDataSource <NSObject>

@required
//分区数量
- (int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView;
//每部分的值 按照每部分值/总值画图
- (double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index;
//每部分的颜色
- (UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index;

@end
