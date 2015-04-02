//
//  TCSBooksListItem+TCSBookDetailDescriptionCell.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem+TCSBookDetailDescriptionCell.h"

@implementation TCSBooksListItem (TCSBookDetailDescriptionCell)

- (void)configureTCSBookDetailDescriptionCell:(TCSBookDetailDescriptionCell *)cell
{
    cell.stringForDescription = self.volumeInfo.bookDescription;
}

@end
