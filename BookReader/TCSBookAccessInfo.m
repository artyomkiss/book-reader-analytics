//
//  TCSBookAccessInfo.m
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookAccessInfo.h"

@implementation TCSBookAccessInfo

@synthesize webReaderLink = _webReaderLink;

- (void)clearAllProperties
{
    _webReaderLink = nil;
}

- (NSString *)webReaderLink
{
    if (!_webReaderLink)
    {
        _webReaderLink = _dictionary[kWebReaderLink];
    }
    
    return _webReaderLink;
}

@end
