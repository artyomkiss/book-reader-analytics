//
//  TCSBooksListViewController.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCSBooksList.h"
#import "TCSAnalytics.h"

@interface TCSBooksListViewController : UITableViewController

@property (nonatomic, strong) TCSBooksList * booksList;
@property (nonatomic, strong) NSString * requestString;

- (IBAction)loadMoreButtonTapped:(id)sender;

@end
