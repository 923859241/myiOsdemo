//
//  CollectionViewCell.h
//  DialogViewer
//
//  Created by chen on 2021/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) CGFloat maxWidth;

+ (CGSize)sizeForContentString:(NSString*)s forMaxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
