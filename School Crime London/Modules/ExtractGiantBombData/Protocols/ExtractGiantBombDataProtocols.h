//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol ExtractGiantBombDataInteractorOutputProtocol;
@protocol ExtractGiantBombDataInteractorInputProtocol;
@protocol ExtractGiantBombDataViewProtocol;
@protocol ExtractGiantBombDataPresenterProtocol;
@protocol ExtractGiantBombDataLocalDataManagerInputProtocol;
@protocol ExtractGiantBombDataAPIDataManagerInputProtocol;


@class ExtractGiantBombDataWireFrame;

@protocol ExtractGiantBombDataViewProtocol
@required
@property (nonatomic, strong) id <ExtractGiantBombDataPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol ExtractGiantBombDataWireFrameProtocol
@required
+ (void)presentExtractGiantBombDataModuleFrom:(id)fromView;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol ExtractGiantBombDataPresenterProtocol
@required
@property (nonatomic, weak) id <ExtractGiantBombDataViewProtocol> view;
@property (nonatomic, strong) id <ExtractGiantBombDataInteractorInputProtocol> interactor;
@property (nonatomic, strong) id <ExtractGiantBombDataWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol ExtractGiantBombDataInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol ExtractGiantBombDataInteractorInputProtocol
@required
@property (nonatomic, weak) id <ExtractGiantBombDataInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <ExtractGiantBombDataAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <ExtractGiantBombDataLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */
@end


@protocol ExtractGiantBombDataDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol ExtractGiantBombDataAPIDataManagerInputProtocol <ExtractGiantBombDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */
@end

@protocol ExtractGiantBombDataLocalDataManagerInputProtocol <ExtractGiantBombDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end


