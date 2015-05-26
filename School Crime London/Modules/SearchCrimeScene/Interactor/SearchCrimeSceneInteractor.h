//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCrimeSceneProtocols.h"


@interface SearchCrimeSceneInteractor : NSObject <SearchCrimeSceneInteractorInputProtocol>

@property (nonatomic, weak) id <SearchCrimeSceneInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <SearchCrimeSceneAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <SearchCrimeSceneLocalDataManagerInputProtocol> localDataManager;

@end