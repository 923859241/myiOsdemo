//
//  SecondViewController.m
//  Bridge
//
//  Created by chen on 2021/6/23.
//

#import "SecondViewController.h"
#import "Constants.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *engineSwitch;
@property (weak, nonatomic) IBOutlet UISlider *warpFactorSlider;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshFields];
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

-(void)applicationWillEnterForeground:(NSNotification*)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}
-(void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.engineSwitch.on = [defaults boolForKey:kWarpDriverKey];
    NSLog(@"[defaults boolForKey:kWarpDriverKey] = %d",[defaults boolForKey:kWarpDriverKey]);
    self.warpFactorSlider.value = [defaults floatForKey:kWarpFactorKey];
    NSLog(@"[defaults floatForKey:kWarpFactorKey] = %f",[defaults floatForKey:kWarpFactorKey]);
}

- (IBAction)engineSwitchTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.engineSwitch.on forKey:kWarpDriverKey];
    [defaults synchronize];
}

- (IBAction)warpSliderTouched:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.warpFactorSlider.value forKey:kWarpFactorKey];
    [defaults synchronize];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)settingButtonClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]  options:@{
        
        UIApplicationOpenURLOptionUniversalLinksOnly : UIApplicationOpenSettingsURLString
    } completionHandler:^(bool value){
        NSLog(value ? @"TRUE" : @"FALSE");
    }];
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
