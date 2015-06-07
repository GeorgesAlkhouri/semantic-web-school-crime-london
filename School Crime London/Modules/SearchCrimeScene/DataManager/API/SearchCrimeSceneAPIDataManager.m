//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeSceneAPIDataManager.h"
#import "AFHTTPRequestOperation+Additions.h"
#import <AFNetworking.h>

@implementation SearchCrimeSceneAPIDataManager

- (void)requestPoliceDataStoreWithParameters:
            (NSArray *)parameters completion:
                (void (^)(NSArray *results, NSError *error))completion {

    NSMutableArray *operations = [NSMutableArray new];

    for (NSDictionary *paramter in parameters) {

        for (NSString *requestDate in paramter[@"requestDates"]) {

            NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
                requestWithMethod:@"GET"
                        URLString:
                            @"http://data.police.uk/api/crimes-at-location"
                       parameters:@{
                           @"lat" : paramter[@"Lat"],
                           @"lng" : paramter[@"Lng"],
                           @"date" : requestDate
                       } error:nil];

            AFHTTPRequestOperation *operation =
                [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer =
                [AFJSONResponseSerializer serializer];

            NSMutableDictionary *temp = [NSMutableDictionary new];
            [temp addEntriesFromDictionary:paramter];
            [temp setObject:requestDate forKey:@"RequestDate"];
            operation.originalData = temp;

            [operations addObject:operation];
        }
    }

    NSArray *op =
        [AFURLConnectionOperation batchOfRequestOperations:[operations copy]
            progressBlock:^(NSUInteger numberOfFinishedOperations,
                            NSUInteger totalNumberOfOperations) {

                NSLog(@"%f", (double)numberOfFinishedOperations /
                                 totalNumberOfOperations);

            }
            completionBlock:^(NSArray *operations) {

                NSMutableArray *results = [NSMutableArray new];

                for (AFHTTPRequestOperation *operation in operations) {

                    if (operation.error) {

                        if (completion)
                            completion(nil, operation.error);

                        return;
                    }

                    id responseObject = operation.responseObject;

                    if (responseObject) {

                        NSDictionary *result = @{
                            @"Result" : responseObject,
                            @"OriginalData" : operation.originalData
                        };

                        [results addObject:result];
                    }
                }

                if (completion)
                    completion([results copy], nil);

            }];

    [[NSOperationQueue mainQueue] addOperations:op waitUntilFinished:NO];
}

@end