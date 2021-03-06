//
//  TinyPixUtils.m
//  TinyPix
//
//  Created by chen on 2021/6/29.
//

#import "TinyPixUtils.h"

@implementation TinyPixUtils

+(UIColor *)getTintColorForIndex:(NSUInteger)index {
    UIColor *color = [UIColor redColor];
    switch (index) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:1];
            break;
        case 2:
            color = [UIColor blueColor];
        default:
            break;
    }
    return color;
}

@end
