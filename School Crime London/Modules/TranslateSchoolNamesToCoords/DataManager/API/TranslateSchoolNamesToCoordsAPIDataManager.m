//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsAPIDataManager.h"
#import <AFNetworking.h>

@implementation TranslateSchoolNamesToCoordsAPIDataManager

- (void)requestCoordsWithLocationNames:(NSArray *)locationNames
                                APIKey:(NSString *)APIKey
                            completion:(void (^)(NSError *error,
                                                 NSArray *results))completion {

    if (!completion)
        return;

    NSMutableArray *requestOperations = [NSMutableArray new];

    for (NSString *locationName in locationNames) {

        NSURLRequest *request;
        request =
            [self buildRequestWithLocationName:locationName APIKey:APIKey];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];

        [requestOperations addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:requestOperations
                   progressBlock:nil
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

        @try {
            NSDictionary *schoolData = @{
                @"Name" : responseObject[@"results"][0][
                    @"address_components"][0][@"long_name"],
                @"Adress" : responseObject[@"results"][0][@"formatted_address"],
                @"lat" : responseObject[@"results"][0][@"geometry"][
                    @"location"][@"lat"],
                @"lng" : responseObject[@"results"][0][@"geometry"][
                    @"location"][@"lng"]
            };

            [results addObject:schoolData];
        } @catch (NSException *exception) {

            completion([NSError errorWithDomain:NSStringFromClass([self class])
                                           code:-2
                                       userInfo:nil],
                       nil);
            return;
        }

        completion(nil, [results copy]);
    }
}

@end