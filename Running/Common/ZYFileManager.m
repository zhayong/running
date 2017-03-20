//
//  ZYFileManager.m
//  ZY*
//
//  Created by 査勇 on 15/7/13.
//  Copyright (c) 2015年 查勇的小仓库. All rights reserved.
//

#import "ZYFileManager.h"

@implementation ZYFileManager

+ (NSString *)getDocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getTemporaryDirectory
{
    return NSTemporaryDirectory();
}

+ (BOOL)creatFolderWith:(NSString *)fileName inDirectory:(NSString *)Directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",Directory,fileName];
    if([fileManager fileExistsAtPath:filePath]){
        // 如果文件夹存
        return YES;
    }
    else{
        // 如果不存在
        NSError *error;
        BOOL success = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if(success){
            // 创建成功
            NSLog(@"%@",filePath);
            return YES;
        }
        else{
            // 创建失败
            NSLog(@"%@",error);
            return NO;
        }
    }

}

+ (NSArray *)subfilesWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager subpathsAtPath:filePath];
}


- (NSString *)seachFileFromeHomeFileName:(NSString *)paramFileName
{
    
    NSString *homeDir =  [ZYFileManager getDocumentDirectory];
    NSFileManager* fm=[NSFileManager defaultManager];
    NSArray *files = [fm subpathsAtPath:homeDir ];
    for(NSString *eachFilePath in files)
    {
        
        if([eachFilePath hasSuffix:paramFileName])
        {
            return [NSString stringWithFormat:@"%@/%@",[ZYFileManager getDocumentDirectory],eachFilePath];
        }
        
    }
    return nil;
    
}

- (BOOL)createFilePath:(NSString * )parmFilePath
          saveFileData:(NSData *)fileData
          saveFileName:(NSString *)fileName
{
    parmFilePath = [NSString stringWithFormat:@"%@%@",[ZYFileManager getDocumentDirectory],parmFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:parmFilePath]) //如果不存在
    {
        NSError *err;
        if( ![fileManager createDirectoryAtPath:parmFilePath withIntermediateDirectories:YES attributes:nil error:&err])
        {
            return NO;
        }
        
        if(![fileData writeToFile:[NSString stringWithFormat:@"%@/%@",parmFilePath,fileName] atomically:YES])
        {
            return NO;
        }
        return YES;
    }else
    {
        NSError *err;
        
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",parmFilePath,fileName] error:&err];
        
        if(![fileData writeToFile:[NSString stringWithFormat:@"%@/%@",parmFilePath,fileName] atomically:YES])
        {
            return NO;
        }
    }
    return YES;
}

- (NSString *)GetCollection
{
    NSLog(@"%@",[ZYFileManager getDocumentDirectory]);
    
    return [NSString stringWithFormat:@"%@/HenanMuseum/Collections/",[ZYFileManager getDocumentDirectory]];
}

- (NSString *)AudioGuide
{
    return [NSString stringWithFormat:@"%@/HenanMuseum/AudioGuide/",[ZYFileManager getDocumentDirectory]];
}


- (NSString *)others
{
    return [NSString stringWithFormat:@"%@/HenanMuseum/others/",[ZYFileManager getDocumentDirectory]];
}

- (NSArray *)getFilePath:(NSString *)Path
{
    NSFileManager* fm=[NSFileManager defaultManager];
    NSArray *files = [fm subpathsAtPath:Path];
    return files;
}

- (NSString *)getTXTfilePath:(NSString *)filePath
{
    NSError *error ;
    NSString *getFileData = [[NSString alloc]initWithContentsOfFile:filePath encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:&error];
    
    if(getFileData == nil)
    {
        getFileData = [NSString stringWithContentsOfFile:filePath
                                                encoding:NSUTF8StringEncoding
                                                   error: & error];
        
        
    }
    
    return getFileData;
    
    
}


@end
