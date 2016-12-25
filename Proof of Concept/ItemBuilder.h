//
//  ItemBuilder.h
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemBuilder : NSObject

+ (NSDictionary *)parseData:(NSData *)data error:(NSError **)error;
+ (NSArray *)itemsFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSString *)titleFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
