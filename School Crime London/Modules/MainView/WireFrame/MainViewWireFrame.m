//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewWireFrame.h"

#import "ExtractGameDataWireFrame.h"
#import "ParseLondonDataStoreDataWireFrame.h"
#import "TranslateSchoolNamesToCoordsWireFrame.h"
#import "SearchCrimeSceneWireFrame.h"
#import "BuildRdfWireFrame.h"
#import "TripleStoreQueryWireFrame.h"

@interface MainViewWireFrame ()

@property(nonatomic) ExtractGameDataWireFrame *extractGameDataWireFrame;
@property(nonatomic)
    ParseLondonDataStoreDataWireFrame *parseLondonDataStoreDataWireFrame;
@property(nonatomic) TranslateSchoolNamesToCoordsWireFrame
    *translateSchoolNamesToCoordsWireFrame;
@property(nonatomic) SearchCrimeSceneWireFrame *searchCrimeSceneWireFrame;
@property(nonatomic) BuildRdfWireFrame *buildRdfWireFrame;
@property(nonatomic) TripleStoreQueryWireFrame *tripleStoreQueryWireFrame;

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
        setExtractGameDataWireFrame:[ExtractGameDataWireFrame
                                        presentExtractGameDataModuleFrom:
                                            nil withDelegate:presenter]];
    [(MainViewWireFrame *)wireFrame
        setParseLondonDataStoreDataWireFrame:
            [ParseLondonDataStoreDataWireFrame
                presentParseLondonDataStoreDataModuleFrom:nil
                                             withDelegate:presenter]];

    [(MainViewWireFrame *)wireFrame
        setTranslateSchoolNamesToCoordsWireFrame:
            [TranslateSchoolNamesToCoordsWireFrame
                presentExtractGameDataModuleFrom:nil
                                    withDelegate:presenter]];

    [(MainViewWireFrame *)wireFrame
        setSearchCrimeSceneWireFrame:[SearchCrimeSceneWireFrame
                                         presentSearchCrimeSceneModuleFrom:
                                             nil withDelegate:presenter]];

    [(MainViewWireFrame *)wireFrame
        setBuildRdfWireFrame:[BuildRdfWireFrame
                                 presentBuildRdfModuleFrom:nil
                                              withDelegate:presenter]];

    [(MainViewWireFrame *)wireFrame
        setTripleStoreQueryWireFrame:[TripleStoreQueryWireFrame
                                         presentTripleStoreQueryModuleFrom:
                                             nil withDelegate:presenter]];

    [(MainViewWireFrame *)wireFrame setPresenter:presenter];

    [fromViewController showWindow:self];

    return (MainViewWireFrame *)wireFrame;
}

@end
