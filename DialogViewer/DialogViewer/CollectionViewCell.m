//
//  CollectionViewCell.m
//  DialogViewer
//
//  Created by chen on 2021/6/21.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

+ (UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
- (NSString*)text {
    return self.label.text;
}
- (void)setText:(NSString *)text {
    self.label.text = text;
    CGRect newLabelFrame = self.label.frame;
    CGRect newContextFrame = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text forMaxWidth:_maxWidth];
    newLabelFrame.size = textSize;
    newContextFrame.size = textSize;
    self.label.frame = newLabelFrame;
    self.contentView.frame = newContextFrame;
    self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
    self.label.textColor = [UIColor blackColor];
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = FALSE;

        
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class]defaultFont];
        self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        
    }
    return self;
}

+ (CGSize)sizeForContentString:(NSString *)s forMaxWidth:(CGFloat)maxWidth {
    
    CGSize maxSize = CGSizeMake(maxWidth, 1000.0);
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : [self defaultFont],
                                  NSParagraphStyleAttributeName : style };
    CGRect rect = [s boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    return rect.size;
}

@end
