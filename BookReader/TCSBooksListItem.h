//
//  TCSBookListItem.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBaseObject.h"
#import "TCSBookInfo.h"
#import "TCSBookAccessInfo.h"

@interface TCSBooksListItem : TCSBaseObject

@property (nonatomic, strong) TCSBookInfo * volumeInfo;
@property (nonatomic, strong) TCSBookAccessInfo * accessInfo;

@end
