//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataWireFrame.h"

@implementation ExtractGiantBombDataWireFrame

+ (void)presentExtractGiantBombDataModuleFrom:(NSViewController*)fromViewController
{
    // Generating module components
    id <ExtractGiantBombDataViewProtocol> view = [[ExtractGiantBombDataView alloc] init];
    id <ExtractGiantBombDataPresenterProtocol, ExtractGiantBombDataInteractorOutputProtocol> presenter = [ExtractGiantBombDataPresenter new];
    id <ExtractGiantBombDataInteractorInputProtocol> interactor = [ExtractGiantBombDataInteractor new];
    id <ExtractGiantBombDataAPIDataManagerInputProtocol> APIDataManager = [ExtractGiantBombDataAPIDataManager new];
    id <ExtractGiantBombDataLocalDataManagerInputProtocol> localDataManager = [ExtractGiantBombDataLocalDataManager new];
    id <ExtractGiantBombDataWireFrameProtocol> wireFrame= [ExtractGiantBombDataWireFrame new];
    
    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;
    
    //TOODO - New view controller presentation (present, push, pop, .. )
}

@end
