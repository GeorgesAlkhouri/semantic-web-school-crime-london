//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol MainViewInteractorOutputProtocol;
@protocol MainViewInteractorInputProtocol;
@protocol MainViewViewProtocol;
@protocol MainViewPresenterProtocol;
@protocol MainViewLocalDataManagerInputProtocol;
@protocol MainViewAPIDataManagerInputProtocol;


@class MainViewWireFrame;

@protocol MainViewViewProtocol
@required
@property (nonatomic, strong) id <MainViewPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */

- (void)setInfoLabelText:(NSString *)text;

@end

@protocol MainViewWireFrameProtocol
@required
+ (instancetype)presentMainViewModuleFrom:(id)fromView;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol MainViewPresenterProtocol
@required
@property (nonatomic, weak) id <MainViewViewProtocol> view;
@property (nonatomic, strong) id <MainViewInteractorInputProtocol> interactor;
@property (nonatomic, strong) id <MainViewWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */

- (void)actionButtonPressed;
- (void)setGiantBombAPIKey:(NSString *)APIKey;
- (void)setGeofencingAPIKey:(NSString *)APIKey;

@end

@protocol MainViewInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol MainViewInteractorInputProtocol
@required
@property (nonatomic, weak) id <MainViewInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <MainViewAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <MainViewLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */
@end


@protocol MainViewDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol MainViewAPIDataManagerInputProtocol <MainViewDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */
@end

@protocol MainViewLocalDataManagerInputProtocol <MainViewDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end


