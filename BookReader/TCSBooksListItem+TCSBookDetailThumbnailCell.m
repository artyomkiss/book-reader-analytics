//
//  TCSBooksListItem+TCSBookDetailThumbnailCell.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem+TCSBookDetailThumbnailCell.h"

@implementation TCSBooksListItem (TCSBookDetailThumbnailCell)

- (void)configureTCSBookDetailThumbnailCell:(TCSBookDetailThumbnailCell *)cell
{
    cell.stringForSubtitle = self.volumeInfo.subtitle;
    cell.stringForPublisher = self.volumeInfo.publisher;
    cell.stringForDate = self.volumeInfo.publishedDate;
    cell.stringForAuthors = self.volumeInfo.authorsString;
    cell.stringForimageThumbnailURL = self.volumeInfo.imageLinks.thumbnail;
}

@end
