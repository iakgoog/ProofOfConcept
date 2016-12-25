//
//  TableViewCell.m
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

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
        
        self.iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CanadaFlagBW.jpg"]];
        [self.iconImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.iconImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.iconImage setClipsToBounds:YES];
        [self.iconImage.layer setCornerRadius:5];
        [self.iconImage.layer setMasksToBounds:YES];
        [self.contentView addSubview:self.iconImage];
        
        [self updateConstraints];
    }
    
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (self.didSetupConstraints) return;
    
    // Get the views dictionary
    NSDictionary *viewsDictionary = @{
                                      @"titleLabel" : self.titleLabel,
                                      @"bodyLabel" : self.bodyLabel,
                                      @"iconImage" : self.iconImage
                                      };
    
    CGFloat standardSize = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat imageWidth = standardSize - 20;
    CGFloat titleLabelHeight = 20.0;
    CGFloat minBodyLabelHeight = standardSize - (10.0 * 3.0f) - 20;
    
    NSDictionary *metrics = @{
                              @"imageWidth": @(imageWidth),
                              @"titleLabelHeight": @(titleLabelHeight),
                              @"minBodyLabelHeight": @(minBodyLabelHeight)
                              };
    
    NSString *format;
    NSArray *constraintsArray;
    
    //Create the constraints using the visual language format
    format = @"V:|-10-[titleLabel(titleLabelHeight)]-10-[bodyLabel(>=minBodyLabelHeight)]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    format = @"V:|-10-[iconImage(imageWidth@1000)]-10@250-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    format = @"|-10-[iconImage(imageWidth@1000)]-10-[titleLabel]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:NSLayoutFormatAlignAllTop metrics:metrics views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    format = @"|-10-[iconImage(imageWidth@1000)]-10-[bodyLabel]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    self.didSetupConstraints = YES;
}

@end
