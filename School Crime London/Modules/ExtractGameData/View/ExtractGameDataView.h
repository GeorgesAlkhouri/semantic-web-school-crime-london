//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ExtractGameDataProtocols.h"

@interface ExtractGameDataView : NSViewController <ExtractGameDataViewProtocol>

@property (nonatomic, strong) id <ExtractGameDataPresenterProtocol> presenter;

@end
