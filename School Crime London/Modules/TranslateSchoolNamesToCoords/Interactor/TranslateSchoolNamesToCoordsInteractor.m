//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsInteractor.h"

@implementation TranslateSchoolNamesToCoordsInteractor

// Keys
// "Type"
// "Name"
// "BuildingName"
// "BuildingNumber"
// "Street"
// "Postcode"
- (void)startTranslatingWithAPIKey:(NSString *)APIKey
                        schoolData:(NSArray *)schoolData {

    NSMutableArray *schoolAdresses;
    schoolAdresses = [self buildLocationNamesWithSchoolData:schoolData];

    [self.APIDataManager
        requestCoordsWithLocationNames:[schoolAdresses copy]
                                APIKey:APIKey
                            completion:^(NSError *error, NSArray *results) {

                                [self processResultsWithError:error
                                                      results:results];
                            }];
}

- (NSMutableArray *)buildLocationNamesWithSchoolData:(NSArray *)schoolData {
    NSMutableArray *schoolAdresses = [NSMutableArray new];

    for (NSDictionary *schoolSet in schoolData) {

        NSString *schoolAdress = [NSString
            stringWithFormat:
                @"%@%@%@%@%@", schoolSet[@"Name"],
                [@"+" stringByAppendingString:schoolSet[@"Street"]],
                ([schoolSet[@"BuildingNumber"] length] > 0)
                    ? [@"+"
                          stringByAppendingString:schoolSet[@"BuildingNumber"]]
                    : @"",
                ([schoolSet[@"Postcode"] length] > 0)
                    ? [@"+" stringByAppendingString:schoolSet[@"Postcode"]]
                    : @"",
                @"+London"];
        NSDictionary *requestData =
            @{ @"SchoolAdress" : schoolAdress,
               @"OriginalData" : schoolSet };

        [schoolAdresses addObject:requestData];
    }
    return schoolAdresses;
}

// Keys
// @"Name"
// @"Adress"
// @"lat"
// @"lng"
- (void)processResultsWithError:(NSError *)error results:(NSArray *)results {

    if (error) {

        [self.presenter translationDidFinishedWithError:error];
        return;
    }

    NSMutableArray *parsedResults = [NSMutableArray new];

    for (NSDictionary *result in results) {

        id responseObject = result[@"Result"];

        if (![responseObject[@"status"] isEqualToString:@"OK"]) {

            NSError *error =
                [NSError errorWithDomain:NSStringFromClass([self class])
                                    code:-1
                                userInfo:@{
                                    NSLocalizedDescriptionKey :
                                        responseObject[@"error_message"]
                                }];

            [self.presenter translationDidFinishedWithError:error];
            return;
        }

        @try {

            NSDictionary *schoolData = @{
                @"School-Name" : result[@"Original-Data"][@"Name"],
                @"School-Adress" :
                    responseObject[@"results"][0][@"formatted_address"],
                @"School-Lat" : responseObject[@"results"][0][@"geometry"][
                    @"location"][@"lat"],
                @"School-Lng" : responseObject[@"results"][0][@"geometry"][
                    @"location"][@"lng"],
                @"School-Building-Name" :
                    result[@"Original-Data"][@"BuildingName"],
                @"School-Building-Number" :
                    result[@"Original-Data"][@"BuildingNumber"],
                @"School-Postcode" : result[@"Original-Data"][@"Postcode"],
                @"School-Street" : result[@"Original-Data"][@"Street"],
                @"School-Type" : result[@"Original-Data"][@"Type"],
                @"School-ID" : responseObject[@"results"][0][@"place_id"]
            };

            [parsedResults addObject:schoolData];

        } @catch (NSException *exception) {

            [self.presenter
                translationDidFinishedWithError:
                    [NSError errorWithDomain:NSStringFromClass([self class])
                                        code:-2
                                    userInfo:nil]];
            return;
        }
    }

    [self.presenter translationDidFinishedWithResults:parsedResults];
}

@end