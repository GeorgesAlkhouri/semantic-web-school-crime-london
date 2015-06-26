//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGameDataWireFrame.h"

@implementation ExtractGameDataWireFrame

+ (instancetype)
presentExtractGameDataModuleFrom:(id)fromView
                         withDelegate:(id<MainViewExtractGameDataDelegateProtocol>)delegate {

    // Generating module components
    id<ExtractGameDataViewProtocol> view =
        [[ExtractGameDataView alloc] init];
    id<ExtractGameDataPresenterProtocol,
       ExtractGameDataInteractorOutputProtocol> presenter =
        [ExtractGameDataPresenter new];
    id<ExtractGameDataInteractorInputProtocol> interactor =
        [ExtractGameDataInteractor new];
    id<ExtractGameDataAPIDataManagerInputProtocol> APIDataManager =
        [ExtractGameDataAPIDataManager new];
    id<ExtractGameDataLocalDataManagerInputProtocol> localDataManager =
        [ExtractGameDataLocalDataManager new];
    id<ExtractGameDataWireFrameProtocol> wireFrame =
        [ExtractGameDataWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;

    delegate.extractGameDataConnection = presenter;
    presenter.mainViewDelegate = delegate;

    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    [(ExtractGameDataWireFrame *)wireFrame setPresenter:presenter];

    return (ExtractGameDataWireFrame *)wireFrame;
}

@end
