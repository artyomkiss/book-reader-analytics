//
//  TCSBookDetailDescriptionCell.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookDetailDescriptionCell.h"
#import "NSString+SizeWithFont.h"

@interface TCSBookDetailDescriptionCell()

@property (weak, nonatomic) IBOutlet UILabel *labelForDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeadingSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTrailingSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpace;

@end

@implementation TCSBookDetailDescriptionCell

- (void)setStringForDescription:(NSString *)stringForDescription
{
    self.labelForDescription.text = (stringForDescription.length > 0) ? stringForDescription : @"No description provided.";
}

- (CGFloat)heightForTableWidth:(CGFloat)tableViewWidth
{
    CGFloat constraintsHeight = self.constraintTopSpace.constant + self.constraintBottomSpace.constant;
    CGFloat constraintsWidth = self.constraintLeadingSpace.constant + self.constraintTrailingSpace.constant;
    CGSize size = [self.labelForDescription.text sizeForLabelWithFont:self.labelForDescription.font constrainedToSize:CGSizeMake(tableViewWidth - constraintsWidth, CGFLOAT_MAX)];

    return size.height + constraintsHeight;
}


@end
