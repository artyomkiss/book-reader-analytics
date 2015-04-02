//
//  TCSBookImageLinks.m
//  BookReader
//
//  Created by Artem Kiselev on 13/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBookImageLinks.h"

@implementation TCSBookImageLinks

@synthesize smallThumbnail = _smallThumbnail;
@synthesize thumbnail = _thumbnail;

- (void)clearAllProperties
{
    _smallThumbnail = nil;
    _thumbnail = nil;
}

- (NSString *)smallThumbnail
{
    if (!_smallThumbnail)
    {
        _smallThumbnail = _dictionary[kSmallThumbnail];
    }
    
    return _smallThumbnail;
}

- (NSString *)thumbnail
{
    if (!_thumbnail)
    {
        _thumbnail = _dictionary[kThumbnail];
    }
    
    return _thumbnail;
}

@end
