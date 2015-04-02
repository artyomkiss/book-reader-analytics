//
//  TCSHTTPRequestOperationManager+Requests.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSHTTPRequestOperationManager.h"
#import "TCSBooksList.h"

@interface TCSHTTPRequestOperationManager (Requests)

- (AFHTTPRequestOperation *)searchForVolumesContainsString:(NSString *)containsString
                                                startIndex:(NSNumber *)startIndex
                                                maxResults:(NSNumber *)maxResults
                                                completion:(void(^)(NSError * error, TCSBooksList * booksList))completionBlock;

@end
