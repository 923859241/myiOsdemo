//
//  FavouritesList.h
//  Fonts
//
//  Created by chen on 2021/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavouritesList : NSObject

+ (instancetype)shareFavouritesList;

-(NSArray*)favourites;

-(void)addFavourite:(id)item;
-(void)removeFavourite:(id)item;

@end

NS_ASSUME_NONNULL_END
