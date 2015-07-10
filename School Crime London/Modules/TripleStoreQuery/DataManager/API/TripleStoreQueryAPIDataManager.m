//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TripleStoreQueryAPIDataManager.h"

#import <AFNetworking.h>

@implementation TripleStoreQueryAPIDataManager

- (void)putDumpIntoTripleStoreWithStoreURL:(NSString *)storeURL
                                   fileURL:(NSURL *)fileURL
                               datasetName:(NSString *)dataset
                                completion:
                                    (void (^)(NSError *error))completion {

    NSString *URL =
        [NSString stringWithFormat:@"%@/%@?default", storeURL, dataset];

    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];

    NSMutableURLRequest *request = [manager.requestSerializer
        multipartFormRequestWithMethod:@"PUT"
                             URLString:URL
                            parameters:nil
             constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

                 [formData appendPartWithFileURL:fileURL
                                            name:@"RDFDUMP"
                                        fileName:[fileURL lastPathComponent]
                                        mimeType:@"text/turtle;charset=utf-8"
                                           error:nil];

             } error:nil];

    AFHTTPRequestOperation *op =
        [manager HTTPRequestOperationWithRequest:request
            success:^(AFHTTPRequestOperation *operation, id responseObject) {

                if (completion)
                    completion(nil);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                if (completion)
                    completion(error);
            }];

    [op start];
}

- (void)queryWithStoreURL:(NSString *)storeURL
              datasetName:(NSString *)dataset
                  queries:(NSArray *)queries
            progressBlock:
                (void (^)(NSUInteger numberOfFinishedOperations,
                          NSUInteger totalNumberOfOperations))progressBlock
               completion:(void (^)(NSArray *results))completion {

    NSString *URL = [NSString stringWithFormat:@"%@/%@", storeURL, dataset];

    NSMutableArray *requests = [NSMutableArray new];

    for (NSString *query in queries) {

        NSMutableURLRequest *request =
            [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET"
                                                          URLString:URL
                                                         parameters:@{
                                                             @"query" : query
                                                         } error:nil];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];

        NSMutableSet *temp =
            [operation.responseSerializer.acceptableContentTypes mutableCopy];

        [temp addObject:@"application/sparql-results+json"];
        operation.responseSerializer.acceptableContentTypes = [temp copy];

        [requests addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:[requests copy]
                   progressBlock:progressBlock
                 completionBlock:^(NSArray *operations) {

                     if (completion)
                         completion(operations);
                 }];

    [[NSOperationQueue mainQueue] addOperations:operations
                              waitUntilFinished:NO];
}

@end
