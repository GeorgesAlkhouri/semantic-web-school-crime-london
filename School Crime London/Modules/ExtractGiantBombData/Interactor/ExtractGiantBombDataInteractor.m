//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataInteractor.h"
#import "ExtractGiantBombDataItem.h"
#import "NSDate+Additions.h"

@implementation ExtractGiantBombDataInteractor

- (void)startDataExtractionWithAPIKey:(NSString *)APIKey
                              userKey:(NSString *)userKey {

    [self.APIDataManager
        extractPegiMetaDataWithAPIKey:APIKey
                              userKey:userKey
                           completion:^(NSError *error, id result) {

                               NSNumber *maxPageCount = [self
                                   extractMaxPageCount:result[@"results"][0][
                                                           @"pegi_meta"]];

                               [self.APIDataManager
                                   extractPegiDataWithMaxPageCount:maxPageCount
                                                            APIKey:APIKey
                                                           userKey:userKey
                                                        completion:^(NSError
                                                                         *error,
                                                                     NSArray *
                                                                         results) {

                                                            if (error) {

                                                                [self.presenter
                                                                    errorOccurred:
                                                                        error];

                                                            } else {

                                                                [self
                                                                    processResults:
                                                                        results];
                                                            }

                                                        }];

                           }];
}

#pragma mark - Private

- (NSNumber *)extractMaxPageCount:(NSString *)pegiMetaString {

    NSRange range = [pegiMetaString rangeOfString:@"Site"];

    if (range.location == NSNotFound)
        return nil;

    range.location -= 2;

    for (NSInteger i = range.location; i > 0; i--) {

        if ([pegiMetaString characterAtIndex:i] == ' ') {

            range.length = range.location + 1 - i;
            range.location = i;

            break;
        }
    }

    NSString *maxPageCountString = [pegiMetaString substringWithRange:range];

    NSNumberFormatter *formatter = [NSNumberFormatter new];
    NSNumber *maxPageCount = [formatter numberFromString:maxPageCountString];

    return maxPageCount;
}

- (void)processResults:(NSArray *)results {

    NSMutableArray *games = [NSMutableArray new];

    for (NSDictionary *responseObject in results) {

        @try {

            for (NSDictionary *result in responseObject[@"results"]) {

                NSDictionary *game = @{
                    @"GameName" : result[@"main"][0],
                    @"ReleaseDate" : result[@"main"][1],
                    @"OriginalGameRating" : @"Pegi: 18"
                };

                [games addObject:game];
            }

        } @catch (NSException *exception) {

            NSLog(@"Parse error occurred");
        }

        @finally {

            if (games.count == 0) {
                [self.presenter
                    errorOccurred:[NSError errorWithDomain:NSStringFromClass(
                                                               [self class])
                                                      code:-2
                                                  userInfo:nil]];

                return;
            }
        }
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

    NSString *name;                              // Preallocation of group name
    for (NSDictionary *group in groups) {        // Iterate through all groups
        name = [group objectForKey:@"GameName"]; // Get the group name
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