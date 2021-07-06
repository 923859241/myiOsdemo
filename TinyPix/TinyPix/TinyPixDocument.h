//
//  TinyPixDocument.h
//  TinyPix
//
//  Created by chen on 2021/6/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TinyPixDocument : UIDocument

-(BOOL)stateAtRow:(NSUInteger)row colum:(NSUInteger)colum;
-(void)toggleStateAtRow:(NSUInteger)row column:(NSInteger)column;
-(void)setState:(BOOL)state atRow:(NSUInteger)row colum:(NSUInteger)colum;

@end

NS_ASSUME_NONNULL_END
