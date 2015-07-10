//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewView.h"

@interface MainViewView ()

@property(weak) IBOutlet NSTextField *importAPIKey;
@property(weak) IBOutlet NSTextField *importUserKey;
@property(weak) IBOutlet NSTextField *geofencingAPIKey;
@property(weak) IBOutlet NSTextField *infoLabel;

@property(weak) IBOutlet NSProgressIndicator *progressIndicator;

@end

@implementation MainViewView

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)actionButtonPressed:(NSButton *)sender {

    [self.presenter setImportIOAPIKey:[self.importAPIKey stringValue]];
    [self.presenter setImportIOUserKey:[self.importUserKey stringValue]];
    [self.presenter setGeofencingAPIKey:[self.geofencingAPIKey stringValue]];

    [self.presenter actionButtonPressed];
}

- (void)setInfoLabelText:(NSString *)text {

    self.infoLabel.stringValue = text;
}

- (void)setProgress:(double)progress {

    self.progressIndicator.doubleValue = progress;
}

@end