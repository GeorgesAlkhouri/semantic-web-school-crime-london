//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsInteractor.h"

@implementation TranslateSchoolNamesToCoordsInteractor

- (void)startTranslatingWithAPIKey:(NSString *)APIKey
                       schoolNames:(NSArray *)schoolNames {

    [self.APIDataManager
        requestCoordsWithLocationNames:schoolNames
                                APIKey:APIKey
                            completion:^(NSError *error, NSArray *results){

                            }];
}

@end