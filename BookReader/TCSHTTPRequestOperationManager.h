//
//  TCSHTTPRequestOperationManager.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "TCSMacroses.h"

@interface TCSHTTPRequestOperationManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;


@end
