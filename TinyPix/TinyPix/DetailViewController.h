//
//  DetailViewController.h
//  TinyPix
//
//  Created by chen on 2021/6/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@end

NS_ASSUME_NONNULL_END
