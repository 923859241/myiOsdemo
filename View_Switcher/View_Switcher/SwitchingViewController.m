//
//  SwitchingViewController.m
//  View_Switcher
//
//  Created by chen on 2021/6/17.
//

#import "SwitchingViewController.h"

#import "BlueViewController.h"
#import "YellowViewController.h"

@interface SwitchingViewController ()

@property (strong, nonatomic) YellowViewController *yellowViewController;
@property (strong, nonatomic) BlueViewController *blueViewController;

- (IBAction)switchViews:(id)sender;
//- (void)switchViewController;
@end

@implementation SwitchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"yellow"];
    self.yellowViewController.view.frame = self.view.frame;
    [self switchViewFromViewController:nil toViewController:self.yellowViewController];
}

- (IBAction)switchViews:(id)sender{
    NSLog(@"do switchView");
    if(!self.yellowViewController.view.superview){
        if(!self.yellowViewController){
            self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"yellow"];
        }
    } else {
        if(!self.blueViewController) {
            self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"blue"];
        }
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (self.blueViewController != nil && self.blueViewController.view.superview != nil) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:TRUE];
    }
    //switch view
    if( !self.yellowViewController.view.superview) {
        self.yellowViewController.view.frame = self.view.frame;
        [self switchViewFromViewController:self.blueViewController toViewController:self.yellowViewController];
    } else {
        self.blueViewController.view.frame = self.view.frame;
        [self switchViewFromViewController:self.yellowViewController toViewController:self.blueViewController];
    }
    
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if(!self.blueViewController.view.superview) {
        self.blueViewController = nil;
    } else {
        self.yellowViewController = nil;
    }
}

- (void)switchViewFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    
    if (toVC != nil) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
//        [self presentViewController:toVC animated:TRUE completion:nil];
        [toVC didMoveToParentViewController:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
