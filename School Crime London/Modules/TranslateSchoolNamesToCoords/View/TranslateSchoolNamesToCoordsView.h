//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TranslateSchoolNamesToCoordsProtocols.h"

@interface TranslateSchoolNamesToCoordsView : NSViewController <TranslateSchoolNamesToCoordsViewProtocol>

@property (nonatomic, strong) id <TranslateSchoolNamesToCoordsPresenterProtocol> presenter;

@end
