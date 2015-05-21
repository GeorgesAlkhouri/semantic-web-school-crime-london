//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol ParseLondonDataStoreDataInteractorOutputProtocol;
@protocol ParseLondonDataStoreDataInteractorInputProtocol;
@protocol ParseLondonDataStoreDataViewProtocol;
@protocol ParseLondonDataStoreDataPresenterProtocol;
@protocol ParseLondonDataStoreDataLocalDataManagerInputProtocol;
@protocol ParseLondonDataStoreDataAPIDataManagerInputProtocol;

@protocol MainViewParseLondonDataStoreDataDelegateProtocol;

@protocol ParseLondonDataStoreDataConnectionProtocol <NSObject>
@property(nonatomic, weak)
    id<MainViewParseLondonDataStoreDataDelegateProtocol> mainViewDelegate;

- (NSArray *)parseLondonDataStoreData:(NSError **)error;

@end

@class ParseLondonDataStoreDataWireFrame;

@protocol ParseLondonDataStoreDataViewProtocol
@required
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol ParseLondonDataStoreDataWireFrameProtocol
@required
+ (instancetype)presentParseLondonDataStoreDataModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewParseLondonDataStoreDataDelegateProtocol>)
                            delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol ParseLondonDataStoreDataPresenterProtocol <
    ParseLondonDataStoreDataConnectionProtocol>
@required
@property(nonatomic, weak) id<ParseLondonDataStoreDataViewProtocol> view;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol ParseLondonDataStoreDataInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol ParseLondonDataStoreDataInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<ParseLondonDataStoreDataInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<ParseLondonDataStoreDataLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (NSArray *)parseData;

@end

@protocol ParseLondonDataStoreDataDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol ParseLondonDataStoreDataAPIDataManagerInputProtocol <
    ParseLondonDataStoreDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */
@end

@protocol ParseLondonDataStoreDataLocalDataManagerInputProtocol <
    ParseLondonDataStoreDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */

- (NSArray *)parseCSVWithFileURL:(NSURL *)path;

@end
