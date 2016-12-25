//
//  ItemManagerDelegate.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemManagerDelegate

- (void)didReceiveItems:(NSArray *)items title:(NSString *)title;
- (void)fetchItemsFailedWithError:(NSError *)error;

@end
