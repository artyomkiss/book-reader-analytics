//
//  ViewController.m
//  BookReader
//
//  Created by Artem Kiselev on 10/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSRequestViewController.h"
#import "TCSBooksListViewController.h"
#import "TCSHTTPRequestOperationManager+Requests.h"

@interface TCSRequestViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * activityIndicator;
@property (nonatomic, weak) IBOutlet UITextField * requestField;

@end

@implementation TCSRequestViewController

@synthesize requestField = _requestField;

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef ANALYTICS
    
    [TCSAnalytics logEventWithName:TCSEventStartBookReader];
    
#endif
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark -
#pragma mark - Network

- (void)performSearchRequest
{
    [[[TCSHTTPRequestOperationManager manager]operationQueue]cancelAllOperations];
    
    __weak typeof(self) weakSelf = self;
    NSString * requestString = self.requestField.text;
    __weak UIActivityIndicatorView * activityIndicator = self.activityIndicator;
    [activityIndicator startAnimating];
    
    [[TCSHTTPRequestOperationManager manager] searchForVolumesContainsString:requestString
                                                                  startIndex:nil
                                                                  maxResults:nil
                                                                  completion:^(NSError *error, TCSBooksList *booksList)
    {
        [activityIndicator stopAnimating];
        if (booksList && booksList.items.count > 0)
        {
            [weakSelf openFoundBooksList:booksList];
        }
        else if (error)
        {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]show];
        }
        else
        {
            NSString * message = [NSString stringWithFormat:@"No books for request string \"%@\" were found.", requestString];
            [[[UIAlertView alloc]initWithTitle:@"No books =(" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]show];
        }
    }];
}




#pragma mark -
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:NSStringFromClass([TCSBooksListViewController class])])
    {
        TCSBooksListViewController * booksListVC = segue.destinationViewController;
        NSString * searchString = self.requestField.text;
        booksListVC.requestString = searchString;
        booksListVC.booksList = (TCSBooksList *)sender;
        
#ifdef ANALYTICS
        
        [TCSAnalytics logEventWithName:TCSEventSearchResult
                         andParameters:@{TCSEventTag : searchString}];
        [TCSAnalytics logEventWithName:TCSEventSearchResultTime
                         andParameters:nil
                       startOrEndTimer:YES];
#endif

    }
}


- (void)openFoundBooksList:(TCSBooksList *)booksList
{
    [self performSegueWithIdentifier:NSStringFromClass([TCSBooksListViewController class]) sender:booksList];
}




#pragma mark -
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSearchRequest];
#ifdef ANALYTICS
    
    [TCSAnalytics logEventWithName:TCSEventSearchBook andParameters:@{TCSEventTag : textField.text}];
    
#endif
    
    return YES;
}

@end
