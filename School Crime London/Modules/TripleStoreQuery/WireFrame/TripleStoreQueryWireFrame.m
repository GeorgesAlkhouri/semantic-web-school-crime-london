//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TripleStoreQueryWireFrame.h"
#import "MainViewProtocols.h"

@implementation TripleStoreQueryWireFrame

+ (instancetype)presentTripleStoreQueryModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewTripleStoreQueryDelegateProtocol>)delegate {
    // Generating module components
    id<TripleStoreQueryViewProtocol> view = [[TripleStoreQueryView alloc] init];
    id<TripleStoreQueryPresenterProtocol,
       TripleStoreQueryInteractorOutputProtocol> presenter =
        [TripleStoreQueryPresenter new];
    id<TripleStoreQueryInteractorInputProtocol> interactor =
        [TripleStoreQueryInteractor new];
    id<TripleStoreQueryAPIDataManagerInputProtocol> APIDataManager =
        [TripleStoreQueryAPIDataManager new];
    id<TripleStoreQueryLocalDataManagerInputProtocol> localDataManager =
        [TripleStoreQueryLocalDataManager new];
    id<TripleStoreQueryWireFrameProtocol> wireFrame =
        [TripleStoreQueryWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    
    delegate.tripleStoreQueryConnection = presenter;
    presenter.mainViewDelegate = delegate;
    
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    return (TripleStoreQueryWireFrame *)wireFrame;
}

@end
