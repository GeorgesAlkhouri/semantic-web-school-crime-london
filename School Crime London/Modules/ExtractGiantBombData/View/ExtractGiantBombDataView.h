//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ExtractGiantBombDataProtocols.h"

@interface ExtractGiantBombDataView : NSViewController <ExtractGiantBombDataViewProtocol>

@property (nonatomic, strong) id <ExtractGiantBombDataPresenterProtocol> presenter;

@end
