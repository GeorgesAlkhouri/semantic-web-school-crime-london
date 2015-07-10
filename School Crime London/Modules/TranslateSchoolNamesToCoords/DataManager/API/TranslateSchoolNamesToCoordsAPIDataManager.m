//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsAPIDataManager.h"
#import <AFNetworking.h>
#import "AFHTTPRequestOperation+Additions.h"

@implementation TranslateSchoolNamesToCoordsAPIDataManager

- (void)
requestCoordsWithLocationNames:(NSArray *)requestData
                        APIKey:(NSString *)APIKey
                 progressBlock:
                     (void (^)(NSUInteger numberOfFinishedOperations,
                               NSUInteger totalNumberOfOperations))progressBlock
                    completion:
                        (void (^)(NSError *error, NSArray *results))completion {

    if (!completion)
        return;

    NSMutableArray *requestOperations = [NSMutableArray new];

    for (NSDictionary *rD in requestData) {

        NSURLRequest *request;
        request = [self buildRequestWithLocationName:rD[@"SchoolAdress"]
                                              APIKey:APIKey];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        operation.originalData = rD[@"OriginalData"];

        [requestOperations addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:requestOperations
                   progressBlock:progressBlock
                 completionBlock:^(NSArray *operations) {

                     [self processResultWithCompletion:completion
                                            operations:operations];

                 }];

    [[NSOperationQueue mainQueue] addOperations:operations
                              waitUntilFinished:NO];
}

- (NSURLRequest *)buildRequestWithLocationName:(NSString *)locationName
                                        APIKey:(NSString *)APIKey {
    NSDictionary *parameters;

    if (APIKey.length > 0)
        parameters = @{ @"address" : locationName, @"key" : APIKey };
    else
        parameters = @{ @"address" : locationName };

    NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
        requestWithMethod:@"GET"
                URLString:@"https://maps.googleapis.com/maps/api/geocode/json"
               parameters:parameters
                    error:nil];
    return request;
}

- (void)processResultWithCompletion:(void (^)(NSError *, NSArray *))completion
                         operations:(NSArray *)operations {

    NSMutableArray *results = [NSMutableArray new];

    for (AFHTTPRequestOperation *operation in operations) {
        id responseObject = operation.responseObject;

        if (operation.error) {

            completion(operation.error, nil);
            return;
        }

        NSMutableDictionary *result = [NSMutableDictionary new];
        [result setObject:operation.originalData forKey:@"Original-Data"];
        [result setObject:responseObject forKey:@"Result"];

        [results addObject:[result copy]];
    }

    completion(nil, [results copy]);
}

@end