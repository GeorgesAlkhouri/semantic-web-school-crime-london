//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeSceneWireFrame.h"

@implementation SearchCrimeSceneWireFrame

+ (instancetype)presentSearchCrimeSceneModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewSearchCrimeSceneDelegateProtocol>)delegate {

    // Generating module components
    id<SearchCrimeSceneViewProtocol> view = [[SearchCrimeSceneView alloc] init];
    id<SearchCrimeScenePresenterProtocol,
       SearchCrimeSceneInteractorOutputProtocol> presenter =
        [SearchCrimeScenePresenter new];
    id<SearchCrimeSceneInteractorInputProtocol> interactor =
        [SearchCrimeSceneInteractor new];
    id<SearchCrimeSceneAPIDataManagerInputProtocol> APIDataManager =
        [SearchCrimeSceneAPIDataManager new];
    id<SearchCrimeSceneLocalDataManagerInputProtocol> localDataManager =
        [SearchCrimeSceneLocalDataManager new];
    id<SearchCrimeSceneWireFrameProtocol> wireFrame =
        [SearchCrimeSceneWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;

    delegate.searchCrimeSceneConnection = presenter;
    presenter.mainViewDelegate = delegate;

    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    // TOODO - New view controller presentation (present, push, pop, .. )

    return (SearchCrimeSceneWireFrame *)wireFrame;
}

@end
