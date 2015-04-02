//
//  TCSBookInfo.m
//  BookReader
//
//  Created by Artem Kiselev on 13/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookInfo.h"
#import "TCSNetworkObjectsConstants.h"

@implementation TCSBookInfo

- (void)clearAllProperties
{
    _title = nil;
    _subtitle = nil;
    _authors = nil;
    _authorsString = nil;
    _imageLinks = nil;
}

- (NSString *)title
{
    if (!_title)
    {
        _title = _dictionary[kTitle];
    }
    
    return _title;
}

- (NSString *)subtitle
{
    if (!_subtitle)
    {
        _subtitle = _dictionary[kSubtitle];
    }
    
    return _subtitle;
}

- (NSString *)publisher
{
    if (!_publisher)
    {
        _publisher = _dictionary[kPublisher];
    }
    
    return _publisher;
}

- (NSString *)publishedDate
{
    if (!_publishedDate)
    {
        _publishedDate = _dictionary[kPublishedDate];
    }
    
    return _publishedDate;
}

- (NSString *)bookDescription
{
    if (!_bookDescription)
    {
        _bookDescription = _dictionary[kDescription];
    }
    
    return _bookDescription;
}

- (NSArray *)authors
{
    if (!_authors)
    {
        _authors = _dictionary[kAuthors];
    }
    
    return _authors;
}

- (NSString *)authorsString
{
    if (!_authorsString)
    {
        _authorsString = [self.authors componentsJoinedByString:@", "];
    }
    
    return _authorsString;
}

- (TCSBookImageLinks *)imageLinks
{
    if (!_imageLinks)
    {
        NSDictionary * dictionary = _dictionary[kImageLinks];
        _imageLinks = [[TCSBookImageLinks alloc]initWithDictionary:dictionary];
    }
    
    return _imageLinks;
}




@end
