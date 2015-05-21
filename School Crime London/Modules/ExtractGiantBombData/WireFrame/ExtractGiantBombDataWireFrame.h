//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewProtocols.h"
#import "ExtractGiantBombDataProtocols.h"
#import "ExtractGiantBombDataView.h"
#import "ExtractGiantBombDataLocalDataManager.h"
#import "ExtractGiantBombDataAPIDataManager.h"
#import "ExtractGiantBombDataInteractor.h"
#import "ExtractGiantBombDataPresenter.h"
#import "ExtractGiantBombDataWireframe.h"
#import <Cocoa/Cocoa.h>

@interface ExtractGiantBombDataWireFrame
    : NSObject <ExtractGiantBombDataWireFrameProtocol>

@property(nonatomic, weak) id<ExtractGiantBombDataPresenterProtocol> presenter;

@end
