//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewProtocols.h"


@interface MainViewInteractor : NSObject <MainViewInteractorInputProtocol>

@property (nonatomic, weak) id <MainViewInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <MainViewAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <MainViewLocalDataManagerInputProtocol> localDataManager;

@end