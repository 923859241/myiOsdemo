//
//  FontListViewController.h
//  Fonts
//
//  Created by chen on 2021/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontListViewController : UITableViewController

@property(copy, nonatomic) NSArray *fontNames;
@property(assign, nonatomic) BOOL showsFavourites;
@end

NS_ASSUME_NONNULL_END
