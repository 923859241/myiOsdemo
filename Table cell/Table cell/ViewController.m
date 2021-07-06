//
//  ViewController.m
//  Table cell
//
//  Created by chen on 2021/6/19.
//

#import "ViewController.h"
#import "NameAndColorCell.h"

static NSString *CellTableIdentifier = @"CellTableIdentifider";

@interface ViewController ()

@property (copy, nonatomic) NSArray *computers;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.computers = @[@{@"Name" : @"MacBook Air",@"Color" : @"Silver"},
                       @{@"Name" : @"MacBook Pro",@"Color" : @"Silver"},
                       @{@"Name" : @"iMac",@"Color" : @"Silver"},
                       @{@"Name" : @"Mac mini",@"Color" : @"Silver"},
                       @{@"Name" : @"Mac Pro",@"Color" : @"Black"}];
    
    [self.tabelView registerClass:[NameAndColorCell class] forCellReuseIdentifier:CellTableIdentifier];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.computers count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    NSDictionary *rowData = self.computers[indexPath.row];
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    NSLog(@"pring cell:%@",cell.name);
    return cell;
    
}


@end
