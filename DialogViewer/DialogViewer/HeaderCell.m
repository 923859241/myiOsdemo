//
//  HeaderCell.m
//  DialogViewer
//
//  Created by chen on 2021/6/21.
//

#import "HeaderCell.h"
@implementation HeaderCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }
    return self;
}

+ (UIFont *)defaultFont {
    return  [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
