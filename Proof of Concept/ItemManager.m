//
//  ItemManager.m
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "ItemManager.h"
#import "ItemBuilder.h"
#import "ItemCommunicator.h"

@implementation ItemManager

- (void)fetchItems:(NSString *)urlString {
    [self.communicator getCanadaInformation:urlString];
}

#pragma mark - ItemCommunicatorDelegate

- (void)receivedItemsJSON:(NSData *)objectNotation {
    NSError *error = nil;
    NSArray *items = [ItemBuilder itemsFromJSON:objectNotation error:&error];
    NSString *title = [ItemBuilder titleFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchItemsFailedWithError:error];
    } else {
        [self.delegate didReceiveItems:items title:title];
    }
}

- (void)fetchingItemsFailedWithError:(NSError *)error {
    [self.delegate fetchItemsFailedWithError:error];
}

@end
