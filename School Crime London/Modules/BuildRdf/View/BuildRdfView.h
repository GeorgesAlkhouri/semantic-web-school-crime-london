//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BuildRdfProtocols.h"

@interface BuildRdfView : NSViewController <BuildRdfViewProtocol>

@property (nonatomic, strong) id <BuildRdfPresenterProtocol> presenter;

@end
