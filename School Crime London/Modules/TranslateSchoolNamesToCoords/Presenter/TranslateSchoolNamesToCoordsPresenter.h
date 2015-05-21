//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateSchoolNamesToCoordsProtocols.h"

@class TranslateSchoolNamesToCoordsWireFrame;

@interface TranslateSchoolNamesToCoordsPresenter : NSObject <TranslateSchoolNamesToCoordsPresenterProtocol, TranslateSchoolNamesToCoordsInteractorOutputProtocol>

@property (nonatomic, weak) id <TranslateSchoolNamesToCoordsViewProtocol> view;
@property (nonatomic, strong) id <TranslateSchoolNamesToCoordsInteractorInputProtocol> interactor;
@property (nonatomic, strong) id <TranslateSchoolNamesToCoordsWireFrameProtocol> wireFrame;

@property(nonatomic, weak) id<MainViewTranslateSchoolNamesToCoordsDelegateProtocol> mainViewDelegate;

@end
