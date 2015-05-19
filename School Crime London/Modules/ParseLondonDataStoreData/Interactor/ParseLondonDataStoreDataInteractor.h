//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseLondonDataStoreDataProtocols.h"


@interface ParseLondonDataStoreDataInteractor : NSObject <ParseLondonDataStoreDataInteractorInputProtocol>

@property (nonatomic, weak) id <ParseLondonDataStoreDataInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <ParseLondonDataStoreDataAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <ParseLondonDataStoreDataLocalDataManagerInputProtocol> localDataManager;

@end