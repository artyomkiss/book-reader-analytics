//
//  TCSP2PBaseObject.m
//  TCSP2P
//
//  Created by a.v.kiselev on 31.07.13.
//  Copyright (c) 2013 “Tinkoff Credit Systems” Bank (closed joint-stock company). All rights reserved.
//

#import "TCSBaseObject.h"
#import "TCSMacroses.h"

@implementation TCSBaseObject
@synthesize dictionary = _dictionary;

+ (NSArray *)arrayOfObjectsWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray * array = [NSMutableArray array];

    for (NSDictionary * dictionary in arrayOfDictionaries)
    {
        id object = [[[self class]alloc]initWithDictionary:dictionary];
        [array addObject:object];
    }
    
    return array.copy;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (!dictionary)
    {
        return nil;
    }
    
	if (self = [super init])
	{
		[self setDictionary:dictionary];
	}
	return self;
}

- (void)setDictionary:(NSDictionary *)dictionary
{
	[self clearAllProperties];
	_dictionary = dictionary;
}

- (void)clearAllProperties
{
	ALog(@"%@ method not implemented in class %@",	NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

@end
