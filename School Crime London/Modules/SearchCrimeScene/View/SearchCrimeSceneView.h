//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SearchCrimeSceneProtocols.h"

@interface SearchCrimeSceneView : NSViewController <SearchCrimeSceneViewProtocol>

@property (nonatomic, strong) id <SearchCrimeScenePresenterProtocol> presenter;

@end
