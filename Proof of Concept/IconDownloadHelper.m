//
//  IconDownloadHelper.m
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "IconDownloadHelper.h"
#import "Item.h"

@interface IconDownloadHelper ()

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation IconDownloadHelper

- (void)startDownload {
    
    __weak IconDownloadHelper *weakSelf = self;
    NSURL *url = [NSURL URLWithString:self.item.imageUrl];
    NSLog(@"IconDownloadHelper is dowloading %@", self.item.imageUrl);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    _downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];

        weakSelf.completionHandler(image, error);
    }];
    
    [self.downloadTask resume];
//        [weakSelf.downloadTask resume];
//    });
}

- (void)cancelDownload {
    [self.downloadTask cancel];
    _downloadTask = nil;
}

@end
