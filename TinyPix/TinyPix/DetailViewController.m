//
//  DetailViewController.m
//  TinyPix
//
//  Created by chen on 2021/6/26.
//

#import "DetailViewController.h"
#import "TinyPixView.h"
#import "TinyPixUtils.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet TinyPixView *pixView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    [self updateTintColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSettingsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
}
-(void)configureView {
    if (self.detailItem) {
        self.pixView.document = self.detailItem;
        [self.pixView setNeedsDisplay];
    }
}

-(void)updateTintColor {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger selectedColorIndex = [prefs integerForKey:@"selectedColorIndex"];
    UIColor *tintColor = [TinyPixUtils getTintColorForIndex:selectedColorIndex];
    self.pixView.tintColor = tintColor;
    [self.pixView setNeedsDisplay];
}

-(void)onSettingsChanged:(NSNotification*)notification {
    [self updateTintColor];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
}

#pragma mark - Managing the detail item

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
