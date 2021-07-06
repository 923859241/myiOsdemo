//
//  Favourites.h
//  Persistence
//
//  Created by chen on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Favourites : NSObject<NSCoding, NSCopying>

@property (copy, nonatomic) NSArray *lines;

@end

NS_ASSUME_NONNULL_END
