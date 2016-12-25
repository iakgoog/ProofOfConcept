//
//  TableViewCell.h
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *iconImage;

@end
