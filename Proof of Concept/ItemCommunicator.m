//
//  CanadaCommunicator.m
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 25/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "ItemCommunicator.h"
#import "ItemCommunicatorDelegate.h"

@implementation ItemCommunicator

- (void)getCanadaInformation:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                [self.delegate fetchingItemsFailedWithError:error];
            } else {
                [self.delegate receivedItemsJSON:data];
            }
        }];
        
        [dataTask resume];
    });

}

@end
