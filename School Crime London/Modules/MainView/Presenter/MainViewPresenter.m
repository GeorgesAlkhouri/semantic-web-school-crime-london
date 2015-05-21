//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *giantBombAPIKey;
@property(nonatomic) NSString *geofencingAPIKey;

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

    [self.extractGiantBombDataConnection
        extractDataWithAPIKey:self.giantBombAPIKey];
}

- (void)extractionDidFinishWithResults:(NSArray *)results {

    NSArray *schoolNames = [self.parseLondonDataStoreDataConnectionProtocol
        parseLondonDataStoreData:nil];

    [self.translateSchoolNamesToCoordsConnection
        startTranslatingWithAPIKey:self.geofencingAPIKey
                       schoolNames:@[ @"Tower Hamlets+Bethnal Green North" ]];
}

@end