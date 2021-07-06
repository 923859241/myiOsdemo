//
//  TinyPixView.h
//  TinyPix
//
//  Created by chen on 2021/6/30.
//

#import <UIKit/UIKit.h>
@class TinyPixDocument;

NS_ASSUME_NONNULL_BEGIN

@interface TinyPixView : UIView

@property (strong, nonatomic)TinyPixDocument *document;

@end

NS_ASSUME_NONNULL_END
