//
//  YellowViewController.m
//  View_Switcher
//
//  Created by chen on 2021/6/17.
//

#import "YellowViewController.h"

@interface YellowViewController ()



@end

@implementation YellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)yellowButtonPressed{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Yellow view Button Pressed" message:@"You pressed the button on the Yellow view" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"yep, idid" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
