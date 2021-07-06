//
//  ViewController.m
//  UseCoreData
//
//  Created by chen on 2021/6/24.
//

#import "ViewController.h"
#import "AppDelegate.h"

static NSString * const kLineEntityName = @"Line";
static NSString * const kLineNumberKey = @"lineNumber";
static NSString * const kLinerTextKey = @"lineText";


@interface ViewController ()

@property(strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    
    //使用该方法获取context
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;

    //创建一个请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
    
    NSError *error = nil;
    //传递请求检索
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil || [objects count] <= 0) {
        NSLog(@"Error!!");
    } else {
        for (NSObject *oneObject in objects) {
            //逐个进行处理
            int lineNum = [[oneObject valueForKey:kLineNumberKey ] intValue];
            NSString *lineText = [oneObject valueForKey:kLinerTextKey];
            
            UITextField *theField = self.lineFields[lineNum];
            theField.text = lineText;
        }
    }

    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
}

-(void)applicationWillResignActive:(NSNotification*)notification {
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;

    //使用该方法获取context
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;

    NSError *error = nil;
    for (int i = 0; i < 4; i++) {
        UITextField *theField = self.lineFields[i];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"(%K = %d)", kLineNumberKey, i];
        [request setPredicate:pre];
        
        NSArray *object = [context executeFetchRequest:request error:&error];
        
        if (object != nil) {
            NSLog(@"error!!");
            
        }
        
        NSManagedObject *theLine = nil;
        if ([object count] > 0) {
            theLine = [object objectAtIndex:0];
        } else {
            theLine = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName inManagedObjectContext:context];
        }
        
        [theLine setValue:[NSNumber numberWithInt:i] forKey:kLineNumberKey];
        [theLine setValue:theField.text forKey:kLinerTextKey];
        
    }
    
    [context save:&error];
}


@end
