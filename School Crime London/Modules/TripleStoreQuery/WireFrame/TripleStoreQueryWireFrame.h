//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripleStoreQueryProtocols.h"
#import "TripleStoreQueryView.h"
#import "TripleStoreQueryLocalDataManager.h"
#import "TripleStoreQueryAPIDataManager.h"
#import "TripleStoreQueryInteractor.h"
#import "TripleStoreQueryPresenter.h"
#import "TripleStoreQueryWireframe.h"
#import <Cocoa/Cocoa.h>

@interface TripleStoreQueryWireFrame
    : NSObject <TripleStoreQueryWireFrameProtocol>

@end
