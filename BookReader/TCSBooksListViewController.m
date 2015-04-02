//
//  TCSBooksListViewController.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListViewController.h"
#import "TCSBooksListCell.h"
#import "TCSBooksListItem+TCSBooksListCell.h"
#import "TCSHTTPRequestOperationManager+Requests.h"
#import "TCSBookDetailViewController.h"


typedef NS_ENUM(NSInteger, TCSBookListViewControllerState)
{
    TCSBookListViewControllerStateBooksPartiallyLoaded = 0,
    TCSBookListViewControllerStateBooksPartiallyLoadedAndLoadingMore,
    TCSBookListViewControllerStateAllBooksAreLoaded
};

@interface TCSBooksListViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel * labelLoadedInfo;
@property (nonatomic, weak) IBOutlet UIButton * loadMoreButton;

@property (nonatomic, readwrite) TCSBookListViewControllerState state;

@end

@implementation TCSBooksListViewController

@synthesize booksList = _booksList;
@synthesize requestString = _requestString;

- (void)dealloc
{
#ifdef ANALYTICS
    
    [TCSAnalytics logEventWithName:TCSEventSearchResultTime
                     andParameters:@{@"Searched" : _requestString ? : @""}
                   startOrEndTimer:NO];
    
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self determineState];
    
#ifdef GOOGLE
    // returns the same tracker you created in your app delegate
    // defaultTracker originally declared in AppDelegate.m
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:NSStringFromClass([self class])];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [tracker set:kGAIScreenName value:nil];
#endif
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark -
#pragma mark - Setters

- (void)setRequestString:(NSString *)requestString
{
    _requestString = requestString;
    self.title = [NSString stringWithFormat:@"Results for \"%@\"", _requestString];
}




#pragma mark -
#pragma mark - States

- (void)determineState
{
    if (self.state != TCSBookListViewControllerStateBooksPartiallyLoadedAndLoadingMore)
    {
        if ([self.booksList allBookLoaded])
        {
            [self setState:TCSBookListViewControllerStateAllBooksAreLoaded];
        }
        else
        {
            [self setState:TCSBookListViewControllerStateBooksPartiallyLoaded];
        }
    }
}

- (void)setState:(TCSBookListViewControllerState)state
{
    switch (state)
    {
        case TCSBookListViewControllerStateBooksPartiallyLoaded:
        {
            self.labelLoadedInfo.text = [NSString stringWithFormat:@"Loaded books: %lu/%ld", (unsigned long)self.booksList.items.count, (long)self.booksList.totalItems.integerValue];
            [self.activityIndicator stopAnimating];
            [self.loadMoreButton setHidden:NO];
        }
            break;
            
        case TCSBookListViewControllerStateBooksPartiallyLoadedAndLoadingMore:
        {
            [self.activityIndicator startAnimating];
            [self.loadMoreButton setHidden:YES];
        }
            break;
            
        case TCSBookListViewControllerStateAllBooksAreLoaded:
        {
            self.labelLoadedInfo.text = [NSString stringWithFormat:@"All %ld books are loaded", (long)self.booksList.totalItems.integerValue];
            [self.activityIndicator stopAnimating];
            [self.loadMoreButton setHidden:YES];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark -
#pragma mark - Actions

- (IBAction)loadMoreButtonTapped:(id)sender
{
    [self loadMoreBooks];
}



#pragma mark - 
#pragma mark - Networking

- (void)loadMoreBooks
{
    __weak typeof(self) weakSelf = self;
    NSString * requestString = _requestString;

    [self setState:TCSBookListViewControllerStateBooksPartiallyLoadedAndLoadingMore];
    
    [[TCSHTTPRequestOperationManager manager] searchForVolumesContainsString:requestString
                                                                  startIndex:@(self.booksList.items.count)
                                                                  maxResults:nil
                                                                  completion:^(NSError *error, TCSBooksList *booksList)
     {
         __strong typeof(weakSelf) strongSelf = weakSelf;
         
         if (booksList && booksList.items.count > 0 && strongSelf)
         {
             [strongSelf.booksList appendBooksList:booksList];
             [strongSelf.tableView reloadData];
         }
         else if (error)
         {
             [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]show];
         }
         
         [weakSelf determineState];
     }];

}



#pragma mark -
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksList.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCSBooksListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCSBooksListCell class]) forIndexPath:indexPath];
    
    TCSBooksListItem * item = self.booksList.items[indexPath.row];
    [item configureTCSBooksListCell:cell];
    
    return cell;
}




#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bookDetail"])
    {
        UITableViewCell * cell = sender;
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        TCSBooksListItem * item = self.booksList.items[indexPath.row];
        TCSBookDetailViewController * detailViewController =(TCSBookDetailViewController *)segue.destinationViewController;
        detailViewController.booksListItem = item;
        
#ifdef ANALYTICS
        
        [TCSAnalytics logEventWithName:TCSEventSelectBook
                         andParameters:@{TCSEventBook : item.volumeInfo.title ? : @"No title"}];
        
#endif
    }
}



@end
