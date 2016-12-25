//
//  Item.h
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;

@end
