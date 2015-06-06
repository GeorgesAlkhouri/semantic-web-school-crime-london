//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildRdfProtocols.h"


@interface BuildRdfInteractor : NSObject <BuildRdfInteractorInputProtocol>

@property (nonatomic, weak) id <BuildRdfInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <BuildRdfAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <BuildRdfLocalDataManagerInputProtocol> localDataManager;

@end