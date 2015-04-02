//
//  TCSBookDetailViewController.h
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCSBooksListItem.h"
#import "TCSAnalytics.h"

@interface TCSBookDetailViewController : UITableViewController

@property (nonatomic, strong) TCSBooksListItem * booksListItem;

@end
