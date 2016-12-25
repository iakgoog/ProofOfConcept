//
//  CanadaCommunicator.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 25/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemCommunicatorDelegate;

@interface ItemCommunicator : NSObject

@property (weak, nonatomic) id<ItemCommunicatorDelegate> delegate;

- (void)getCanadaInformation:(NSString *)urlString;

@end
