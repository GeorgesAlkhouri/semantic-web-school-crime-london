//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol BuildRdfInteractorOutputProtocol;
@protocol BuildRdfInteractorInputProtocol;
@protocol BuildRdfViewProtocol;
@protocol BuildRdfPresenterProtocol;
@protocol BuildRdfLocalDataManagerInputProtocol;
@protocol BuildRdfAPIDataManagerInputProtocol;


@class BuildRdfWireFrame;

@protocol BuildRdfViewProtocol
@required
@property (nonatomic, strong) id <BuildRdfPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol BuildRdfWireFrameProtocol
@required
+ (void)presentBuildRdfModuleFrom:(id)fromView;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol BuildRdfPresenterProtocol
@required
@property (nonatomic, weak) id <BuildRdfViewProtocol> view;
@property (nonatomic, strong) id <BuildRdfInteractorInputProtocol> interactor;
@property (nonatomic, strong) id <BuildRdfWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol BuildRdfInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol BuildRdfInteractorInputProtocol
@required
@property (nonatomic, weak) id <BuildRdfInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <BuildRdfAPIDataManagerInputProtocol> APIDataManager;
@property (nonatomic, strong) id <BuildRdfLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */
@end


@protocol BuildRdfDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol BuildRdfAPIDataManagerInputProtocol <BuildRdfDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */
@end

@protocol BuildRdfLocalDataManagerInputProtocol <BuildRdfDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end


