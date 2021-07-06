//
//  FirstViewController.m
//  Bridge
//
//  Created by chen on 2021/6/22.
//

#import "FirstViewController.h"
#import "Constants.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *officerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *warpDriveLabel;
@property (weak, nonatomic) IBOutlet UILabel *favouriteCaptainLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"[defaults objectForKey:kOfficerKey] = %@",[defaults objectForKey:kOfficerKey]);
    self.officerLabel.text = [defaults objectForKey:kOfficerKey];
    self.rankLabel.text = [defaults objectForKey:kRankKey];
    //self.warpDriveLabel.text = [defaults objectForKey:kWarpDriverKey];
    self.favouriteCaptainLabel.text = [defaults objectForKey:kFavouriteCaptainKey];
}
- (void)viewWillAppear:(BOOL)animated {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
