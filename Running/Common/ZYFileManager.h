//
//  ZYFileManager.h
//  ZY*
//
//  Created by 査勇 on 15/7/13.
//  Copyright (c) 2015年 查勇的小仓库. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFileManager : NSObject


// 获取Dcument路径
+ (NSString *)getDocumentDirectory;
// 获取Caches路径
+ (NSString *)getCachesDirectory;
// 获取tmp路径
+ (NSString *)getTemporaryDirectory;
// 创建文件夹
+ (BOOL)creatFolderWith:(NSString *)fileName inDirectory:(NSString *)Directory;
// 获取文件夹下子目录
+ (NSArray *)subfilesWithFilePath:(NSString *)filePath;



- (NSString *)seachFileFromeHomeFileName:(NSString *)paramFileName;

- (BOOL)createFilePath:(NSString * )parmFilePath
          saveFileData:(NSData *)fileData
          saveFileName:(NSString *)fileName;

- (NSString *)GetCollection;

- (NSString *)AudioGuide;

- (NSString *)others;

- (NSArray *)getFilePath:(NSString *)Path;

- (NSString *)getTXTfilePath:(NSString *)filePath;

@end
