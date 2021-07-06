//
//  ViewController.m
//  Orientations
//
//  Created by chen on 2021/6/16.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *thisWayText;
- (void)constraintController;
- (void)labelConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)constraintController{
    [_thisWayText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self labelConstraint];
}

- (void)labelConstraint{
    [NSLayoutConstraint constraintWithItem:self.thisWayText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationLandscapeLeft);
}

@end
