//
//  TCSHTTPRequestOperationManager.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSHTTPRequestOperationManager.h"

@implementation TCSHTTPRequestOperationManager

SINGLETON_GCD(TCSHTTPRequestOperationManager)

+(instancetype)manager
{
    return [self sharedInstance];
}

- (instancetype)init
{
    return [self initWithBaseURL:[NSURL URLWithString:@"https://www.googleapis.com/books/v1"]];
}

@end
