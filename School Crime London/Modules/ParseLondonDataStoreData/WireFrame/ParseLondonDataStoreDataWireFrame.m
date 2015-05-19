//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ParseLondonDataStoreDataWireFrame.h"

@implementation ParseLondonDataStoreDataWireFrame

+ (void)presentParseLondonDataStoreDataModuleFrom:(NSWindowController*)fromViewController
{
    // Generating module components
    id <ParseLondonDataStoreDataViewProtocol> view = [[ParseLondonDataStoreDataView alloc] init];
    id <ParseLondonDataStoreDataPresenterProtocol, ParseLondonDataStoreDataInteractorOutputProtocol> presenter = [ParseLondonDataStoreDataPresenter new];
    id <ParseLondonDataStoreDataInteractorInputProtocol> interactor = [ParseLondonDataStoreDataInteractor new];
    id <ParseLondonDataStoreDataAPIDataManagerInputProtocol> APIDataManager = [ParseLondonDataStoreDataAPIDataManager new];
    id <ParseLondonDataStoreDataLocalDataManagerInputProtocol> localDataManager = [ParseLondonDataStoreDataLocalDataManager new];
    id <ParseLondonDataStoreDataWireFrameProtocol> wireFrame= [ParseLondonDataStoreDataWireFrame new];
    
    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;
    
    [interactor parseData];
    
    //TOODO - New view controller presentation (present, push, pop, .. )
}

@end
