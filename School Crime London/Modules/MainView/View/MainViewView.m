//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewView.h"

@interface MainViewView ()

@property(weak) IBOutlet NSTextField *storeAdress;
@property(weak) IBOutlet NSTextField *datasetName;

@property(weak) IBOutlet NSTextField *geofencingAPIKey;
@property(weak) IBOutlet NSTextField *infoLabel;

@property(weak) IBOutlet NSProgressIndicator *progressIndicator;

@property(weak) IBOutlet NSButton *saveButton;
@end

@implementation MainViewView

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)actionButtonPressed:(NSButton *)sender {

    [self.presenter setGeofencingAPIKey:[self.geofencingAPIKey stringValue]];
    [self.presenter setStoreURL:[self.storeAdress stringValue]];
    [self.presenter setDatasetName:[self.datasetName stringValue]];

    [self.presenter actionButtonPressed];
}

- (IBAction)saveButtonPressed:(NSButton *)sender {

    [self.presenter saveButtonPressed];
}

- (void)setInfoLabelText:(NSString *)text {

    self.infoLabel.stringValue = text;
}

- (void)setProgress:(double)progress {

    self.progressIndicator.doubleValue = progress;
}

- (void)enableSaveButton:(double)enable {

    self.saveButton.enabled = enable;
}

@end