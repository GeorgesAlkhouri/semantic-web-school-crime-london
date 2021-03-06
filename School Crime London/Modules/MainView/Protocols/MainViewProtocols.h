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
@protocol MainViewExtractGameDataDelegateProtocol;

@protocol ExtractGameDataConnectionProtocol;
@protocol TranslateSchoolNamesToCoordsConnectionProtocol;
@protocol ParseLondonDataStoreDataConnectionProtocol;
@protocol SearchCrimeSceneConnectionProtocol;
@protocol BuildRdfConnectionProtocol;
@protocol TripleStoreQueryConnectionProtocol;

@class MainViewWireFrame;

@protocol MainViewDelegateProtocol <NSObject>

- (void)showInformationText:(NSString *)text;
- (void)showError:(NSString *)errorText;

/*
 * Param: progress - progress in percent
 */
- (void)showProgress:(double)progress;

@end

@protocol MainViewTripleStoreQueryDelegateProtocol <MainViewDelegateProtocol>

@property(nonatomic, strong)
    id<TripleStoreQueryConnectionProtocol> tripleStoreQueryConnection;

- (void)didReceiveResultFromQuery:(NSString *)csvString;

@end

@protocol MainViewBuildRdfDelegateProtocol <MainViewDelegateProtocol>

@property(nonatomic, strong) id<BuildRdfConnectionProtocol> buildRdfConnection;

- (void)didBuildRDFDumpWithDump:(NSString *)rdfDump;

@end

@protocol MainViewSearchCrimeSceneDelegateProtocol <MainViewDelegateProtocol>

@property(nonatomic, strong)
    id<SearchCrimeSceneConnectionProtocol> searchCrimeSceneConnection;

- (void)requestCrimeSceneFinishedWithResults:(NSArray *)results;

@end

@protocol MainViewExtractGameDataDelegateProtocol <MainViewDelegateProtocol>

@property(nonatomic, strong)
    id<ExtractGameDataConnectionProtocol> extractGameDataConnection;

- (void)extractionDidFinishWithResults:(NSArray *)results;

@end

@protocol MainViewTranslateSchoolNamesToCoordsDelegateProtocol <
    MainViewDelegateProtocol>

@property(nonatomic, strong) id<TranslateSchoolNamesToCoordsConnectionProtocol>
    translateSchoolNamesToCoordsConnection;

- (void)translationDidFinishWithResults:(NSArray *)results;

@end

@protocol
    MainViewParseLondonDataStoreDataDelegateProtocol <MainViewDelegateProtocol>
@property(nonatomic, strong) id<ParseLondonDataStoreDataConnectionProtocol>
    parseLondonDataStoreDataConnection;

@end

@protocol MainViewViewProtocol
@required
@property(nonatomic, strong) id<MainViewPresenterProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> VIEWCONTROLLER
 */

- (void)setInfoLabelText:(NSString *)text;
- (void)setProgress:(double)progress;

- (void)enableSaveButton:(double)enable;

@end

@protocol MainViewWireFrameProtocol
@required
+ (instancetype)presentMainViewModuleFrom:(id)fromView;
/**
 * Add here your methods for communication PRESENTER -> WIREFRAME
 */
@end

@protocol MainViewPresenterProtocol <
    MainViewExtractGameDataDelegateProtocol,
    MainViewTranslateSchoolNamesToCoordsDelegateProtocol,
    MainViewParseLondonDataStoreDataDelegateProtocol,
    MainViewSearchCrimeSceneDelegateProtocol, MainViewBuildRdfDelegateProtocol,
    MainViewTripleStoreQueryDelegateProtocol>

@required
@property(nonatomic, weak) id<MainViewViewProtocol> view;
@property(nonatomic, strong) id<MainViewInteractorInputProtocol> interactor;
@property(nonatomic, strong) id<MainViewWireFrameProtocol> wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */

- (void)actionButtonPressed;
- (void)saveButtonPressed;
- (void)setGeofencingAPIKey:(NSString *)APIKey;
- (void)setStoreURL:(NSString *)storeURL;
- (void)setDatasetName:(NSString *)datasetName;

@end

@protocol MainViewInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol MainViewInteractorInputProtocol
@required
@property(nonatomic, weak) id<MainViewInteractorOutputProtocol> presenter;
@property(nonatomic, strong)
    id<MainViewAPIDataManagerInputProtocol> APIDataManager;
@property(nonatomic, strong)
    id<MainViewLocalDataManagerInputProtocol> localDataManager;
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

@protocol
    MainViewLocalDataManagerInputProtocol <MainViewDataManagerInputProtocol>
/**
 * Add here your methods for communication INTERACTOR -> LOCLDATAMANAGER
 */
@end
