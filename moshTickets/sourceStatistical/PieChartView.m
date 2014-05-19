//
//  PieChartView.m
//  PieChartViewDemo
//
//  Created by Strokin Alexey on 8/27/13.
//  Copyright (c) 2013 Strokin Alexey. All rights reserved.
//

#import "PieChartView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PieChartView

@synthesize delegate;
@synthesize datasource;

-(id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self != nil)
   {
    //阴影
//      self.layer.shadowColor = [[UIColor blackColor] CGColor];
//      self.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
//      self.layer.shadowRadius = 1.9f;
//      self.layer.shadowOpacity = 0.9f;
       
       _angleArray = [[NSMutableArray alloc] init];
       self.backgroundColor = [UIColor clearColor];
       //底部 0为左部
       _currentRotation =  - 2*M_PI*0.25;
       
       //添加手势
       _gesture = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)];
       [self addGestureRecognizer:_gesture];
   
   }
   return self;
}

-(void)reloadData
{
   [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

//prepare
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGFloat theHalf = rect.size.width/2;
   CGFloat lineWidth = theHalf;
   if ([self.delegate respondsToSelector:@selector(centerCircleRadius)])
   {
      lineWidth -= [self.delegate centerCircleRadius];
      NSAssert(lineWidth <= theHalf, @"wrong circle radius");
   }
   CGFloat radius = theHalf-lineWidth/2;
   
   CGFloat centerX = theHalf;
   CGFloat centerY = rect.size.height/2;
   
//drawing
   
   double sum = 0.0f;
   int slicesCount = [self.datasource numberOfSlicesInPieChartView:self];
   
   for (int i = 0; i < slicesCount; i++)
   {
      sum += [self.datasource pieChartView:self valueForSliceAtIndex:i];
   }
   
    //起始位置 0为左部 2*M_PI*0.25为底部
//  float startAngle = 2*M_PI*1;
    float startAngle = 0;
    float endAngle = 0.0f;
      
   for (int i = 0; i < slicesCount; i++)
   {
       double value = [self.datasource pieChartView:self valueForSliceAtIndex:i];

       endAngle = startAngle + M_PI*2*value/sum;
       
       CGContextAddArc(context, centerX, centerY, radius, startAngle, endAngle, false);
   
       UIColor  *drawColor = [self.datasource pieChartView:self colorForSliceAtIndex:i];
   
       CGContextSetStrokeColorWithColor(context, drawColor.CGColor);
       CGContextSetLineWidth(context, lineWidth);
       CGContextStrokePath(context);
       
       //将起始位置加入字典
       NSDictionary *dic = @{@"start":@(- startAngle),@"end":@(- endAngle)};
       [_angleArray addObject:dic];
       
       startAngle += M_PI*2*value/sum;
   }
    
    [self.delegate drawRectFinishWithIndex:[self currentIndexOfAngle]];
}

//旋转
- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
    UIView *view = [recognizer view];
    [view setTransform:CGAffineTransformRotate([view transform], [recognizer rotation])];
    
    //旋转中的index值
    [self.delegate rotatingWithIndex:[self currentIndexOfAngle]];
   }

//获取当前的位置的index
- (NSInteger) currentIndexOfAngle
{
    _currentRotation += _gesture.rotation;
    
    CGFloat limitRotation = 2*M_PI;
    if (_currentRotation > limitRotation) {
        _currentRotation -= limitRotation;
    }
    if (_currentRotation < - limitRotation) {
        _currentRotation += limitRotation;
    }
    
    CGFloat copyRotation = (_currentRotation > 0) ? (_currentRotation - limitRotation) : _currentRotation;
    
    for (NSDictionary *dic in _angleArray) {
        CGFloat start = [dic[@"start"] floatValue];
        CGFloat end = [dic[@"end"] floatValue];
        if (copyRotation >= end && copyRotation <= start) {
            return [_angleArray indexOfObject:dic];
        }
    }
    return 0;
}

@end
