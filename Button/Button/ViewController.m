//
//  ViewController.m
//  Button
//
//  Created by chen on 2021/6/14.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString* title = [sender titleForState:UIControlStateNormal];
    NSString *plainText = [NSString stringWithFormat:@"%@ button pressed.",title];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc]initWithString:plainText];
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:30]
                               };
    NSRange nameRange = [plainText rangeOfString:title];
    [styledText setAttributes:attrs range:nameRange];
    _statusLabel.attributedText = styledText;
    
}
@end
