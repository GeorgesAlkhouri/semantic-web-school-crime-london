//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataAPIDataManager.h"
#import <AFNetworking.h>

@implementation ExtractGiantBombDataAPIDataManager

- (void)getReleaseDatesForGames:(NSArray *)gameNames
                         APIKey:(NSString *)APIKey
                     completion:(void (^)(NSArray *results))completion {

    NSMutableArray *requests = [NSMutableArray new];

    for (NSString *gameName in gameNames) {

        NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
            requestWithMethod:@"GET"
                    URLString:@"http://www.giantbomb.com/api/search/"
                   parameters:@{
                       @"api_key" : APIKey,
                       @"format" : @"json",
                       @"query" : gameName,
                       @"resources" : @"game",
                       @"limit" : @"1"
                   } error:nil];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];

        [requests addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:requests
                   progressBlock:nil
                 completionBlock:^(NSArray *operations) {

                     NSMutableArray *responseObjects = [NSMutableArray new];

                     for (AFHTTPRequestOperation *operation in operations) {

                         [responseObjects addObject:operation.responseObject];
                     }

                     if (completion)
                         completion(responseObjects);
                 }];

    [[NSOperationQueue mainQueue] addOperations:operations
                              waitUntilFinished:NO];
}

@end