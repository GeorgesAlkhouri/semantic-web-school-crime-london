//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TripleStoreQueryProtocols.h"

@interface TripleStoreQueryView : NSViewController <TripleStoreQueryViewProtocol>

@property (nonatomic, strong) id <TripleStoreQueryPresenterProtocol> presenter;

@end
