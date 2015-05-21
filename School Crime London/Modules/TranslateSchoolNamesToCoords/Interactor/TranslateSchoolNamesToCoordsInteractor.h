//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateSchoolNamesToCoordsProtocols.h"


@interface TranslateSchoolNamesToCoordsInteractor : NSObject <TranslateSchoolNamesToCoordsInteractorInputProtocol>

@property (nonatomic, weak) id <TranslateSchoolNamesToCoordsInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <TranslateSchoolNamesToCoordsAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <TranslateSchoolNamesToCoordsLocalDataManagerInputProtocol> localDataManager;

@end