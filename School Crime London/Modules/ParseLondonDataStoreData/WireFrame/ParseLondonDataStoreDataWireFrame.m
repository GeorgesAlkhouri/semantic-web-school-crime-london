//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ParseLondonDataStoreDataWireFrame.h"

@interface ParseLondonDataStoreDataWireFrame ()

@property(nonatomic, weak)
    id<ParseLondonDataStoreDataPresenterProtocol> presenter;

@end

@implementation ParseLondonDataStoreDataWireFrame

+ (instancetype)presentParseLondonDataStoreDataModuleFrom:
    (NSWindowController *)fromViewController {

    // Generating module components
    id<ParseLondonDataStoreDataViewProtocol> view =
        [[ParseLondonDataStoreDataView alloc] init];
    id<ParseLondonDataStoreDataPresenterProtocol,
       ParseLondonDataStoreDataInteractorOutputProtocol> presenter =
        [ParseLondonDataStoreDataPresenter new];
    id<ParseLondonDataStoreDataInteractorInputProtocol> interactor =
        [ParseLondonDataStoreDataInteractor new];
    id<ParseLondonDataStoreDataAPIDataManagerInputProtocol> APIDataManager =
        [ParseLondonDataStoreDataAPIDataManager new];
    id<ParseLondonDataStoreDataLocalDataManagerInputProtocol> localDataManager =
        [ParseLondonDataStoreDataLocalDataManager new];
    id<ParseLondonDataStoreDataWireFrameProtocol> wireFrame =
        [ParseLondonDataStoreDataWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    [interactor parseData];

    [(ParseLondonDataStoreDataWireFrame *)wireFrame setPresenter:presenter];

    return (ParseLondonDataStoreDataWireFrame *)wireFrame;
}

@end
