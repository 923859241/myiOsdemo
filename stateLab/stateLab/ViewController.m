//
//  ViewController.m
//  stateLab
//
//  Created by chen on 2021/7/2.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) UIImage *smiley;
@property (strong, nonatomic) UIImageView *smileyView;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation ViewController
BOOL animate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.bounds;
    CGRect labelFrame = CGRectMake(bounds.origin.x, CGRectGetMidY(bounds) - 50, bounds.size.width, 100);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.font = [UIFont fontWithName:@"Helvetica" size:70];
    self.label.text = @"Bazingal";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    
    //根据图片尺寸而定
    CGRect smileyFrame = CGRectMake(CGRectGetMidX(bounds)-42, CGRectGetMidY(bounds)/2-42, 84, 84);
    self.smileyView = [[UIImageView alloc] initWithFrame:smileyFrame];
    self.smileyView.contentMode = UIViewContentModeCenter;
    NSString *smileyPath = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    self.smiley = [UIImage imageWithContentsOfFile:smileyPath];
    self.smileyView.image = self.smiley;
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"One",@"Two",@"Three",@"Four",nil]];
    self.segmentedControl.frame = CGRectMake(bounds.origin.x + 20, 50, bounds.size.width - 40, 30);
    [self.segmentedControl addTarget:self action:@selector(selectionChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    [self.view addSubview:self.smileyView];
    
    [self.view addSubview:self.label];
    
    self.index = [[NSUserDefaults standardUserDefaults] integerForKey:@"index"];
    self.segmentedControl.selectedSegmentIndex = self.index;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(willResignActivity) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(didBecomeActivity) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:self selector:@selector(didEnterBackgroud) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
}
-(void)selectionChanged:(UISegmentedControl*)sender {
    self.index = sender.selectedSegmentIndex;
}

-(void)willResignActivity {
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    animate = FALSE;
}

-(void)didBecomeActivity {
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    animate = TRUE;
    [self rotateLabelDown];
}

-(void)didEnterBackgroud {
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.index forKey:@"index"];
    UIApplication *app = [UIApplication sharedApplication];
    //调用beginBackgroundTaskWithExpirationHandler是为了告诉系统，需要更多时间完成某事，并承诺在完成的时候告诉他。
    //如果系统断定运行太长决定停止后台任务的时候，就会调用我们传进去的block；并且调用了Handler会返回特殊值UIBackgroundTaskInvalid
    __block UIBackgroundTaskIdentifier taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background task run out of time and was terminated.");
        //告诉系统我们完成了后台任务了
        [app endBackgroundTask:taskId];
    }];
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"Filed to start background task!");
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"starting background task with %f seconds remaining",app.backgroundTimeRemaining);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.smiley = nil;
            self.smileyView.image = nil;
        });
        
        // 模拟一个25s的过程
        [NSThread sleepForTimeInterval:25];
        
        NSLog(@"finishinf background with %f s",app.backgroundTimeRemaining);
        [app endBackgroundTask:taskId];
    });
    
}
-(void)willEnterForeground {
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    NSString *smileyPath = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    self.smiley = [UIImage imageWithContentsOfFile:smileyPath];
    self.smileyView.image = self.smiley;
}


-(void)rotateLabelDown {
    [UIView animateWithDuration:0.5 animations:^{
        //block内设置的动画属性会把某个属性流畅的过度到指定的值，这是所谓的隐式动画
        self.label.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished){
        if (animate) {
            [self rotateLabelUp];
        }
    }];
    
}

-(void)rotateLabelUp {
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        if (animate) {
            [self rotateLabelDown];
        }
    }];
}


@end
