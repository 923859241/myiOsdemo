//
//  TinyPixView.m
//  TinyPix
//
//  Created by chen on 2021/6/30.
//

#import "TinyPixView.h"
#import "TinyPixDocument.h"

typedef struct {
    NSUInteger row;
    NSUInteger colum;
} GridIndex;

@interface TinyPixView()

@property(assign, nonatomic) CGSize lastSize;
@property(assign, nonatomic) CGRect gridRect;
@property(assign, nonatomic) CGSize blockSize;
@property(assign, nonatomic) CGFloat gap;
@property(assign, nonatomic) GridIndex selectedBlockIndex;

@end

@implementation TinyPixView

-(id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    [self calculateGridForSize:self.bounds.size];
    _selectedBlockIndex.row = NSNotFound;
    _selectedBlockIndex.colum = NSNotFound;
}

-(void)calculateGridForSize:(CGSize)size {
    CGFloat space = MIN(size.width,size.height);
    _gap = space/57;
    CGFloat cellSide = 6 *_gap;
    _blockSize = CGSizeMake(cellSide, cellSide);
    _gridRect = CGRectMake((size.width - space)/2, (size.height - space)/2, space, space);
}
- (void)drawRect:(CGRect)rect {
    if (!_document) return;
    CGSize size = self.bounds.size;
    if (!CGSizeEqualToSize(size , self.lastSize)) {
        self.lastSize = size;
        [self calculateGridForSize:size];
    }
    for (NSUInteger row = 0; row < 8; row++) {
        for (NSUInteger column = 0; column < 8; column++) {
            [self drawBlockAtRow:row column:column];
        }
    }
}

-(void)drawBlockAtRow:(NSUInteger)row column:(NSUInteger)column {
    CGFloat startX = _gridRect.origin.x + _gap + (_blockSize.width + _gap) * (7 - column) + 1;
    CGFloat startY = _gridRect.origin.y + _gap + (_blockSize.height + _gap) * row + 1;
    CGRect blockFrame = CGRectMake(startX, startY, _blockSize.width, _blockSize.height);
    UIColor *color = [_document stateAtRow:row colum:column] ? [UIColor blackColor] : [UIColor whiteColor];
    [color setFill];
    [self.tintColor setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockFrame];
    [path fill];
    [path stroke];
    
}

- (GridIndex)touchedGridIndexFromTouches:(NSSet*)touches {
    GridIndex result;
    result.row = -1;
    result.colum = -1;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(_gridRect, location)) {
        location.x -= _gridRect.origin.x;
        location.y -= _gridRect.origin.y;
        result.colum = 8 - (location.x * 8.0 / _gridRect.size.width);
        result.row = location.y * 8.0 / _gridRect.size.height;
    }
    return result;
}

-(void)toggleSelectedBlock {
    if (_selectedBlockIndex.row != -1 & _selectedBlockIndex.colum != -1) {
        [_document toggleStateAtRow:_selectedBlockIndex.row column:_selectedBlockIndex.colum];
        [[_document.undoManager prepareWithInvocationTarget:_document] toggleStateAtRow:_selectedBlockIndex.row column:_selectedBlockIndex.colum];
        [self setNeedsDisplay];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GridIndex touched = [self touchedGridIndexFromTouches:touches];
    if (touched.row != _selectedBlockIndex.row || touched.colum != _selectedBlockIndex.colum) {
        _selectedBlockIndex = touched;
        [self toggleSelectedBlock];
    }
}

@end
