//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtractGameDataProtocols.h"

@class ExtractGameDataWireFrame;

@interface ExtractGameDataPresenter
    : NSObject <ExtractGameDataPresenterProtocol,
                ExtractGameDataInteractorOutputProtocol>

@property(nonatomic, weak) id<ExtractGameDataViewProtocol> view;
@property(nonatomic, strong)
    id<ExtractGameDataInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<ExtractGameDataWireFrameProtocol> wireFrame;

@property(nonatomic, weak) id<MainViewExtractGameDataDelegateProtocol> mainViewDelegate;

@end
