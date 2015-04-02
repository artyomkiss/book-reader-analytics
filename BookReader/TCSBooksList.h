//
//  TCSBooksList.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBaseObject.h"

@interface TCSBooksList : TCSBaseObject

@property (nonatomic, readonly) NSArray * items;
@property (nonatomic, readonly) NSString * kind;
@property (nonatomic, readonly) NSNumber * totalItems;
@property (nonatomic, readonly) BOOL allBookLoaded;

- (void)appendBooksList:(TCSBooksList *)booksList;

@end
