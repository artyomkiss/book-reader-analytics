//
//  TCSBookDetailThumbnailCell.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookDetailThumbnailCell.h"
#import "UIImageView+AFNetworking.h"

@interface TCSBookDetailThumbnailCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewForThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *labelForSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *labelForAuthors;
@property (weak, nonatomic) IBOutlet UILabel *labelForPublisher;
@property (weak, nonatomic) IBOutlet UILabel *labelForDate;

@end

@implementation TCSBookDetailThumbnailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



#pragma mark -
#pragma mark - Setter

- (void)setStringForimageThumbnailURL:(NSString *)imageThumbnailURLString
{
    [self.imageViewForThumbnail setImageWithURL:[NSURL URLWithString:imageThumbnailURLString] placeholderImage:nil];
}

- (void)setStringForSubtitle:(NSString *)stringForSubtitle
{
    self.labelForSubtitle.text = stringForSubtitle;
}

- (void)setStringForAuthors:(NSString *)stringForAuthors
{
    self.labelForAuthors.text = stringForAuthors;
}

- (void)setStringForPublisher:(NSString *)stringForPublisher
{
    self.labelForPublisher.text = stringForPublisher;
}

- (void)setStringForDate:(NSString *)stringForDate
{
    self.labelForDate.text = stringForDate;
}


@end
