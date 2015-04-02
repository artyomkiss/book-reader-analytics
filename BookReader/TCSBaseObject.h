//
//  TCSBaseObject.h
//  TCS
//
//  Created by a.v.kiselev on 31.07.13.
//  Copyright (c) 2013 “Tinkoff Credit Systems” Bank (closed joint-stock company). All rights reserved.
//

#import "TCSNetworkObjectsConstants.h"


@interface TCSBaseObject : NSObject
{
	NSDictionary *_dictionary;
}

@property (nonatomic, strong) NSDictionary * dictionary;

+ (NSArray *)arrayOfObjectsWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)clearAllProperties;

@end
