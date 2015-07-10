//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeSceneInteractor.h"

@implementation SearchCrimeSceneInteractor

// Keys gameData
// GameName
// ReleaseDate
// OriginalGameRating

// Keys schoolData
// Name
// Adress
// lat
// lng
- (void)requestCrimeScenesWithSchoolData:(NSArray *)schoolData
                                gameData:(NSArray *)gameData {

    NSMutableArray *parameters = [NSMutableArray new];

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

    for (NSDictionary *game in gameData) {

        NSDate *releaseDate = [formatter dateFromString:game[@"ReleaseDate"]];

        NSArray *requestDates = [self formattedDateStringsFromDate:releaseDate];

        if (requestDates.count == 0)
            continue;

        for (NSDictionary *school in schoolData) {

            NSMutableDictionary *parameter = [school mutableCopy];

            [parameter addEntriesFromDictionary:game];
            [parameter setObject:requestDates forKey:@"requestDates"];

            [parameters addObject:[parameter copy]];
        }
    }

    [self.APIDataManager requestPoliceDataStoreWithParameters:[parameters copy]
        progressBlock:^(NSUInteger numberOfFinishedOperations,
                        NSUInteger totalNumberOfOperations) {

            [self.presenter progressUpdated:(double)numberOfFinishedOperations /
                                            totalNumberOfOperations];
        }
        completion:^(NSArray *results, NSError *error) {
            [self processResults:results error:error];
        }];
}

#pragma mark - Private

- (NSArray *)formattedDateStringsFromDate:(NSDate *)date {

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:date];
    [components setCalendar:[NSCalendar currentCalendar]];

    NSDateComponents *compareComponents = [[NSCalendar currentCalendar]
        components:NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:date];
    [compareComponents setCalendar:[NSCalendar currentCalendar]];
    compareComponents.year -= 1;

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM";

    NSMutableArray *strings = [NSMutableArray new];

    for (NSInteger i = 0; i < 6; i++) {

        [strings addObject:[formatter stringFromDate:[components date]]];
        [strings addObject:[formatter stringFromDate:[compareComponents date]]];
        components.month += 1;
        compareComponents.month += 1;
    }

    return [strings copy];
}

//{
//    category = "anti-social-behaviour";
//    context = "";
//    id = 23553943;
//    location =     {
//        latitude = "51.557557";
//        longitude = "-0.138952";
//        street =         {
//            id = 968107;
//            name = "On or near Dartmouth Park Hill";
//        };
//    };
//    "location_subtype" = "";
//    "location_type" = Force;
//    month = "2013-04";
//    "outcome_status" = "<null>";
//    "persistent_id" = "";
//}

- (void)processResults:(NSArray *)results error:(NSError *)error {

    if (error) {

        [self.presenter requestFailedWithError:error];
        return;
    }
    NSMutableArray *crimes = [NSMutableArray new];

    @try {
        for (NSDictionary *result in results) {

            if ([result[@"Result"] count] > 0) {
                NSArray *crimeResult = result[@"Result"];

                for (NSDictionary *crime in crimeResult) {

                    NSMutableDictionary *crimeResultWithSchoolData =
                        [NSMutableDictionary
                            dictionaryWithDictionary:result[@"OriginalData"]];

                    [crimeResultWithSchoolData setObject:crime[@"category"]
                                                  forKey:@"Crime-Category"];
                    [crimeResultWithSchoolData setObject:crime[@"context"]
                                                  forKey:@"Crime-Context"];
                    [crimeResultWithSchoolData
                        setObject:[crime[@"id"] stringValue]
                           forKey:@"Crime-ID"];
                    [crimeResultWithSchoolData setObject:@{
                        @"Latitude" : crime[@"location"][@"latitude"],
                        @"Longitude" : crime[@"location"][@"longitude"],
                        @"Street" : @{
                            @"Street-ID" : crime[@"location"][@"street"][@"id"],
                            @"Steet-Name" :
                                crime[@"location"][@"street"][@"name"]
                        }

                    } forKey:@"Crime-Location"];

                    [crimeResultWithSchoolData
                        setObject:crime[@"location_subtype"]
                           forKey:@"Crime-Location-Subtype"];
                    [crimeResultWithSchoolData
                        setObject:crime[@"location_type"]
                           forKey:@"Crime-Location-Type"];

                    NSDateFormatter *formatter = [NSDateFormatter new];
                    formatter.dateFormat = @"yyyy-MM";

                    NSDate *crimeMonth =
                        [formatter dateFromString:crime[@"month"]];

                    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

                    NSString *formattedCrimeMonth =
                        [formatter stringFromDate:crimeMonth];

                    [crimeResultWithSchoolData setObject:formattedCrimeMonth
                                                  forKey:@"Crime-Month"];
                    [crimeResultWithSchoolData
                        setObject:crime[@"outcome_status"]
                           forKey:@"Crime-Outcome-Status"];
                    [crimeResultWithSchoolData
                        setObject:crime[@"persistent_id"]
                           forKey:@"Crime-Persistent-ID"];

                    [crimes addObject:crimeResultWithSchoolData];
                }
            }
        }
    } @catch (NSException *exception) {

        NSLog(@"Parsing error with UK Police data.");
    }

    if (crimes.count == 0) {

        [self.presenter
            requestFailedWithError:
                [NSError errorWithDomain:NSStringFromClass([self class])
                                    code:-1
                                userInfo:@{
                                    NSLocalizedDescriptionKey :
                                        @"Empty result from UK Police."
                                }]];
        return;
    }

    [self.presenter requestSucceededWithResults:crimes];
}

@end