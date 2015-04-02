//
//  TCSBooksListCell.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListCell.h"
#import "UIImageView+AFNetworking.h"

@interface TCSBooksListCell()

@property (weak, nonatomic) IBOutlet UILabel *labelForTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelForAuthors;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForThumbnail;

@end

@implementation TCSBooksListCell

@synthesize imageThumbnailURLString = _imageThumbnailURLString;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}




#pragma mark -
#pragma mark - Getters

- (NSString *)authorsString
{
    return self.labelForAuthors.text;
}

- (NSString *)bookTitleString
{
    return self.labelForTitle.text;
}

- (NSString *)imageThumbnailURLString
{
    return _imageThumbnailURLString;
}




#pragma mark -
#pragma mark - Setters

- (void)setImageThumbnailURLString:(NSString *)imageThumbnailURLString
{
    _imageThumbnailURLString = imageThumbnailURLString;
    [self.imageViewForThumbnail setImageWithURL:[NSURL URLWithString:_imageThumbnailURLString] placeholderImage:nil];
}

- (void)setBookTitleString:(NSString *)bookTitleString
{
    self.labelForTitle.text = bookTitleString;
}

- (void)setAuthorsString:(NSString *)authorsString
{
    self.labelForAuthors.text = authorsString;
}

@end
