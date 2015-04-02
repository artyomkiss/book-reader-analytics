//
//  TCSHTTPRequestOperationManager+Requests.m
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSHTTPRequestOperationManager+Requests.h"
#import "TCSRequestOperationsConstants.h"

@implementation TCSHTTPRequestOperationManager (Requests)

- (AFHTTPRequestOperation *)searchForVolumesContainsString:(NSString *)containsString
                                                startIndex:(NSNumber *)startIndexDefault0
                                                maxResults:(NSNumber *)maxResultsDefault40
                                                completion:(void (^)(NSError *, TCSBooksList *))completionBlock
{
    NSDictionary * parameters = @{
                                  kQ : [containsString stringByAppendingFormat:@"+%@",kInauthor],
                                  kStartIndex : startIndexDefault0 ?: @(0),
                                  kMaxResults : maxResultsDefault40 ?: @(10)
                                  };
    return [self GET:API_volumes
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (completionBlock)
        {
            TCSBooksList * booksList = [[TCSBooksList alloc]initWithDictionary:responseObject];
            
            completionBlock(nil,booksList);
        }
    }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (completionBlock)
        {
            completionBlock(error,nil);
        }
    }];
}

@end
