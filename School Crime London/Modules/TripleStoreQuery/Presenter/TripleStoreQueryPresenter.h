//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripleStoreQueryProtocols.h"

@class TripleStoreQueryWireFrame;

@interface TripleStoreQueryPresenter
    : NSObject <TripleStoreQueryPresenterProtocol,
                TripleStoreQueryInteractorOutputProtocol>

@property(nonatomic, weak) id<TripleStoreQueryViewProtocol> view;
@property(nonatomic, strong)
    id<TripleStoreQueryInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<TripleStoreQueryWireFrameProtocol> wireFrame;

@property(nonatomic, weak)
    id<MainViewTripleStoreQueryDelegateProtocol> mainViewDelegate;

@end
