//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtractGiantBombDataProtocols.h"


@interface ExtractGiantBombDataInteractor : NSObject <ExtractGiantBombDataInteractorInputProtocol>

@property (nonatomic, weak) id <ExtractGiantBombDataInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <ExtractGiantBombDataAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <ExtractGiantBombDataLocalDataManagerInputProtocol> localDataManager;

@end