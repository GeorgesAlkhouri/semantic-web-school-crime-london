//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewView.h"

@interface MainViewView ()

@property(weak) IBOutlet NSTextField *giantBombAPIKey;
@property(weak) IBOutlet NSTextField *geofencingAPIKey;
@property(weak) IBOutlet NSTextField *infoLabel;

@end

@implementation MainViewView

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)actionButtonPressed:(NSButton *)sender {

    [self.presenter setGiantBombAPIKey:[self.giantBombAPIKey stringValue]];
    [self.presenter setGeofencingAPIKey:[self.geofencingAPIKey stringValue]];

    [self.presenter actionButtonPressed];
}

- (void)setInfoLabelText:(NSString *)text {

    self.infoLabel.stringValue = text;
}

@end