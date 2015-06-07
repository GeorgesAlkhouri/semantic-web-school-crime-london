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
    formatter.dateFormat = @"yyyy-MM-dd";

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

    [self.APIDataManager
        requestPoliceDataStoreWithParameters:[parameters copy]
                                  completion:^(NSArray *results,
                                               NSError *error) {
                                      [self processResults:results error:error];
                                  }];
}

#pragma mark - Private

- (NSArray *)formattedDateStringsFromDate:(NSDate *)date {

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:date];
    [components setCalendar:[NSCalendar currentCalendar]];

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM";

    NSDate *minDate = [formatter dateFromString:@"2010-12"];
    NSDate *maxDate = [self createMaxDate];

    NSMutableArray *strings = [NSMutableArray new];

    for (NSInteger i = 0; i < 6; i++) {

        if ([self isDate:[components date]
                betweenDate:minDate
                    andDate:maxDate]) {

            [strings addObject:[formatter stringFromDate:[components date]]];
            components.month += 1;
        }
    }

    return [strings copy];
}

- (NSDate *)createMaxDate {

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:[NSDate date]];
    [components setCalendar:[NSCalendar currentCalendar]];
    components.month -= 3;

    return [components date];
}

- (BOOL)isDate:(NSDate *)date
   betweenDate:(NSDate *)beginDate
       andDate:(NSDate *)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;

    if ([date compare:endDate] == NSOrderedDescending)
        return NO;

    return YES;
}

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

                    [crimes addObject:crime];
                }
            }
        }
    } @catch (NSException *exception) {

        [self.presenter
            requestFailedWithError:
                [NSError errorWithDomain:NSStringFromClass([self class])
                                    code:-2
                                userInfo:@{
                                    NSLocalizedDescriptionKey :
                                        @"Parsing error with UK Police data."
                                }]];

        return;
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