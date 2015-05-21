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

- (void)setGiantBombAPIKey:(NSString *)APIKey {
    
    _giantBombAPIKey = APIKey;
}

- (void)setGeofencingAPIKey:(NSString *)APIKey {
    
    _geofencingAPIKey = APIKey;
}

- (void)actionButtonPressed {
    
}

@end