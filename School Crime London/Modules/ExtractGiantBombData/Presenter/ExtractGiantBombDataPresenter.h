//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtractGiantBombDataProtocols.h"

@class ExtractGiantBombDataWireFrame;

@interface ExtractGiantBombDataPresenter
    : NSObject <ExtractGiantBombDataPresenterProtocol,
                ExtractGiantBombDataInteractorOutputProtocol>

@property(nonatomic, weak) id<ExtractGiantBombDataViewProtocol> view;
@property(nonatomic, strong)
    id<ExtractGiantBombDataInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<ExtractGiantBombDataWireFrameProtocol> wireFrame;

@property(nonatomic, weak) id<MainViewExtractGiantBombDataDelegateProtocol> mainViewDelegate;

@end
