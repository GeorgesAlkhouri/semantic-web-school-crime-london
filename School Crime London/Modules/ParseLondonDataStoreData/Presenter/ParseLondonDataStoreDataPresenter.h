//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseLondonDataStoreDataProtocols.h"

@class ParseLondonDataStoreDataWireFrame;

@interface ParseLondonDataStoreDataPresenter
    : NSObject <ParseLondonDataStoreDataPresenterProtocol,
                ParseLondonDataStoreDataInteractorOutputProtocol>

@property(nonatomic, weak) id<ParseLondonDataStoreDataViewProtocol> view;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataWireFrameProtocol> wireFrame;

@property(nonatomic, weak)
    id<MainViewParseLondonDataStoreDataDelegateProtocol> mainViewDelegate;

@end
