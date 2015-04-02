//
//  TCSBooksListItem+TCSBooksListCell.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem.h"
#import "TCSBooksListCell.h"

@interface TCSBooksListItem (TCSBooksListCell)

- (void)configureTCSBooksListCell:(TCSBooksListCell *)cell;

@end
