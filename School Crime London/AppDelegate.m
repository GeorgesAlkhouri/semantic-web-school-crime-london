//
//  AppDelegate.m
//  School Crime London
//
//  Created by Georges Alkhouri on 15/05/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewWireFrame.h"

@interface AppDelegate ()

@property(nonatomic) NSWindowController *windowController;
@property(nonatomic) MainViewWireFrame *mainViewWireFrame;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSStoryboard *storyboard =
        [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.windowController = [storyboard
        instantiateControllerWithIdentifier:@"MainWindowController"];

    self.mainViewWireFrame =
        [MainViewWireFrame presentMainViewModuleFrom:self.windowController];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
