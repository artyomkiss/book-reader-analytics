//
//  TCSBookListItem.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksListItem.h"
#import "TCSNetworkObjectsConstants.h"

@implementation TCSBooksListItem

- (void)clearAllProperties
{
    _volumeInfo = nil;
    _accessInfo = nil;
}

- (TCSBookInfo *)volumeInfo
{
    if (!_volumeInfo)
    {
        NSDictionary * dictionary = _dictionary[kVolumeInfo];
        _volumeInfo = [[TCSBookInfo alloc]initWithDictionary:dictionary];
    }
    
    return _volumeInfo;
}

- (TCSBookAccessInfo *)accessInfo
{
    if (!_accessInfo)
    {
        NSDictionary * dictionary = _dictionary[kAccessInfo];
        _accessInfo = [[TCSBookAccessInfo alloc]initWithDictionary:dictionary];
    }
    
    return _accessInfo;
}

@end
