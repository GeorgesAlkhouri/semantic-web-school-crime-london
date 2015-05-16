//
//  AppDelegate.m
//  School Crime London
//
//  Created by Georges Alkhouri on 15/05/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "AppDelegate.h"

#import "ExtractGiantBombDataWireFrame.h"

@interface AppDelegate ()

@property(nonatomic) NSWindowController *windowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSStoryboard *storyboard =
        [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.windowController = [storyboard
        instantiateControllerWithIdentifier:@"MainWindowController"];

    [ExtractGiantBombDataWireFrame
        presentExtractGiantBombDataModuleFrom:self.windowController];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
