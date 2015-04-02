//
//  TCSBookDetailViewController.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookDetailViewController.h"
#import "TCSBooksListItem+TCSBookDetailThumbnailCell.h"
#import "TCSBooksListItem+TCSBookDetailDescriptionCell.h"
#import "TCSAnalytics.h"

typedef NS_ENUM(NSInteger, TCSBookDetailViewControllerDetailSectionCell)
{
    TCSBookDetailViewControllerDetailSectionCellThumbnail = 0,
    TCSBookDetailViewControllerDetailSectionCellDescription,
    TCSBookDetailViewControllerDetailSectionCellsCount
};

typedef NS_ENUM(NSInteger, TCSBookDetailViewControllerActionsSectionCell)
{
    TCSBookDetailViewControllerActionsSectionCellRead = 0,
    TCSBookDetailViewControllerActionsSectionCellBuy,
    TCSBookDetailViewControllerActionsSectionCellsCount
};


typedef NS_ENUM(NSInteger, TCSBookDetailViewControllerSection)
{
    TCSBookDetailViewControllerSectionDetails = 0,
    TCSBookDetailViewControllerSectionActions,
    TCSBookDetailViewControllerSectionsCount
};

@interface TCSBookDetailViewController () <UIAlertViewDelegate>


@end

@implementation TCSBookDetailViewController

- (void)dealloc
{
#ifdef ANALYTICS

    [TCSAnalytics logEventWithName:TCSEventPreviewBookTime
                     andParameters:@{TCSEventBook : self.booksListItem.volumeInfo.title ? : @"No title!"}
                   startOrEndTimer:NO];
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Book Details";

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
    
#ifdef ANALYTICS
    
    NSDictionary * bookNameDict = @{TCSEventBook : self.booksListItem.volumeInfo.title ? : @"No title!"};
    [TCSAnalytics logEventWithName:TCSEventPreviewBook
                     andParameters:bookNameDict];

    [TCSAnalytics logEventWithName:TCSEventPreviewBookTime
                     andParameters:bookNameDict
                   startOrEndTimer:YES];
    
#endif
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark -
#pragma mark - Helpers

- (NSInteger)numberOfAvailableActions
{
    NSInteger count = 1; // buy

    if (self.booksListItem.accessInfo.webReaderLink.length > 0) //read
    {
        count ++;
    }
    
    return count;
}




#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case TCSBookDetailViewControllerSectionDetails:
                return self.booksListItem.volumeInfo.title;
            break;
        case TCSBookDetailViewControllerSectionActions:
                return @"Actions";
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TCSBookDetailViewControllerSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    switch (section)
    {
        case TCSBookDetailViewControllerSectionDetails:
            count = TCSBookDetailViewControllerDetailSectionCellsCount;
            break;
            
        case TCSBookDetailViewControllerSectionActions:
            count = [self numberOfAvailableActions];
            break;
            
        default:
            break;
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    switch (indexPath.section)
    {
        case TCSBookDetailViewControllerSectionDetails:
            switch (indexPath.row)
            {
                case TCSBookDetailViewControllerDetailSectionCellThumbnail:
                {
                    height = 120;
                }
                    break;
                case TCSBookDetailViewControllerDetailSectionCellDescription:
                {
                    TCSBookDetailDescriptionCell * cell = (TCSBookDetailDescriptionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                    height = [cell heightForTableWidth:tableView.frame.size.width];
                }
                    break;
                default:
                    break;
            }
            break;
            
        case TCSBookDetailViewControllerSectionActions:
            {
                height = 44;
            }
            break;
            
        default:
            break;
    }

    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    switch (indexPath.section)
    {
        case TCSBookDetailViewControllerSectionDetails:
            cell = [self cellForDetailsSectionOfTableView:tableView forRow:indexPath.row];
            break;
        case TCSBookDetailViewControllerSectionActions:
            cell = [self cellForActionsSectionOfTableView:tableView forRow:indexPath.row];
            break;
        default:
            break;
    }
    
    
    return cell;
}




#pragma mark - 
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if (indexPath.section == TCSBookDetailViewControllerSectionActions)
    {
        switch (indexPath.row)
        {
            case TCSBookDetailViewControllerActionsSectionCellBuy:
            {
                NSString * bookTitle = self.booksListItem.volumeInfo.title ? : @"No title!";
                NSString * messageString = [NSString stringWithFormat:@"%@", bookTitle];
                [[[UIAlertView alloc]initWithTitle:@"You are going to buy a book:"
                                           message:messageString
                                          delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:@"Buy", nil] show];
#ifdef ANALYTICS
                [TCSAnalytics logEventWithName:TCSEventBuyBook
                                 andParameters:@{TCSEventBook : bookTitle}];
#endif
            }
                break;
                
            case TCSBookDetailViewControllerActionsSectionCellRead:
            {
#ifdef ANALYTICS
                
                NSDictionary * bookNameDict = @{TCSEventBook : self.booksListItem.volumeInfo.title ? : @"No title!"};
                [TCSAnalytics logEventWithName:TCSEventReadBook
                                 andParameters:bookNameDict];
#endif
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.booksListItem.accessInfo.webReaderLink]];
            }
                break;
                
            default:
                break;
        }
    }
}




#pragma mark - 
#pragma mark - Cells

- (UITableViewCell *)cellForDetailsSectionOfTableView:(UITableView *)tableView forRow:(NSUInteger)row
{
    UITableViewCell * cell = nil;
    
    switch (row)
    {
        case TCSBookDetailViewControllerDetailSectionCellThumbnail:
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCSBookDetailThumbnailCell class])];
            [self.booksListItem configureTCSBookDetailThumbnailCell:(TCSBookDetailThumbnailCell *)cell];
            break;
            
        case TCSBookDetailViewControllerDetailSectionCellDescription:
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCSBookDetailDescriptionCell class])];
            [self.booksListItem configureTCSBookDetailDescriptionCell:(TCSBookDetailDescriptionCell *)cell];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (UITableViewCell *)cellForActionsSectionOfTableView:(UITableView *)tableView forRow:(NSUInteger)row
{
    static NSString * identifier = @"actionsCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    switch (row)
    {
        case TCSBookDetailViewControllerActionsSectionCellRead:
                cell.textLabel.text = @"Read";
            break;
            
        case TCSBookDetailViewControllerActionsSectionCellBuy:
                cell.textLabel.text = @"Buy";
            break;

        default:
            break;
    }
    
    return cell;
}




#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
#ifdef ANALYTICS

        NSString * bookTitle = self.booksListItem.volumeInfo.title ? : @"No title!";
        [TCSAnalytics logEventWithName:TCSEventBuyBookCanceled
                         andParameters:@{TCSEventBook : bookTitle}];

#endif
    }
    else
    {
#ifdef ANALYTICS
        
        NSString * bookTitle = self.booksListItem.volumeInfo.title ? : @"No title!";
        [TCSAnalytics logEventWithName:TCSEventBuyBookSuccessful
                         andParameters:@{TCSEventBook : bookTitle}];
        
        NSString * messageString = [NSString stringWithFormat:@"%@", bookTitle];
        [[[UIAlertView alloc]initWithTitle:@"You successfully bought a book"
                                   message:messageString
                                  delegate:self
                         cancelButtonTitle:@"Oh yes I am!"
                         otherButtonTitles:nil] show];

#endif
    }
}

@end
