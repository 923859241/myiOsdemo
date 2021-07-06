#import "ViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapsLabel;
@property (weak, nonatomic) IBOutlet UILabel *touchesLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)updateLabelFromTouches:(NSSet *)touches {
    NSUInteger numTaps = [[touches anyObject] tapCount];
    NSString *tapsMessage = [[NSString alloc]initWithFormat:@"%ld taps detected",(unsigned long)numTaps];
    self.tapsLabel.text = tapsMessage;
    
    NSUInteger *touchMsg = [touches count];
    NSString *touchMessage = [[NSString alloc] initWithFormat:@"%d touch count",touchMsg ];
    self.touchesLabel.text = touchMessage;
    
}

#pragma mark -Touch Even Methods
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"touches Began";
    [self updateLabelFromTouches:event.allTouches];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Cancelled";
    [self updateLabelFromTouches:event.allTouches];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"touches Ended";
    [self updateLabelFromTouches:event.allTouches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"touches moved";
    [self updateLabelFromTouches:event.allTouches];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[touches anyObject] previousLocationInView:<#(nullable UIView *)#>]
}

@end
