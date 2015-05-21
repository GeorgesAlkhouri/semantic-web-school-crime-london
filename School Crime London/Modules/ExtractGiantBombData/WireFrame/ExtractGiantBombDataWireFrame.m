//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataWireFrame.h"

@interface ExtractGiantBombDataWireFrame ()

@property(nonatomic, weak) id<ExtractGiantBombDataPresenterProtocol> presenter;

@end

@implementation ExtractGiantBombDataWireFrame

+ (instancetype)presentExtractGiantBombDataModuleFrom:
    (NSWindowController *)fromViewController {

    // Generating module components
    id<ExtractGiantBombDataViewProtocol> view =
        [[ExtractGiantBombDataView alloc] init];
    id<ExtractGiantBombDataPresenterProtocol,
       ExtractGiantBombDataInteractorOutputProtocol> presenter =
        [ExtractGiantBombDataPresenter new];
    id<ExtractGiantBombDataInteractorInputProtocol> interactor =
        [ExtractGiantBombDataInteractor new];
    id<ExtractGiantBombDataAPIDataManagerInputProtocol> APIDataManager =
        [ExtractGiantBombDataAPIDataManager new];
    id<ExtractGiantBombDataLocalDataManagerInputProtocol> localDataManager =
        [ExtractGiantBombDataLocalDataManager new];
    id<ExtractGiantBombDataWireFrameProtocol> wireFrame =
        [ExtractGiantBombDataWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    [(ExtractGiantBombDataWireFrame *)wireFrame setPresenter:presenter];

    return (ExtractGiantBombDataWireFrame *)wireFrame;
}

@end
