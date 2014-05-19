//
//  PLSegmentView.h
//
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {

    segmentTypeDefault,
    segmentTypeCheckBox
    
} SegmentType;

@protocol PLSegmentViewDelegate <NSObject>

@optional

//- (void)segmentClickedAtIndex:(int)index onCurrentCell:(BOOL)isCurrent;

- (void)segmentClickedAtIndex:(int)index onCurrentCell:(BOOL)isCurrent from:(id)sender;

@end


@class PLSegmentCell;
@interface PLSegmentView : UIView {
	NSMutableArray* _items;
	UIImageView* _backgroundImageView;
	//BOOL _isMultyCellSelectable; //TODO:add a subClass then support this feature
	int _selectedIndex;
	
}

@property (nonatomic, retain) UIImageView* backgroundImageView;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) int previousIndex;
@property (nonatomic, assign) id<PLSegmentViewDelegate> delegate;
@property (nonatomic, assign) SegmentType segmentType;

//Add by tianyz - Start
- (void)setupCellsByTextShow:(NSArray *)textShowNames 
                      offset:(CGSize)offset;

- (void)setupCellsByTextShow:(NSArray*)textShowNames 
                      offset:(CGSize)offset 
               startPosition:(CGPoint)point;

//更改cell显示语言
- (void)resetTextShowOfCells:(NSArray*)textShowNames;

//Add by tianyz - End

- (void)setupCellsByImagesName:(NSArray*)images 
            selectedImagesName:(NSArray*)selectedImages 
                        offset:(CGSize)offset;

- (void)setupCellsByImagesName:(NSArray*)images 
            selectedImagesName:(NSArray*)selectedImages 
                      textShow:(NSArray*)textShowNames 
                        offset:(CGSize)offset;

- (void)setupCellsByImagesName:(NSArray*)images 
            selectedImagesName:(NSArray*)selectedImages 
                        offset:(CGSize)offset 
                 startPosition:(CGPoint)point;

- (void)setupCellsByImagesName:(NSArray*)images
            selectedImagesName:(NSArray*)selectedImages 
                      textShow:(NSArray*)textShowNames
                        offset:(CGSize)offset 
                 startPosition:(CGPoint)point;

- (void)addCells:(NSArray*)cells;

- (void)addCell:(PLSegmentCell*)cell;


@end


