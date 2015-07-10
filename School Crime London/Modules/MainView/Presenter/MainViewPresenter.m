//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *geofencingAPIKey;
@property(nonatomic) NSString *storeURL;
@property(nonatomic) NSString *datasetName;

@property(nonatomic) NSString *csv;

@property(nonatomic) NSArray *schoolData;
@property(nonatomic) NSArray *gameData;
@property(nonatomic) NSArray *crimeData;

@end

@implementation MainViewPresenter

#pragma mark - MainViewDelegateProtocol

- (void)showInformationText:(NSString *)text {

    [self.view setInfoLabelText:text];
}

- (void)showError:(NSString *)errorText {

    [self.view setInfoLabelText:errorText];
}

- (void)showProgress:(double)progress {

    [self.view setProgress:progress * 100];
}

#pragma mark - MainViewPresenterProtocol

- (void)setGeofencingAPIKey:(NSString *)APIKey {

    _geofencingAPIKey = APIKey;
}

- (void)actionButtonPressed {

    [self showProgress:0.0];
    self.csv = nil;
    [self.view enableSaveButton:NO];

    NSArray *schoolData =
        [self.parseLondonDataStoreDataConnection parseLondonDataStoreData:nil];

    [self.translateSchoolNamesToCoordsConnection
        startTranslatingWithAPIKey:self.geofencingAPIKey
                        schoolData:schoolData];
}

- (void)saveButtonPressed {

    if (self.csv) {

        NSSavePanel *panel = [NSSavePanel savePanel];
        panel.nameFieldStringValue = @"Results.csv";

        [panel beginWithCompletionHandler:^(NSInteger result) {

            if (result == NSFileHandlingPanelOKButton) {

                [self.csv writeToURL:[panel URL]
                          atomically:YES
                            encoding:NSUTF8StringEncoding
                               error:nil];
            }
        }];
    }
}

- (void)setStoreURL:(NSString *)storeURL {

    _storeURL = storeURL;
}

- (void)setDatasetName:(NSString *)datasetName {

    _datasetName = datasetName;
}

#pragma mark - Delegate Protocols

- (void)extractionDidFinishWithResults:(NSArray *)results {

    [self showProgress:0.0];

    self.gameData = results;

    [self.searchCrimeSceneConnection requestPoliceDataForGames:self.gameData
                                                    schoolData:self.schoolData];
}

- (void)translationDidFinishWithResults:(NSArray *)results {

    [self showProgress:0.0];

    self.schoolData = results;

    [self.extractGameDataConnection extractGameData];
}

- (void)requestCrimeSceneFinishedWithResults:(NSArray *)results {

    [self showProgress:0.0];

    self.crimeData = results;

    [self.buildRdfConnection buildRdfWithSchoolData:self.schoolData
                                           gameData:self.gameData
                                          crimeData:self.crimeData];
}

- (void)didBuildRDFDumpWithDump:(NSString *)rdfDump {

    [self.tripleStoreQueryConnection startQueryWithStoreURL:self.storeURL
                                                datasetName:self.datasetName
                                                    rdfDump:rdfDump
                                                   gameData:self.gameData];
}

- (void)didReceiveResultFromQuery:(NSString *)csvString {

    [self showInformationText:@"Finished. Save CSV"];

    self.csv = csvString;

    [self.view enableSaveButton:YES];
}

@end
