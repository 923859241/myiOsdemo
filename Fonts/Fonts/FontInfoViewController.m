//
//  FontInfoViewController.m
//  Fonts
//
//  Created by chen on 2021/6/21.
//

#import "FontInfoViewController.h"
#import "FavouritesList.h"

@interface FontInfoViewController ()

@property (weak, nonatomic)IBOutlet UILabel *fontSampleLabel;
@property (weak, nonatomic)IBOutlet UISlider *fontSizeSlider;
@property (weak, nonatomic)IBOutlet UILabel *fontSizeLabel;
@property (weak, nonatomic)IBOutlet UISwitch *favouriteSwitch;

@end

@implementation FontInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fontSampleLabel.font = self.font;
    self.fontSampleLabel.text = @"AaBbCcDdEeFfGgHhJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    self.fontSizeSlider.value = self.font.pointSize;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%ff",self.font.pointSize];
    self.favouriteSwitch.on = self.favourite;
}

- (IBAction)slideFontSize:(UISlider*)sender {
    float newSize = round(sender.value);
    self.fontSampleLabel.font = [self.font fontWithSize:newSize];
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.ff",newSize];
}

- (IBAction)toggleFavourite:(UISwitch*)sender {
    FavouritesList *favouritesList = [FavouritesList shareFavouritesList];
    if (sender.on) {
        [favouritesList addFavourite:self.font.fontName];
    } else {
        [favouritesList removeFavourite:self.font.fontName];
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
