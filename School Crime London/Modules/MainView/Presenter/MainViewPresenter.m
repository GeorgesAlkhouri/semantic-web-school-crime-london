//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *importIOAPIKey;
@property(nonatomic) NSString *importIOUserKey;

@property(nonatomic) NSString *geofencingAPIKey;

@property(nonatomic) NSArray *schoolData;
@property(nonatomic) NSArray *gameData;
@property(nonatomic) NSArray *crimeData;

@end

@implementation MainViewPresenter

- (void)showInformationText:(NSString *)text {

    [self.view setInfoLabelText:text];
}

- (void)showError:(NSString *)errorText {

    [self.view setInfoLabelText:errorText];
}

- (void)setImportIOAPIKey:(NSString *)APIKey {

    _importIOAPIKey = APIKey;
}

- (void)setGeofencingAPIKey:(NSString *)APIKey {

    _geofencingAPIKey = APIKey;
}

- (void)setImportIOUserKey:(NSString *)UserKey {

    _importIOUserKey = UserKey;
}

- (void)actionButtonPressed {

    NSArray *schoolData =
        [self.parseLondonDataStoreDataConnection parseLondonDataStoreData:nil];

    [self.translateSchoolNamesToCoordsConnection
        startTranslatingWithAPIKey:self.geofencingAPIKey
                        schoolData:schoolData];
}

- (void)extractionDidFinishWithResults:(NSArray *)results {

    self.gameData = results;

    [self.searchCrimeSceneConnection requestPoliceDataForGames:self.gameData
                                                    schoolData:self.schoolData];
}

- (void)translationDidFinishWithResults:(NSArray *)results {

    self.schoolData = results;

    [self.extractGameDataConnection extractDataWithAPIKey:self.importIOAPIKey
                                                  userKey:self.importIOUserKey];
}

- (void)requestCrimeSceneFinishedWithResults:(NSArray *)results {

    self.crimeData = results;

    [self.buildRdfConnection buildRdfWithSchoolData:self.schoolData
                                           gameData:self.gameData
                                          crimeData:self.crimeData];
}

- (void)didBuildRDFDumpWithDump:(NSString *)rdfDump {
}

@end
