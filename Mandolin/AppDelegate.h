//
//  AppDelegate.h
//  Mandolin
//
//  Created by Sean Niesen on 3/21/15.
//  Copyright (c) 2015 Sean Niesen. All rights reserved.
//

@class AEAudioController;
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) AEAudioController *audioController;


@end

