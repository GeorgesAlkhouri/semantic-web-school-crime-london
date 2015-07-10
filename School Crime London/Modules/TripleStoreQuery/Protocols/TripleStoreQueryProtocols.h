//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol TripleStoreQueryInteractorOutputProtocol;
@protocol TripleStoreQueryInteractorInputProtocol;
@protocol TripleStoreQueryViewProtocol;
@protocol TripleStoreQueryPresenterProtocol;
@protocol TripleStoreQueryLocalDataManagerInputProtocol;
@protocol TripleStoreQueryAPIDataManagerInputProtocol;
@protocol MainViewTripleStoreQueryDelegateProtocol;

@protocol TripleStoreQueryConnectionProtocol <NSObject>

@property(nonatomic, weak)
    id<MainViewTripleStoreQueryDelegateProtocol> mainViewDelegate;

- (void)startQueryWithStoreURL:(NSString *)storeURL
                   datasetName:(NSString *)dataset
                       rdfDump:(NSString *)rdfDump
                      gameData:(NSArray *)gameData;

@end

@class TripleStoreQueryWireFrame;

@protocol TripleStoreQueryViewProtocol
@required
@property(nonatomic, strong) id<TripleStoreQueryPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol TripleStoreQueryWireFrameProtocol
@required
+ (instancetype)presentTripleStoreQueryModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewTripleStoreQueryDelegateProtocol>)delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol TripleStoreQueryPresenterProtocol <TripleStoreQueryConnectionProtocol>
@required
@property(nonatomic, weak) id<TripleStoreQueryViewProtocol> view;
@property(nonatomic, strong)
    id<TripleStoreQueryInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<TripleStoreQueryWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol TripleStoreQueryInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */

- (void)didPutDumpIntoStore;
- (void)didFinishQueryForEveryGameWithCSV:(NSString *)csv;
- (void)errorOccurred:(NSError *)error;

/*
 * Param: progress in percent
 */
- (void)progressUpdated:(double)progress;

@end

@protocol TripleStoreQueryInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<TripleStoreQueryInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<TripleStoreQueryAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<TripleStoreQueryLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (void)queryForEveryGame:(NSArray *)gameData
                 storeURL:(NSString *)storeURL
              datasetName:(NSString *)dataset;

- (void)startQueryWithStoreURL:(NSString *)storeURL
                   datasetName:(NSString *)dataset
                       rdfDump:(NSString *)rdfDump;

@end

@protocol TripleStoreQueryDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol TripleStoreQueryAPIDataManagerInputProtocol <
    TripleStoreQueryDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */

- (void)putDumpIntoTripleStoreWithStoreURL:(NSString *)storeURL
                                   fileURL:(NSURL *)fileURL
                               datasetName:(NSString *)dataset
                                completion:(void (^)(NSError *error))completion;

- (void)queryWithStoreURL:(NSString *)storeURL
              datasetName:(NSString *)dataset
                  queries:(NSArray *)queries
            progressBlock:
                (void (^)(NSUInteger numberOfFinishedOperations,
                          NSUInteger totalNumberOfOperations))progressBlock
               completion:(void (^)(NSArray *results))completion;

@end

@protocol TripleStoreQueryLocalDataManagerInputProtocol <
    TripleStoreQueryDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
