//
//  PublishViewController.m
//  Running
//
//  Created by Zhayong on 20/03/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "PublishViewController.h"

#import "ZYInputView.h"
#import "ZYTableViewCell.h"
#import "ZYPhonePickerView.h"

#import "TZImagePickerController.h"
#import "ZYEditImageViewController.h"

#import "SDTimeLineCellModel.h"
#import <MJExtension/MJExtension.h>

#import "ZYFileManager.h"

#import "UserInfoModel.h"

#define IMAGE_SIZE (SCREEN_WIDTH - 60)/4

@interface PublishViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

/** 文本输入框*/
@property(nonatomic, strong) ZYInputView *inputV;
/** UITableView*/
@property(nonatomic, strong) UITableView *tabelV;
/** 选择图片*/
@property(nonatomic, strong) ZYPhonePickerView *photoPickerV;
/** 图片编辑起*/
@property(nonatomic, strong) ZYEditImageViewController *editVC;
/** 当前选择的图片*/
@property(nonatomic, strong) NSMutableArray *imageDataSource;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}

// 为图片添加点击事件
- (void)addTargetForImage{
    for (UIButton * button in _photoPickerV.imageViews) {
        [button addTarget:self action:@selector(addPhotos:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// 生成随记字符串
- (NSString *)ret32bitString

{
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

-(void)rightBarButtonItemAction{
    
    NSMutableArray *imageNames = [NSMutableArray array];
    // 将图片存储到缓存
    NSLog(@"%@",_imageDataSource);
    
    // 获取缓存路径
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // 写入
    for(NSInteger i=0;i<_imageDataSource.count - 1;i++){
        UIImage *image = _imageDataSource[i];
        
        // 生成随记图片名
        NSString *imageName = [self ret32bitString];
        
        //指定文件名
        NSString *filePath = [cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%@.png",imageName]];
        
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        
        [imageNames addObject:filePath];
    }
    //
    
    // 构建数据模型
    SDTimeLineCellModel *model = [SDTimeLineCellModel new];
    // 绑定数据
    model.isOpening = NO;
    model.iconName = [UserInfoModel shareUserInfo].profileImageName;
    model.name = [UserInfoModel shareUserInfo].nickname;
    model.msgContent = _inputV.textV.text;
    model.picNamesArray = imageNames;
    model.likeItemsArray = [NSArray array];
    model.commentItemsArray = [NSArray array];
    model.liked = NO;
    
    // 模型转字典
    [SDTimeLineCellModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"likeItemsArray" : @"SDTimeLineCellLikeItemModel",
                 @"commentItemsArray" : @"SDTimeLineCellCommentItemModel",
                 @"picNamesArray" : @"NSArray"
                 };
    }];
    
    NSMutableDictionary *data = model.mj_keyValues;
    
    // 获取文档目录
    NSString *docDir = [ZYFileManager getDocumentDirectory];
    
    //取得目标文件路径
    NSString *plistPath = [docDir stringByAppendingPathComponent:@"apertureData.plist"];
    
    // 读取plist
    NSMutableArray *apertureData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    // 增添数据
    [apertureData addObject:data];
    
    // 写入plist
    [apertureData writeToFile:plistPath atomically:YES];
    
    NSLog(@"%@",apertureData);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewConfig{
    
    self.title = @"发布到圈子";
    
     UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    __weak typeof(self) weakSelf = self;
    //不自动调整滚动视图的预留空间
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    // 初始化输入视图
    _inputV = [[ZYInputView alloc]init];
    _inputV.textV.delegate = self;
    
    // 图片选择视图
    _photoPickerV = [[ZYPhonePickerView alloc]init];
    _photoPickerV.frame = CGRectMake(0, _inputV.frame.size.height +10, SCREEN_WIDTH, IMAGE_SIZE);
    _photoPickerV.reloadTableViewBlock = ^{
        [weakSelf.tabelV reloadData];
    };
    [self addTargetForImage];
    
    // 初始化图片数组
    _imageDataSource = [NSMutableArray array];
    [_imageDataSource addObject:_photoPickerV.addImage];
    
    // 初始化图片编辑控制器
    self.editVC = [[ZYEditImageViewController alloc]init];
    
    
    _tabelV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tabelV.delegate = self;
    _tabelV.dataSource = self;
    [self.view addSubview:_tabelV];
    
}

- (void)addPhotos:(UIButton *)button{
    
    __weak typeof(self) weakSelf = self;
    
    if ([button.currentBackgroundImage isEqual:_photoPickerV.addImage]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 - _imageDataSource.count delegate:self];
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
            [_imageDataSource removeLastObject];
            [_imageDataSource addObjectsFromArray:photos];
            [_imageDataSource addObject:_photoPickerV.addImage];
            [self.photoPickerV setSelectedImages:_imageDataSource];
            [self addTargetForImage];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        _editVC = [[ZYEditImageViewController alloc]init];
        _editVC.currentOffset = (int)button.tag;
        _editVC.reloadBlock = ^(NSMutableArray * images){
            [weakSelf.photoPickerV setSelectedImages:images];
            [weakSelf addTargetForImage];
        };
        _editVC.images = _imageDataSource;
        [self.navigationController pushViewController:_editVC animated:YES];
    }
}

#pragma mark --------------UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        [_inputV.placeholerLabel removeFromSuperview];
    }else{
        [_inputV.textV addSubview:_inputV.placeholerLabel];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTableViewCell";
    static NSString * reuseID1 = @"UITableViewCell";
    
    ZYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:reuseID1];
    if (!cell || !cell1) {
        cell = [[ZYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID1];
    }
    
    if (indexPath.row) {
        cell1.textLabel.text = @"所在位置";
        return cell1;
    }else{
        [cell addSubview:_inputV];
        [cell addSubview:_photoPickerV];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = _photoPickerV.frame.size.height + _photoPickerV.frame.origin.y + 10;
    if (!indexPath.row) return rowHeight;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

#pragma mark --------------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabelV deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark --------------SystemVCDelegate
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_inputV.textV becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_inputV.textV resignFirstResponder];
}

@end
