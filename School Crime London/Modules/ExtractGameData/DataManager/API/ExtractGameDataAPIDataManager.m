//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGameDataAPIDataManager.h"
#import <AFNetworking.h>
#import "NSString+Additions.h"

static const NSString *kUSER_KEY = @"30a515a1-56e4-4acd-b38c-4d4d49adcb79";
static const NSString *kHMAC_KEY = @"e9f6ca0ba2abaabfa71633e3e97a2d0689cb884e";
static const NSString *kEXPIREY_DATE = @"1586446580";

@implementation ExtractGameDataAPIDataManager

- (void)extractPegiMetaDataWithCompletion:(void (^)(NSError *error,
                                                    id result))completion {

    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSString *get = [NSString
        stringWithFormat:@"https://api.import.io/store/data/"
                         @"93a1681a-fcca-4edf-ad45-5baf79979f27/_query?input/"
                         @"webpage/"
                         @"url=http%%3A%%2F%%2Fwww.pegi.info%%2Fde%%2Findex%%"
                         @"2Fglobal_id%%2F505%%2F%%3Fpage%%3D1%%26lang%%3Dde%%"
                         @"26params%%3Dglobal_id%%252F505%%252F%%"
                         @"26searchString%%3D%%26agecategories%%3D18%%26genre%"
                         @"%3D1%%26organisations%%3D%%26platforms%%3D%%"
                         @"26countries%%3D%%26submit%%3DSuchen%%26global_id%%"
                         @"3D505%%26id%%3D513%%23searchresults&_user=%@&_"
                         @"expiry=%@_digest=%@",
                         kUSER_KEY, kEXPIREY_DATE, kHMAC_KEY];

    [manager GET:get
        parameters:nil
        success:^(AFHTTPRequestOperation *operation, id responseObject) {

            if (completion)
                completion(nil, responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            if (completion)
                completion(error, nil);
        }];
}

- (void)extractPegiDataWithMaxPageCount:(NSNumber *)pageCount
                          progressBlock:
                              (void (^)(NSUInteger numberOfFinishedOperations,
                                        NSUInteger totalNumberOfOperations))
                                  progressBlock
                             completion:(void (^)(NSError *error,
                                                  NSArray *results))completion {

    NSMutableArray *requestOperations = [NSMutableArray new];

    NSString *postString =
        [NSString stringWithFormat:@"https://api.import.io/store/data/"
                                   @"7cbac9ed-356e-41bc-bf1b-4c628c6b9718/"
                                   @"_query?_user=%@&_expiry=%@_digest=%@",
                                   kUSER_KEY, kEXPIREY_DATE, kHMAC_KEY];

    for (NSInteger i = 1; i < pageCount.integerValue + 1; i++) {

        NSURLRequest *request = [[AFJSONRequestSerializer serializer]
            requestWithMethod:@"POST"
                    URLString:postString
                   parameters:@{
                       @"input" : @{
                           @"webpage/url" : [NSString
                               stringWithFormat:
                                   @"http://www.pegi.info/de/index/global_id/"
                                   @"505/" @"?page=%d&lang=de&params=global_"
                                   @"id%%2F505%%2F&"
                                   @"searchString=&agecategories=18&genre=1&"
                                   @"organisations=&platforms=&countries=&"
                                   @"submit=Suchen&global_id=505&id=513#"
                                   @"searchresults",
                                   (int)i]
                       }
                   } error:nil];

        AFHTTPRequestOperation *operation =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];

        [requestOperations addObject:operation];
    }

    NSArray *operations = [AFURLConnectionOperation
        batchOfRequestOperations:requestOperations
                   progressBlock:progressBlock
                 completionBlock:^(NSArray *operations) {

                     NSMutableArray *results = [NSMutableArray new];

                     for (AFHTTPRequestOperation *operation in operations) {

                         id responseObject = operation.responseObject;

                         if (operation.error) {

                             if (completion)
                                 completion(operation.error, nil);
                             return;
                         }

                         [results addObject:responseObject];
                     }

                     if (completion)
                         completion(nil, [results copy]);
                 }];

    [[NSOperationQueue mainQueue] addOperations:operations
                              waitUntilFinished:NO];
}

@end