//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewProtocols.h"
#import "ExtractGiantBombDataProtocols.h"
#import "TranslateSchoolNamesToCoordsProtocols.h"
#import "ParseLondonDataStoreDataProtocols.h"
#import "SearchCrimeSceneProtocols.h"
#import "BuildRdfProtocols.h"

@class MainViewWireFrame;

@interface MainViewPresenter
    : NSObject <MainViewPresenterProtocol, MainViewInteractorOutputProtocol>

@property(nonatomic, weak) id<MainViewViewProtocol> view;
@property(nonatomic, strong) id<MainViewInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<MainViewWireFrameProtocol> wireFrame;

@property(nonatomic, strong)
    id<ExtractGiantBombDataConnectionProtocol> extractGiantBombDataConnection;
@property(nonatomic, strong) id<TranslateSchoolNamesToCoordsConnectionProtocol>
    translateSchoolNamesToCoordsConnection;
@property(nonatomic, strong) id<ParseLondonDataStoreDataConnectionProtocol>
    parseLondonDataStoreDataConnection;
@property(nonatomic, strong)
    id<SearchCrimeSceneConnectionProtocol> searchCrimeSceneConnection;
@property(nonatomic, strong) id<BuildRdfConnectionProtocol> buildRdfConnection;

@end
