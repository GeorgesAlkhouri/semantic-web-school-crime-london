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
@protocol ExtractGiantBombDataConnectionProtocol;

@protocol MainViewExtractGiantBombDataDelegateProtocol;

@protocol ExtractGiantBombDataConnectionProtocol <NSObject>
@property(nonatomic, weak)
    id<MainViewExtractGiantBombDataDelegateProtocol> mainViewDelegate;
- (void)extractDataWithAPIKey:(NSString *)APIKey userKey:(NSString *)userKey;
@end

@protocol ExtractGiantBombDataViewProtocol
@required
@property(nonatomic, strong)
    id<ExtractGiantBombDataPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@class ExtractGiantBombDataWireFrame;

@protocol ExtractGiantBombDataWireFrameProtocol
@required
@property(nonatomic, weak) id<ExtractGiantBombDataPresenterProtocol> presenter;

+ (instancetype)presentExtractGiantBombDataModuleFrom:
                    (id)fromView withDelegate:
                        (id<MainViewExtractGiantBombDataDelegateProtocol>)
                            delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol ExtractGiantBombDataPresenterProtocol <
    ExtractGiantBombDataConnectionProtocol>
@required
@property(nonatomic, weak) id<ExtractGiantBombDataViewProtocol> view;
@property(nonatomic, strong)
    id<ExtractGiantBombDataInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<ExtractGiantBombDataWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol ExtractGiantBombDataInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */

- (void)extractionFinishedWithResults:(NSArray *)results;
- (void)errorOccurred:(NSError *)error;

@end

@protocol ExtractGiantBombDataInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<ExtractGiantBombDataInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<ExtractGiantBombDataAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<ExtractGiantBombDataLocalDataManagerInputProtocol> localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (void)startDataExtractionWithAPIKey:(NSString *)APIKey
                              userKey:(NSString *)userKey;

@end

@protocol ExtractGiantBombDataDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol ExtractGiantBombDataAPIDataManagerInputProtocol <
    ExtractGiantBombDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */

- (void)extractPegiMetaDataWithAPIKey:(NSString *)APIKey
                              userKey:(NSString *)userKey
                           completion:
                               (void (^)(NSError *error, id result))completion;
- (void)extractPegiDataWithMaxPageCount:(NSNumber *)pageCount
                                 APIKey:(NSString *)APIKey
                                userKey:(NSString *)userKey
                             completion:(void (^)(NSError *error,
                                                  NSArray *results))completion;

@end

@protocol ExtractGiantBombDataLocalDataManagerInputProtocol <
    ExtractGiantBombDataDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
