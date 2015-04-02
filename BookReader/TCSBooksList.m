//
//  TCSBooksList.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBooksList.h"
#import "TCSBooksListItem.h"
#import "TCSNetworkObjectsConstants.h"

@implementation TCSBooksList

@synthesize items = _items;
@synthesize totalItems = _totalItems;
@synthesize kind = _kind;

- (void)clearAllProperties
{
    _items = nil;
    _totalItems = nil;
    _kind = nil;
}

- (NSNumber *)totalItems
{
    if (!_totalItems)
    {
        _totalItems = _dictionary[kTotalItems];
    }
    
    return _totalItems;
}

- (NSString *)kind
{
    if (!_kind)
    {
        _kind = _dictionary[kKind];
    }
    
    return _kind;
}

- (NSArray *)items
{
    if (!_items)
    {
        _items = [TCSBooksListItem arrayOfObjectsWithArrayOfDictionaries:_dictionary[kItems]];
    }
    
    return _items;
}

- (BOOL)allBookLoaded
{
    return self.items.count == self.totalItems.integerValue;
}

- (void)appendBooksList:(TCSBooksList *)booksList
{
    NSArray * items = [self.dictionary[kItems] arrayByAddingObjectsFromArray:booksList.dictionary[kItems]];
    NSDictionary * appendedBooksListDictionary = @{
                                                   kItems : items,
                                                   kTotalItems : booksList.totalItems,
                                                   kKind : booksList.kind
                                                   };
    [self setDictionary:appendedBooksListDictionary];
}

@end
