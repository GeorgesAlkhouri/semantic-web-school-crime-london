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

    [self.presenter translationDidFinishedWithResults:results];
}

@end