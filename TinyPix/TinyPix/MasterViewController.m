//
//  MasterViewController.m
//  TinyPix
//
//  Created by chen on 2021/6/26.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TinyPixDocument.h"
#import "TinyPixUtils.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
@property (strong, nonatomic) NSArray *documentFilenames;
@property (strong, nonatomic) TinyPixDocument *chosenDocument;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger selectedColorIndex = [prefs integerForKey:@"selectedColorIndex"];
    [self setTintColorForIndex:selectedColorIndex];
    [self.colorControl setSelectedSegmentIndex:selectedColorIndex];
    
    [self reloadFiles];
}

-(void)insertNewObject {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choosw File Name" message:@"Enter a name for your new TinyPix document" preferredStyle:UIAlertControllerStyleAlert];
    //调用此方法将向警报添加一个可编辑的文本字段,只有当preferredStyle属性设置为UIAlertControllerStyleAlert时，才能添加文本字段
    [alert addTextFieldWithConfigurationHandler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"create" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = (UITextField*)alert.textFields[0];
        [self createFileNamed:textField.text];
    }];
    [alert addAction:cancelAction];
    [alert addAction:createAction];
    
    [self presentViewController:alert animated:TRUE completion:nil];
    
}

- (void)createFileNamed:(NSString*)filename {
    NSString *trimedFileName = [filename stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimedFileName.length > 0) {
        NSString *targetName = [NSString stringWithFormat:@"%@.tinyPix",trimedFileName];
        NSURL *saveURL = [self urlForFilename:targetName];
        self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:saveURL];
        [self.chosenDocument saveToURL:saveURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"save OK");
                [self reloadFiles];
                [self performSegueWithIdentifier:@"masterToDetail" sender:self];
            } else {
                NSLog(@"filed to save!");
            }
        }];
    }
    
}

- (NSURL*)urlForFilename:(NSString*)filename {
    NSFileManager *fm = [NSFileManager defaultManager];
    //NSUserDomainMask : 用户的主目录—安装用户个人项目的地方
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directorURL = urls[0];
    //在原始用户document 的URL后面插入filename变成一个新的URL
    NSURL *fileURL = [directorURL URLByAppendingPathComponent:filename];
    return fileURL;
}

- (void)reloadFiles {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *dirError = nil;
    //对指定的目录执行浅搜索，并返回包含的所有项的路径。
    NSArray *files = [fm contentsOfDirectoryAtPath:path error:&dirError];
    if (!files) {
        NSLog(@"error!");
    }
    NSLog(@"found files: %@", files);
    
    files = [files sortedArrayUsingComparator:^NSComparisonResult(id filename1, id filename2) {
        NSDictionary *attr1 = [fm attributesOfItemAtPath:[path stringByAppendingPathComponent:filename1] error:nil];
        NSDictionary *attr2 = [fm attributesOfItemAtPath:[path stringByAppendingPathComponent:filename2] error:nil];
        
        return [attr2[NSFileCreationDate] compare:attr1[NSFileCreationDate]];
        
    }];
    self.documentFilenames = files;
    [self.myTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *destination = (UINavigationController *)segue.destinationViewController;
    DetailViewController *detailVC = (DetailViewController *)destination.topViewController;
    if (sender == self) {
        //如果等于self 说明新建了一个文档 而且chosenDocumnet设置好了
        detailVC.detailItem = self.chosenDocument;
    } else {
        //查找表示图中的文档
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        NSString *fileName = self.documentFilenames[indexPath.row];
        NSURL *docUrl = [self urlForFilename:fileName];
        self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:docUrl];
        [self. chosenDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"load OK");
                detailVC.detailItem = self.chosenDocument;
                
            } else {
                NSLog(@"failed to load");
            }
        }];
    }
}

#pragma table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.documentFilenames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    NSString *path = self.documentFilenames[indexPath.row];
    cell.textLabel.text = path.lastPathComponent.stringByDeletingPathExtension;
    return cell;
}

-(IBAction)chooseColor:(id)sender {
    NSInteger selectedColorIndex = [(UISegmentedControl *)sender selectedSegmentIndex];//UISegmentedControl 分段控件。可以显示图片文字等并自动适配大小
    [self setTintColorForIndex:selectedColorIndex];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:selectedColorIndex forKey:@"selectedColorIndex"];
    [prefs synchronize];
}
-(void)setTintColorForIndex:(NSInteger)selectedColorIndex {
    self.colorControl.tintColor = [TinyPixUtils getTintColorForIndex:selectedColorIndex];
}

@end
