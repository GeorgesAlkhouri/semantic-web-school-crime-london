//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGameDataInteractor.h"
#import "ExtractGameDataItem.h"
#import "NSDate+Additions.h"

@implementation ExtractGameDataInteractor

- (void)startDataExtraction {

    [self.APIDataManager
        extractPegiMetaDataWithCompletion:^(NSError *error, id result) {

            if (error) {

                [self.presenter errorOccurred:error];
                return;
            }

            NSError *parseError = nil;
            NSNumber *maxPageCount =
                [self extractMaxPageCount:result[@"results"][0][@"pegi_meta"]
                                withError:&parseError];

            if (parseError) {

                [self.presenter errorOccurred:parseError];
                return;
            }

            [self.APIDataManager extractPegiDataWithMaxPageCount:maxPageCount
                progressBlock:^(NSUInteger numberOfFinishedOperations,
                                NSUInteger totalNumberOfOperations) {

                    [self.presenter
                        progressUpdated:(double)numberOfFinishedOperations /
                                        totalNumberOfOperations];
                }
                completion:^(NSError *error, NSArray *results) {

                    if (error) {

                        [self.presenter errorOccurred:error];

                    } else {

                        [self processResults:results];
                    }

                }];

        }];
}

#pragma mark - Private

- (NSNumber *)extractMaxPageCount:(NSString *)pegiMetaString
                        withError:(NSError **)error {

    NSRange range = [pegiMetaString rangeOfString:@"Site"];

    if (range.location == NSNotFound) {

        *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                     code:-1
                                 userInfo:@{
                                     NSLocalizedDescriptionKey :
                                         @"Parsing error in Pegi Meta Request"
                                 }];
        return nil;
    }

    NSNumber *maxPageCount = nil;

    @try {

        range.location -= 2;

        for (NSInteger i = range.location; i > 0; i--) {

            if ([pegiMetaString characterAtIndex:i] == ' ') {

                range.length = range.location + 1 - i;
                range.location = i;

                break;
            }
        }

        NSString *maxPageCountString =
            [pegiMetaString substringWithRange:range];

        NSNumberFormatter *formatter = [NSNumberFormatter new];
        maxPageCount = [formatter numberFromString:maxPageCountString];

    } @catch (NSException *exception) {

        maxPageCount = nil;
        *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                     code:-1
                                 userInfo:@{
                                     NSLocalizedDescriptionKey :
                                         @"Parsing error in Pegi Meta Request"
                                 }];
    }

    return maxPageCount;
}

- (void)processResults:(NSArray *)results {

    NSMutableArray *games = [NSMutableArray new];

    for (NSDictionary *responseObject in results) {

        @try {

            for (NSDictionary *result in responseObject[@"results"]) {

                NSDateFormatter *formatter = [NSDateFormatter new];
                formatter.dateFormat = @"yyyy-MM-dd";

                NSDate *releaseDate =
                    [formatter dateFromString:result[@"main"][1]];

                formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

                NSString *formattedReleaseDate =
                    [formatter stringFromDate:releaseDate];

                NSDictionary *game = @{
                    @"GameName" : result[@"main"][0],
                    @"ReleaseDate" : formattedReleaseDate,
                    @"OriginalGameRating" : @"Pegi: 18"
                };

                [games addObject:game];
            }

        } @catch (NSException *exception) {

            NSLog(@"Parse error occurred");
        }
    }

    if (games.count == 0) {
        [self.presenter
            errorOccurred:[NSError
                              errorWithDomain:NSStringFromClass([self class])
                                         code:-2
                                     userInfo:nil]];

        return;
    }

    [self.presenter extractionFinishedWithResults:
                        [[self groupsWithDuplicatesRemoved:games] copy]];
}

- (NSMutableArray *)groupsWithDuplicatesRemoved:(NSArray *)groups {
    NSMutableArray *groupsFiltered =
        [[NSMutableArray alloc] init]; // This will be the array of groups you
                                       // need
    NSMutableArray *groupNamesEncountered =
        [[NSMutableArray alloc] init]; // This is an array of group names seen
                                       // so far

    NSString *name;                       // Preallocation of group name
    for (NSDictionary *group in groups) { // Iterate through all groups
        name = [[group objectForKey:@"GameName"] lowercaseString]; // Get the
                                                                   // group name
        if ([groupNamesEncountered indexOfObject:name] ==
            NSNotFound) { // Check if this group name hasn't been encountered
                          // before
            [groupNamesEncountered addObject:name]; // Now you've encountered
                                                    // it, so add it to the list
                                                    // of encountered names
            [groupsFiltered addObject:group]; // And add the group to the list,
                                              // as this is the first time it's
                                              // encountered
        }
    }
    return groupsFiltered;
}

@end