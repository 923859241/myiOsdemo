//
//  ViewController.m
//  DialogViewer
//
//  Created by chen on 2021/6/21.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "HeaderCell.h"

@interface ViewController ()
@property(copy, nonatomic) NSArray *sections;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sections = @[
        @{ @"header" : @"First Witch",
           @"content" : @"Hey,When will the three of us meet up later?" },
        @{ @"header" : @"Secont Witch",
           @"content" : @"When everything's staraigtened out" },
        @{ @"header" : @"Third Witch",
           @"content" : @"yes, I do" },
        @{ @"header" : @"First Witch",
           @"content" : @"where?" },
        @{ @"header" : @"Second Witch",
           @"content" : @"okk" },
        @{ @"header" : @"Third Witch",
           @"content" : @"what?" },
    ];
    //这里注册了一个复用的cell
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CONTENT"];
    
    //下述方法 防止因为没有导航栏，主视图会影响到状态栏
    UIEdgeInsets contentInsert = self.collectionView.contentInset;
    contentInsert.top = 20;
    [self.collectionView setContentInset:contentInsert];
    
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)layout;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
    [self.collectionView registerClass:[HeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    flow.headerReferenceSize = CGSizeMake(100, 25);
}
-(NSArray *)wordsInsection:(NSInteger)section {
    //用于把字符串分离为单词
    
    NSString *content = self.sections[section][@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet:space];
    return words;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sections count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //每个分区有多少个条目
    NSArray *words = [self wordsInsection:section];
    return [words count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //通过定义的cell 出队方法返回cell实例
    NSArray *word = [self wordsInsection:indexPath.section];
    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.maxWidth = collectionView.bounds.size.width;
    cell.text = word[indexPath.row];//获取某个section中第row个数据
    cell.label.textColor = [UIColor blackColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsInsection:indexPath.section];
    CGSize size = [CollectionViewCell sizeForContentString:words[indexPath.row] forMaxWidth:collectionView.contentSize.width];
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        HeaderCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        
        cell.maxWidth = collectionView.contentSize.width;
        cell.text = self.sections[indexPath.section][@"header"];
        return cell;
    }
    return nil;
}

@end
