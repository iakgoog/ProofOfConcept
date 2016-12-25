//
//  ItemManager.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemManagerDelegate.h"
#import "ItemCommunicatorDelegate.h"

@class ItemCommunicator;

@interface ItemManager : NSObject <ItemCommunicatorDelegate>

@property (strong, nonatomic) ItemCommunicator *communicator;
@property (weak, nonatomic) id<ItemManagerDelegate> delegate;

- (void)fetchItems:(NSString *)urlString;

@end
