//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCrimeSceneProtocols.h"

#import "MainViewProtocols.h"

@class SearchCrimeSceneWireFrame;

@interface SearchCrimeScenePresenter
    : NSObject <SearchCrimeScenePresenterProtocol,
                SearchCrimeSceneInteractorOutputProtocol>

@property(nonatomic, weak) id<SearchCrimeSceneViewProtocol> view;
@property(nonatomic, strong)
    id<SearchCrimeSceneInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<SearchCrimeSceneWireFrameProtocol> wireFrame;

@property(nonatomic, weak)
    id<MainViewSearchCrimeSceneDelegateProtocol> mainViewDelegate;

@end
