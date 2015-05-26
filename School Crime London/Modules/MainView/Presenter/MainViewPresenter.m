//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *giantBombAPIKey;
@property(nonatomic) NSString *geofencingAPIKey;

@property(nonatomic) NSArray *schoolData;
@property(nonatomic) NSArray *gameData;

@end

@implementation MainViewPresenter

- (void)showInformationText:(NSString *)text {

    [self.view setInfoLabelText:text];
}

- (void)showError:(NSString *)errorText {

    [self.view setInfoLabelText:errorText];
}

- (void)setGiantBombAPIKey:(NSString *)APIKey {

    _giantBombAPIKey = APIKey;
}

- (void)setGeofencingAPIKey:(NSString *)APIKey {

    _geofencingAPIKey = APIKey;
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

    [self.extractGiantBombDataConnection
        extractDataWithAPIKey:self.giantBombAPIKey];
}

@end