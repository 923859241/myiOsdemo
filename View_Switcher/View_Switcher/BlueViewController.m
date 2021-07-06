//
//  BlueViewController.m
//  View_Switcher
//
//  Created by chen on 2021/6/17.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)blueButtonPressed{
    NSLog(@"perss blue botton");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Blue view Button Pressed" message:@"You pressed the button on the blue view" preferredStyle:UIAlertControllerStyleAlert];
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
