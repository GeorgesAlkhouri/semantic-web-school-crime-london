//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewProtocols.h"
#import "ExtractGiantBombDataProtocols.h"

@class MainViewWireFrame;

@interface MainViewPresenter
    : NSObject <MainViewPresenterProtocol, MainViewInteractorOutputProtocol>

@property(nonatomic, weak) id<MainViewViewProtocol> view;
@property(nonatomic, strong) id<MainViewInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<MainViewWireFrameProtocol> wireFrame;

@property(nonatomic, strong)
    id<ExtractGiantBombDataConnectionProtocol> extractGiantBombDataConnection;

@end
