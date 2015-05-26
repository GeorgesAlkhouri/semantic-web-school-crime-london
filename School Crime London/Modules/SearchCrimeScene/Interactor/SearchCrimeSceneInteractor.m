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
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    for (NSDictionary *game in gameData) {

        NSDate *releaseDate = [formatter dateFromString:game[@"ReleaseDate"]];

        NSArray *requestDates = [self formattedDateStringsFromDate:releaseDate];

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
                                               NSError *error){

                                  }];
}

- (NSArray *)formattedDateStringsFromDate:(NSDate *)date {

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:date];
    [components setCalendar:[NSCalendar currentCalendar]];

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM";

    NSMutableArray *strings = [NSMutableArray new];

    for (NSInteger i = 0; i < 6; i++) {

        [strings addObject:[formatter stringFromDate:[components date]]];
        components.month += 1;
    }

    return [strings copy];
}

@end