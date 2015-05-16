//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataInteractor.h"
#import "ExtractGiantBombDataItem.h"
#import "NSDate+Additions.h"

@implementation ExtractGiantBombDataInteractor

- (void)startDataExtractionWithGiantBombAPIKey:(NSString *)APIKey {

    [_APIDataManager getReleaseDatesForGames:@[
        @"Battlefield Hardline",
        @"Call of Duty Advanced Warfare",
        @"Counter Strike",
        @"Manhunt",
        @"Manhunt 2"
    ] APIKey:APIKey completion:^(NSArray *results) {

        [self processResults:results];
    }];
}

#pragma mark - Private

- (void)processResults:(NSArray *)results {

    NSMutableArray *games = [NSMutableArray new];

    for (NSDictionary *responseObject in results) {

        @try {

            // error
            if ([responseObject[@"status_code"] integerValue] != 1) {

                [self.presenter
                    errorOccurred:[NSError errorWithDomain:NSStringFromClass(
                                                               [self class])
                                                      code:-1
                                                  userInfo:nil]];
                return;
            }

            ExtractGiantBombDataItem *game = [ExtractGiantBombDataItem new];

            game.gameName = responseObject[@"results"][0][@"name"];
            game.releaseDate =
                responseObject[@"results"][0][@"original_release_date"];
            game.rating = responseObject[@"results"][0][
                @"original_game_rating"][0][@"name"];

            [games addObject:game];
        }
        @catch (NSException *exception) {

            [self.presenter
                errorOccurred:[NSError errorWithDomain:NSStringFromClass(
                                                           [self class])
                                                  code:-2
                                              userInfo:nil]];
        }
    }
}

@end