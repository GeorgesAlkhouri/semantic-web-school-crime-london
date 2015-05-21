//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ParseLondonDataStoreDataPresenter.h"
#import "ParseLondonDataStoreDataWireframe.h"

@implementation ParseLondonDataStoreDataPresenter

- (NSArray *)parseLondonDataStoreData:(NSError *__autoreleasing *)error {

    [self.interactor parseData];

    return nil;
}

@end