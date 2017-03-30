//
//  PointsMallCollectionViewController.m
//  Running
//
//  Created by Zhayong on 19/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "PointsMallCollectionViewController.h"
#import "PointsMallCollectionViewCell.h"
#import "UserInfoModel.h"

@interface PointsMallCollectionViewController ()<PointsMallCollectionViewCellDelegete>

@property (nonatomic, strong) NSArray *images;

@end

@implementation PointsMallCollectionViewController

static NSString * const reuseIdentifier = @"pointsMallCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _images = @[@"0",@"1",@"2",@"3"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // 注册UICollectionView
    [self.collectionView registerNib:[UINib nibWithNibName:@"PointsMallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UICollectionViewDelegateFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return CGSizeMake(112, 174);
//}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Register cell classes
//    [self.collectionView registerClass:[PointsMallCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    PointsMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.goodsImage.image = [UIImage imageNamed:_images[indexPath.row]];
    cell.imageName = _images[indexPath.row];
    cell.PointsMallCollectionViewCellDelegete = self;
    // Configure the cell
    
    return cell;
}

#pragma mark -- PointsMallCollectionViewCellDelegete

- (void)selectPointsMallCollectionViewCell:(PointsMallCollectionViewCell *)pointsMallCollectionViewCell
{
   
    // 取出不变数组转换成可变数组 NSUserDefaults存储的默认都是不变数组
    NSMutableArray *images = [NSMutableArray arrayWithArray:[UserInfoModel shareUserInfo].goods];
    
     // 添加图片
    [images addObject:pointsMallCollectionViewCell.imageName];
    
    // 存储图片
    [UserInfoModel shareUserInfo].goods = images;
    [[UserInfoModel shareUserInfo] saveData];
    
    UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:nil message:@"兑换成功!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alerVc addAction:ok];
    
    [self presentViewController:alerVc animated:YES completion:^{
        
    }];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
