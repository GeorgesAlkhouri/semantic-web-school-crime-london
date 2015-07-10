//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol SearchCrimeSceneInteractorOutputProtocol;
@protocol SearchCrimeSceneInteractorInputProtocol;
@protocol SearchCrimeSceneViewProtocol;
@protocol SearchCrimeScenePresenterProtocol;
@protocol SearchCrimeSceneLocalDataManagerInputProtocol;
@protocol SearchCrimeSceneAPIDataManagerInputProtocol;
@protocol SearchCrimeSceneConnectionProtocol;
@protocol MainViewSearchCrimeSceneDelegateProtocol;

@protocol SearchCrimeSceneConnectionProtocol <NSObject>

@property(nonatomic, weak)
    id<MainViewSearchCrimeSceneDelegateProtocol> mainViewDelegate;

- (void)requestPoliceDataForGames:(NSArray *)games
                       schoolData:(NSArray *)schoolData;

@end

@class SearchCrimeSceneWireFrame;

@protocol SearchCrimeSceneViewProtocol
@required
@property(nonatomic, strong) id<SearchCrimeScenePresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol SearchCrimeSceneWireFrameProtocol
@required
+ (instancetype)presentSearchCrimeSceneModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewSearchCrimeSceneDelegateProtocol>)delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol SearchCrimeScenePresenterProtocol <SearchCrimeSceneConnectionProtocol>
@required
@property(nonatomic, weak) id<SearchCrimeSceneViewProtocol> view;
@property(nonatomic, strong)
    id<SearchCrimeSceneInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<SearchCrimeSceneWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol SearchCrimeSceneInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */

- (void)requestSucceededWithResults:(NSArray *)result;
- (void)requestFailedWithError:(NSError *)error;

/*
 * Param: progress in percent
 */
- (void)progressUpdated:(double)progress;

@end

@protocol SearchCrimeSceneInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<SearchCrimeSceneInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<SearchCrimeSceneAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<SearchCrimeSceneLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (void)requestCrimeScenesWithSchoolData:(NSArray *)schoolData
                                gameData:(NSArray *)gameData;

@end

@protocol SearchCrimeSceneDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol SearchCrimeSceneAPIDataManagerInputProtocol <
    SearchCrimeSceneDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */

- (void)
requestPoliceDataStoreWithParameters:(NSArray *)parameter
                       progressBlock:
                           (void (^)(NSUInteger numberOfFinishedOperations,
                                     NSUInteger totalNumberOfOperations))
                               progressBlock
                          completion:(void (^)(NSArray *results,
                                               NSError *error))completion;

@end

@protocol SearchCrimeSceneLocalDataManagerInputProtocol <
    SearchCrimeSceneDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
