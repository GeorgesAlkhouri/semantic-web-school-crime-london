//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtractGameDataProtocols.h"


@interface ExtractGameDataInteractor : NSObject <ExtractGameDataInteractorInputProtocol>

@property (nonatomic, weak) id <ExtractGameDataInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <ExtractGameDataAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <ExtractGameDataLocalDataManagerInputProtocol> localDataManager;

@end