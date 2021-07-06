//
//  ViewController.m
//  Persistence
//
//  Created by chen on 2021/6/24.
//

#import "ViewController.h"
#import "Favourites.h"

static NSString * const kRootKey = @"kRootKey";

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {

    }
    
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Favourites *fourLines = [unarchiver decodeObjectForKey:kRootKey];
    [unarchiver finishDecoding];
    
    for (int i = 0; i < 3; i++) {
        UITextField *theField = self.lineFields[i];
        theField.text = fourLines.lines[i];
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (NSString *)dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];
}

//应用应该在停止运行或者在进入后台之前保存数据，既应用不再与当前用户进行交互的时候发布的通知
-(void)applicationWillResignActive:(NSNotification *)notification {
    NSString *filePath = [self dataFilePath];
    
    Favourites *fourLines = [[Favourites alloc]init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc]init];
    //当归档一组对象时，归档程序将每个对象的类信息和实例变量写入归档文件
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kRootKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
}

@end
