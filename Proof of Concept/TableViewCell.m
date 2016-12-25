//
//  TableViewCell.m
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (nonatomic, assign) BOOL disSetupConstraints;

@end

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.titleLabel];
        
        self.bodyLabel = [[UILabel alloc] init];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.bodyLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.bodyLabel];
        
        self.iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Beaver"]];
        [self.iconImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.iconImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.iconImage setClipsToBounds:YES];
        [self.iconImage.layer setCornerRadius:5];
        [self.iconImage.layer setMasksToBounds:YES];
        [self.contentView addSubview:self.iconImage];
    }
    
    return self;
}

@end
