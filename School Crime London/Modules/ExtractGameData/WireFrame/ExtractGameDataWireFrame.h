//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewProtocols.h"
#import "ExtractGameDataProtocols.h"
#import "ExtractGameDataView.h"
#import "ExtractGameDataLocalDataManager.h"
#import "ExtractGameDataAPIDataManager.h"
#import "ExtractGameDataInteractor.h"
#import "ExtractGameDataPresenter.h"
#import "ExtractGameDataWireframe.h"
#import <Cocoa/Cocoa.h>

@interface ExtractGameDataWireFrame
    : NSObject <ExtractGameDataWireFrameProtocol>

@property(nonatomic, weak) id<ExtractGameDataPresenterProtocol> presenter;

@end
