//
//  TCSBookListItem+TCSBooksListCell.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem+TCSBooksListCell.h"


@implementation TCSBooksListItem (TCSBooksListCell)

- (void)configureTCSBooksListCell:(TCSBooksListCell *)cell
{
    cell.bookTitleString = self.volumeInfo.title;
    cell.authorsString = self.volumeInfo.authorsString;
    cell.imageThumbnailURLString = self.volumeInfo.imageLinks.smallThumbnail;
}

@end
