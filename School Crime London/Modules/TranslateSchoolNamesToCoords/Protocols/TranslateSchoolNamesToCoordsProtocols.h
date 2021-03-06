//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol TranslateSchoolNamesToCoordsInteractorOutputProtocol;
@protocol TranslateSchoolNamesToCoordsInteractorInputProtocol;
@protocol TranslateSchoolNamesToCoordsViewProtocol;
@protocol TranslateSchoolNamesToCoordsPresenterProtocol;
@protocol TranslateSchoolNamesToCoordsLocalDataManagerInputProtocol;
@protocol TranslateSchoolNamesToCoordsAPIDataManagerInputProtocol;

@protocol MainViewTranslateSchoolNamesToCoordsDelegateProtocol;

@class TranslateSchoolNamesToCoordsWireFrame;

@protocol TranslateSchoolNamesToCoordsConnectionProtocol <NSObject>

@property(nonatomic, weak)
    id<MainViewTranslateSchoolNamesToCoordsDelegateProtocol> mainViewDelegate;

- (void)startTranslatingWithAPIKey:(NSString *)APIKey
                        schoolData:(NSArray *)schoolData;
@end

@protocol TranslateSchoolNamesToCoordsViewProtocol
@required
@property(nonatomic, strong)
    id<TranslateSchoolNamesToCoordsPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */
@end

@protocol TranslateSchoolNamesToCoordsWireFrameProtocol
@required
+ (instancetype)
presentExtractGameDataModuleFrom:
    (id)fromView withDelegate:
        (id<MainViewTranslateSchoolNamesToCoordsDelegateProtocol>)delegate;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol TranslateSchoolNamesToCoordsPresenterProtocol <
    TranslateSchoolNamesToCoordsConnectionProtocol>
@required
@property(nonatomic, weak) id<TranslateSchoolNamesToCoordsViewProtocol> view;
@property(nonatomic, strong)
    id<TranslateSchoolNamesToCoordsInteractorInputProtocol> interactor;
@property(nonatomic, strong)
    id<TranslateSchoolNamesToCoordsWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol TranslateSchoolNamesToCoordsInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */

- (void)translationDidFinishedWithResults:(NSArray *)results;
- (void)translationDidFinishedWithError:(NSError *)error;

/*
 * Param: progress in percent
 */
- (void)progressUpdated:(double)progress;

@end

@protocol TranslateSchoolNamesToCoordsInteractorInputProtocol
@required
@property(nonatomic, weak)
    id<TranslateSchoolNamesToCoordsInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<TranslateSchoolNamesToCoordsAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<TranslateSchoolNamesToCoordsLocalDataManagerInputProtocol>
        localDataManager;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */

- (void)startTranslatingWithAPIKey:(NSString *)APIKey
                        schoolData:(NSArray *)schoolNames;

@end

@protocol TranslateSchoolNamesToCoordsDataManagerInputProtocol
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol TranslateSchoolNamesToCoordsAPIDataManagerInputProtocol <
    TranslateSchoolNamesToCoordsDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
 */

- (void)
requestCoordsWithLocationNames:(NSArray *)requestData
                        APIKey:(NSString *)APIKey
                 progressBlock:
                     (void (^)(NSUInteger numberOfFinishedOperations,
                               NSUInteger totalNumberOfOperations))progressBlock
                    completion:
                        (void (^)(NSError *error, NSArray *results))completion;

@end

@protocol TranslateSchoolNamesToCoordsLocalDataManagerInputProtocol <
    TranslateSchoolNamesToCoordsDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
