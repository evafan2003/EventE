//
//  PLSegmentView.m
//  
//
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "PLSegmentView.h"
#import "PLSegmentCell.h"


@interface PLSegmentView(private)

- (void)onCellClicked:(PLSegmentCell*)cell;

- (void)setupCellsByImagesName:(NSArray *)images
            selectedImagesName:(NSArray *)selectedImages 
                      textShow:(NSArray *)textShowNames 
                        offset:(CGSize)offset 
                 startPosition:(CGPoint)point;

@end


@implementation PLSegmentView

@synthesize  backgroundImageView = _backgroundImageView ;
@synthesize delegate;
@dynamic selectedIndex;
@synthesize previousIndex;
@synthesize segmentType;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
		self.backgroundColor = [UIColor clearColor];
		_backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundImageView];
		
        //		_isMultyCellSelectable = NO;
		_items = [NSMutableArray array];
		_selectedIndex = -1;
    }
    return self;
}


#pragma mark -
#pragma mark public

- (void)setupCellsByTextShow:(NSArray *)textShowNames 
                      offset:(CGSize)offset {
    [self setupCellsByTextShow:textShowNames offset:offset startPosition:CGPointZero];
}

- (void)setupCellsByTextShow:(NSArray*)textShowNames 
                      offset:(CGSize)offset 
               startPosition:(CGPoint)point {
    NSString *nImageName, *sImageName;
    
    nImageName = @"tab";
    sImageName = @"tabSelected";   
    

    for (int cnt = 0; cnt < [textShowNames count]; cnt++) {
		CGPoint origin = CGPointMake(offset.width * cnt + point.x, offset.height * cnt + point.y+6);
        
		PLSegmentCell* cell = [[PLSegmentCell alloc] initWithNormalImage:[UIImage imageNamed:nImageName]
														   selectedImage:[UIImage imageNamed:sImageName]
                                                                textShow:[textShowNames objectAtIndex:cnt]
															  startPoint:origin
                                                                totCount:[textShowNames count]];
        cell.cellType = self.segmentType;
		[self addCell:cell];
	}
}

- (void)setupCellsByImagesName:(NSArray*)images 
            selectedImagesName:(NSArray*)selectedImages 
                        offset:(CGSize)offset {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[images count]];
    for (id str in images)
        [arr addObject:@""];
	[self setupCellsByImagesName:images 
              selectedImagesName:selectedImages 
                        textShow:arr
                          offset:offset 
                   startPosition:CGPointZero];
}

- (void)setupCellsByImagesName:(NSArray *)images 
            selectedImagesName:(NSArray *)selectedImages
                        offset:(CGSize)offset
                 startPosition:(CGPoint)point
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[images count]];
    for (id str in images)
        [arr addObject:@""];
    [self setupCellsByImagesName:images 
              selectedImagesName:selectedImages 
                        textShow:arr
                          offset:offset 
                   startPosition:point];
}

- (void)setupCellsByImagesName:(NSArray*)images 
            selectedImagesName:(NSArray*)selectedImages 
                      textShow:(NSArray*)textShowNames 
                        offset:(CGSize)offset
{
    [self setupCellsByImagesName:images 
              selectedImagesName:selectedImages 
                        textShow:textShowNames
                          offset:offset 
                   startPosition:CGPointZero];
}

- (void)setupCellsByImagesName:(NSArray*)images
            selectedImagesName:(NSArray*)selectedImages 
                      textShow:(NSArray*)textShowNames
                        offset:(CGSize)offset 
                 startPosition:(CGPoint)point
{
	NSAssert([images count] == [selectedImages count], @"two arrays should have same items count");
	for (int cnt = 0; cnt < [images count]; cnt++) {
		CGPoint origin = CGPointMake(offset.width * cnt + point.x, offset.height * cnt + point.y);
		PLSegmentCell* cell = [[PLSegmentCell alloc] initWithNormalImage:[UIImage imageNamed:[images objectAtIndex:cnt]]
														   selectedImage:[UIImage imageNamed:[selectedImages objectAtIndex:cnt]]
                                                                textShow:[textShowNames objectAtIndex:cnt]
															  startPoint:origin
                                                                totCount:[images count]];
        
		[self addCell:cell];
	}	
}

//更改显示语言
- (void)resetTextShowOfCells:(NSArray*)textShowNames {
    for (int index = 0; index < [textShowNames count]; index++) {
		PLSegmentCell *cell = (PLSegmentCell*)[_items objectAtIndex:index];
        [cell resetLabelText:[textShowNames objectAtIndex:index]];
	}
}

- (void)addCells:(NSArray*)cells
{
	for (PLSegmentCell* cell in cells) {
		[self addCell:cell];
	}
}

- (int)selectedIndex
{
	return _selectedIndex;
}

- (void)setSelectedIndex:(int)value
{
	self.previousIndex = _selectedIndex;
	_selectedIndex = value;
	
	if (self.previousIndex != _selectedIndex) {
		if(self.previousIndex != -1)
            ((PLSegmentCell*)[_items objectAtIndex:self.previousIndex]).selected = NO;
		((PLSegmentCell*)[_items objectAtIndex:_selectedIndex]).selected = YES;
	}		
	
    
	
}

#pragma mark -
#pragma mark private

- (void)addCell:(PLSegmentCell*)cell
{
	[cell addTarget:self action:@selector(onCellClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_items addObject:cell];
	[self addSubview:cell];
}


- (void)onCellClicked:(PLSegmentCell*)cell
{
	NSInteger index = [_items indexOfObject:cell];
	NSAssert(index != NSNotFound , @"error on the cell click!");
	
	self.previousIndex = _selectedIndex;
	self.selectedIndex = index;		
	
	if ([self.delegate respondsToSelector:@selector(segmentClickedAtIndex:onCurrentCell:from:)]) {
		[self.delegate segmentClickedAtIndex:self.selectedIndex onCurrentCell:self.selectedIndex == self.previousIndex from:self];
	}
}

@end

