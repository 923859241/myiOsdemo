//
//  Favourites.m
//  Persistence
//
//  Created by chen on 2021/6/24.
//

#import "Favourites.h"

static NSString * const kLinesKey = @"kLinesKey";

@implementation Favourites

#pragma maek -Coding

-(id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        //使用同一个key进行解码
        self.lines = [coder decodeObjectForKey:kLinesKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    //使用同一个值进行编码
    [coder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark -Copying

-(id)copyWithZone:(NSZone *)zone {
    //allocWithZone 实例变量被初始化为描述类(self)的数据结构,描述中显示 zone的参数是This parameter is ignored.
    Favourites *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}

@end
