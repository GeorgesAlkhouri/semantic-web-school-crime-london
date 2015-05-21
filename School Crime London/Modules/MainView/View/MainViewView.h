//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewProtocols.h"

@interface MainViewView : NSViewController <MainViewViewProtocol>

@property (nonatomic, strong) id <MainViewPresenterProtocol> presenter;

@end
