//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ParseLondonDataStoreDataProtocols.h"

@interface ParseLondonDataStoreDataView : NSViewController <ParseLondonDataStoreDataViewProtocol>

@property (nonatomic, strong) id <ParseLondonDataStoreDataPresenterProtocol> presenter;

@end
