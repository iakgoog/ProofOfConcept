//
//  IconDownloadHelper.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface IconDownloadHelper : NSObject

@property (nonatomic, strong) Item *item;
@property (nonatomic, copy, nonnull) void (^completionHandler)(UIImage * _Nullable, NSError * _Nullable);

- (void)startDownload;
- (void)cancelDownload;

@end
