//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsWireFrame.h"

@implementation TranslateSchoolNamesToCoordsWireFrame

+ (instancetype)
presentExtractGameDataModuleFrom:
    (id)fromView withDelegate:
        (id<MainViewTranslateSchoolNamesToCoordsDelegateProtocol>)delegate {

    // Generating module components
    id<TranslateSchoolNamesToCoordsViewProtocol> view =
        [[TranslateSchoolNamesToCoordsView alloc] init];
    id<TranslateSchoolNamesToCoordsPresenterProtocol,
       TranslateSchoolNamesToCoordsInteractorOutputProtocol> presenter =
        [TranslateSchoolNamesToCoordsPresenter new];
    id<TranslateSchoolNamesToCoordsInteractorInputProtocol> interactor =
        [TranslateSchoolNamesToCoordsInteractor new];
    id<TranslateSchoolNamesToCoordsAPIDataManagerInputProtocol> APIDataManager =
        [TranslateSchoolNamesToCoordsAPIDataManager new];
    id<TranslateSchoolNamesToCoordsLocalDataManagerInputProtocol>
        localDataManager = [TranslateSchoolNamesToCoordsLocalDataManager new];
    id<TranslateSchoolNamesToCoordsWireFrameProtocol> wireFrame =
        [TranslateSchoolNamesToCoordsWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;

    delegate.translateSchoolNamesToCoordsConnection = presenter;
    presenter.mainViewDelegate = delegate;

    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    // TOODO - New view controller presentation (present, push, pop, .. )

    return (TranslateSchoolNamesToCoordsWireFrame *)wireFrame;
}

@end
