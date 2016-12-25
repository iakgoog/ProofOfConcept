//
//  CanadaCommunicatorDelegate.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 25/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemCommunicatorDelegate

- (void)receivedItemsJSON:(NSData *)objectNotation;
- (void)fetchingItemsFailedWithError:(NSError *)error;

@end
