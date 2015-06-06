//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "BuildRdfWireFrame.h"

@implementation BuildRdfWireFrame

+ (void)presentBuildRdfModuleFrom:(NSViewController *)fromViewController {
    // Generating module components
    id<BuildRdfViewProtocol> view = [[BuildRdfView alloc] init];
    id<BuildRdfPresenterProtocol, BuildRdfInteractorOutputProtocol> presenter =
        [BuildRdfPresenter new];
    id<BuildRdfInteractorInputProtocol> interactor = [BuildRdfInteractor new];
    id<BuildRdfAPIDataManagerInputProtocol> APIDataManager =
        [BuildRdfAPIDataManager new];
    id<BuildRdfLocalDataManagerInputProtocol> localDataManager =
        [BuildRdfLocalDataManager new];
    id<BuildRdfWireFrameProtocol> wireFrame = [BuildRdfWireFrame new];

    // Connecting
    view.presenter = presenter;
    presenter.view = view;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.APIDataManager = APIDataManager;
    interactor.localDataManager = localDataManager;

    // TOODO - New view controller presentation (present, push, pop, .. )
}

@end
