//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol ExtractGameDataInteractorOutputProtocol;
@protocol ExtractGameDataInteractorInputProtocol;
@protocol ExtractGameDataViewProtocol;
@protocol ExtractGameDataPresenterProtocol;
@protocol ExtractGameDataLocalDataManagerInputProtocol;
@protocol ExtractGameDataAPIDataManagerInputProtocol;
@protocol ExtractGameDataConnectionProtocol;

@protocol MainViewExtractGameDataDelegateProtocol;

@protocol ExtractGameDataConnectionProtocol <NSObject>
@property(nonatomic, weak)
    id<MainViewExtractGameDataDelegateProtocol> mainViewDelegate;
- (void)extractGameData;
@end

@protocol ExtractGameDataViewProtocol
@required
@property(nonatomic, strong) id<ExtractGameDataPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@class ExtractGameDataWireFrame;

@protocol ExtractGameDataWireFrameProtocol
@required
@property(nonatomic, weak) id<ExtractGameDataPresenterProtocol> presenter;

+ (instancetype)presentExtractGameDataModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewExtractGameDataDelegateProtocol>)delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol ExtractGameDataPresenterProtocol <ExtractGameDataConnectionProtocol>
@required
@property(nonatomic, weak) id<ExtractGameDataViewProtocol> view;
@property(nonatomic, strong)
    id<ExtractGameDataInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<ExtractGameDataWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol ExtractGameDataInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */

- (void)extractionFinishedWithResults:(NSArray *)results;
- (void)errorOccurred:(NSError *)error;

/*
 * Param: progress in percent
 */
- (void)progressUpdated:(double)progress;

@end

@protocol ExtractGameDataInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<ExtractGameDataInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<ExtractGameDataAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<ExtractGameDataLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (void)startDataExtraction;

@end

@protocol ExtractGameDataDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol ExtractGameDataAPIDataManagerInputProtocol <
    ExtractGameDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */

- (void)extractPegiMetaDataWithCompletion:(void (^)(NSError *error,
                                                    id result))completion;

- (void)extractPegiDataWithMaxPageCount:(NSNumber *)pageCount
                          progressBlock:
                              (void (^)(NSUInteger numberOfFinishedOperations,
                                        NSUInteger totalNumberOfOperations))
                                  progressBlock
                             completion:(void (^)(NSError *error,
                                                  NSArray *results))completion;

@end

@protocol ExtractGameDataLocalDataManagerInputProtocol <
    ExtractGameDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
