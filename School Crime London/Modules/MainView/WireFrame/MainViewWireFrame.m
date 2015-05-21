//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewWireFrame.h"

#import "ExtractGiantBombDataWireFrame.h"
#import "ParseLondonDataStoreDataWireFrame.h"

@interface MainViewWireFrame ()

@property(nonatomic)
    ExtractGiantBombDataWireFrame *extractGiantBombDataWireFrame;
@property(nonatomic)
    ParseLondonDataStoreDataWireFrame *parseLondonDataStoreDataWireFrame;

@property(nonatomic, weak) id<MainViewPresenterProtocol> presenter;

@end

@implementation MainViewWireFrame

+ (instancetype)presentMainViewModuleFrom:
    (NSWindowController *)fromViewController {

    // Generating module components
    id<MainViewViewProtocol> view =
        (id<MainViewViewProtocol>)fromViewController.contentViewController;
    id<MainViewPresenterProtocol, MainViewInteractorOutputProtocol> presenter =
        [MainViewPresenter new];
    id<MainViewInteractorInputProtocol> interactor = [MainViewInteractor new];
    id<MainViewAPIDataManagerInputProtocol> APIDataManager =
        [MainViewAPIDataManager new];
    id<MainViewLocalDataManagerInputProtocol> localDataManager =
        [MainViewLocalDataManager new];
    id<MainViewWireFrameProtocol> wireFrame = [MainViewWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    // Building dependencies

    [(MainViewWireFrame *)wireFrame
        setExtractGiantBombDataWireFrame:
            [ExtractGiantBombDataWireFrame
                presentExtractGiantBombDataModuleFrom:nil]];
    [(MainViewWireFrame *)wireFrame
        setParseLondonDataStoreDataWireFrame:
            [ParseLondonDataStoreDataWireFrame
                presentParseLondonDataStoreDataModuleFrom:nil]];

    [(MainViewWireFrame *)wireFrame setPresenter:presenter];

    [fromViewController showWindow:self];

    return (MainViewWireFrame *)wireFrame;
}

@end