//
//  FavouritesList.m
//  Fonts
//
//  Created by chen on 2021/6/19.
//

#import "FavouritesList.h"

@interface FavouritesList()

@property (strong, nonatomic) NSMutableArray *favourites;

@end

@implementation FavouritesList

+(instancetype)shareFavouritesList {
    static FavouritesList *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *storedFavourites = [defaults objectForKey:@"favourites"];
        if (storedFavourites) {
            self.favourites = [storedFavourites mutableCopy];
        } else {
            self.favourites = [NSMutableArray array];
        }
    }
    return self;
}

- (void)addFavourite:(id)item {
    [_favourites insertObject:item atIndex:0];
    [self saveFavourites];
}

- (void)removeFavourite:(id)item {
    [_favourites removeObject:item];
    [self saveFavourites];
}

- (void)saveFavourites {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favourites forKey:@"favourites"];
    [defaults synchronize];
}

@end
