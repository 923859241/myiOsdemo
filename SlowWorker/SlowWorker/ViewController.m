//
//  ViewController.m
//  SlowWorker
//
//  Created by chen on 2021/7/2.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString*)fetchSomethingFromServer {
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

- (NSString*)processData:(NSString*)data {
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

- (NSString*)calculateFirstResult:(NSString*)data {
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number for chars : %lu",(unsigned long)[data length]];
}

- (NSString*)calculateSecondResult:(NSString*)data {
    [NSThread sleepForTimeInterval:4];
    //使用e替换E
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

- (IBAction)doWork:(id)sender {
    self.resultsTextView.text = @"aaaa";
    NSDate *startTime = [NSDate date];
    self.startButton.enabled = FALSE;
    self.startButton.alpha = 0.5f;
    
    [self.spinner startAnimating];
    //获取一个已经存在的可用的全局队列，第一个参数是优先级
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processedData = [self processData:fetchedData];
        
        __block NSString *firstResult;
        __block NSString *secondResult;
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            firstResult = [self calculateFirstResult:processedData];
        });
        dispatch_group_async(group, queue, ^{
            secondResult = [self calculateSecondResult:processedData];
        });
        dispatch_group_notify(group, queue, ^{
            NSString *resultsSummary = [NSString stringWithFormat:@"First:[%@]\nsecond:[%@]",firstResult,secondResult];
            //非主线程调用UI，必须把任务放在主线程操作。
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultsTextView.text = resultsSummary;
                self.startButton.enabled = TRUE;
                self.startButton.alpha = 1;
                [self.spinner stopAnimating];
            });
        });
        
        NSDate *endTime = [NSDate date];
        NSLog(@"Completed in %f second",[endTime timeIntervalSinceDate:startTime]);
    });
    
    
}


@end
