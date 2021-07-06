//
//  DatePickerViewController.m
//  Picker
//
//  Created by chen on 2021/6/18.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *now = [NSDate date];
    [self.DatePicker setDate:now];
}
- (IBAction)onButtonPress:(UIButton *)sender {
    NSDate *myDate = self.DatePicker.date;
    NSLog(@"%@",myDate);
    NSString *message = [[NSString alloc] initWithFormat:@"the date and time you select is %@", myDate];
    NSLog(@"%@",message);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Date and time selected" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"this is so true" style:UIAlertActionStyleDefault handler:nil];
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
