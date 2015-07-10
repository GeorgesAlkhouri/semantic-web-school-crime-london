//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripleStoreQueryProtocols.h"


@interface TripleStoreQueryInteractor : NSObject <TripleStoreQueryInteractorInputProtocol>

@property (nonatomic, weak) id <TripleStoreQueryInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <TripleStoreQueryAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <TripleStoreQueryLocalDataManagerInputProtocol> localDataManager;

@end