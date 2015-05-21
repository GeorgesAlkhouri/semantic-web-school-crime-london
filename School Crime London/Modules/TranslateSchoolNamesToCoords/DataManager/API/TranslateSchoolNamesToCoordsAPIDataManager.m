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

    NSMutableArray *requestOperations = [NSMutableArray new];

    for (NSString *locationName in locationNames) {

        NSDictionary *parameters;

        if (APIKey.length > 0)
            parameters = @{ @"address" : locationName, @"key" : APIKey };
        else
            parameters = @{ @"address" : locationName };

        NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
            requestWithMethod:@"GET"
                    URLString:
                        @"https://maps.googleapis.com/maps/api/geocode/json"
                   parameters:parameters
                        error:nil];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];

        [requestOperations addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:requestOperations
                   progressBlock:nil
                 completionBlock:^(NSArray *operations) {

                     AFHTTPRequestOperation *o = operations[0];

                     id r = o.responseObject;

                 }];

    [[NSOperationQueue mainQueue] addOperations:operations
                              waitUntilFinished:NO];
}

@end