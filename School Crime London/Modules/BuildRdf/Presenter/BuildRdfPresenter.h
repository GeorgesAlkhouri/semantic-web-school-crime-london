//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildRdfProtocols.h"

@class BuildRdfWireFrame;

@interface BuildRdfPresenter : NSObject <BuildRdfPresenterProtocol, BuildRdfInteractorOutputProtocol>

@property (nonatomic, weak) id <BuildRdfViewProtocol> view;
@property (nonatomic, strong) id <BuildRdfInteractorInputProtocol> interactor;
@property (nonatomic, strong) id <BuildRdfWireFrameProtocol> wireFrame;

@end
