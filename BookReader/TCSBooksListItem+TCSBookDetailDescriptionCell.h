//
//  TCSBooksListItem+TCSBookDetailDescriptionCell.h
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem.h"
#import "TCSBookDetailDescriptionCell.h"

@interface TCSBooksListItem (TCSBookDetailDescriptionCell)

- (void)configureTCSBookDetailDescriptionCell:(TCSBookDetailDescriptionCell *)cell;

@end
