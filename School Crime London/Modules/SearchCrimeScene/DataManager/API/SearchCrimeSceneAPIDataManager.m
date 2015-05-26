//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeSceneAPIDataManager.h"
#import <AFNetworking.h>

@implementation SearchCrimeSceneAPIDataManager

- (void)requestPoliceDataStoreWithParameters:
            (NSArray *)parameters completion:
                (void (^)(NSArray *results, NSError *error))completion {

    NSMutableArray *operations = [NSMutableArray new];

    for (NSDictionary *paramter in parameters) {

        for (NSString *requestDates in paramter[@"requestDates"]) {

            NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
                requestWithMethod:@"GET"
                        URLString:
                            @"http://data.police.uk/api/crimes-at-location"
                       parameters:@{
                           @"lat" : paramter[@"lat"],
                           @"lng" : paramter[@"lng"],
                           @"date" : requestDates
                       } error:nil];

            AFHTTPRequestOperation *operation =
                [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer =
                [AFJSONResponseSerializer serializer];

            [operations addObject:operation];
        }
    }

    NSArray *op = [AFURLConnectionOperation
        batchOfRequestOperations:[operations copy]
                   progressBlock:nil
                 completionBlock:^(NSArray *operations) {

                     for (AFHTTPRequestOperation *operation in operations) {

                         id responseObject = operation.responseObject;
                     }

                 }];

    [[NSOperationQueue mainQueue] addOperations:op waitUntilFinished:NO];
}

@end