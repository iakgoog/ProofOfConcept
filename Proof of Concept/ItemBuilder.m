//
//  ItemBuilder.m
//  NavTest
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "ItemBuilder.h"
#import "Item.h"

@implementation ItemBuilder

+ (NSDictionary *)parseData:(NSData *)data error:(NSError **)error {
    NSString *encodedString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSData *reEncodedData = [encodedString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *JSONError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:reEncodedData options:0 error:&JSONError];
    
    if (JSONError) {
        *error = JSONError;
        return nil;
    }
    
    return parsedObject;
}

+ (NSArray *)itemsFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [self parseData:objectNotation error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSArray *rows = [parsedObject valueForKey:@"rows"];
    
    for (NSDictionary *itemDic in rows) {
        Item *item = [[Item alloc] init];
        
        BOOL isTitleNull = [itemDic[@"title"] isKindOfClass:[NSNull class]];
        BOOL isDescriptionNull = [itemDic[@"description"] isKindOfClass:[NSNull class]];
        BOOL isImageNull = [itemDic[@"imageHref"] isKindOfClass:[NSNull class]];
        
        if (isTitleNull && isDescriptionNull && isImageNull) {
            continue;
        }
        
        NSString *titleText = (isTitleNull) ? @"" : itemDic[@"title"];
        NSString *descriptionText = (isDescriptionNull) ? @"" : itemDic[@"description"];
        NSString *imageUrl = (isImageNull) ? @"" : itemDic[@"imageHref"];
        
        [item setTitle:titleText];
        [item setDescriptionText:descriptionText];
        [item setImageUrl:imageUrl];
        
        [items addObject:item];
    }
    
    return items;
    
}

+ (NSString *)titleFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [self parseData:objectNotation error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSString *title = [parsedObject valueForKey:@"title"];
    
    return title;
    
}

@end
