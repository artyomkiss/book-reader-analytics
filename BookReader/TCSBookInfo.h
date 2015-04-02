//
//  TCSBookInfo.h
//  BookReader
//
//  Created by Artem Kiselev on 13/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSBaseObject.h"
#import "TCSBookImageLinks.h"

@interface TCSBookInfo : TCSBaseObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * publisher;
@property (nonatomic, strong) NSString * publishedDate;
@property (nonatomic, strong) NSString * bookDescription;
@property (nonatomic, strong) NSArray * authors;
@property (nonatomic, strong) NSString * authorsString;
@property (nonatomic, strong) TCSBookImageLinks * imageLinks;

@end
