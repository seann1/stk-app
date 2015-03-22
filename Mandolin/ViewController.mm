//
//  ViewController.m
//  Mandolin
//
//  Created by Sean Niesen on 3/21/15.
//  Copyright (c) 2015 Sean Niesen. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import "Sitar.h"
#import "AEBlockChannel.h"

@implementation ViewController {
    AEBlockChannel *myMandolinChannel;
    stk::Sitar *myMandolin;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSError *errorAudioSetup = NULL;
    BOOL result = [[appDelegate audioController] start:&errorAudioSetup];
    if ( !result ) {
        NSLog(@"Error starting audio engine: %@", errorAudioSetup.localizedDescription);
    }
    
    stk::Stk::setRawwavePath([[[NSBundle mainBundle] pathForResource:@"rawwaves" ofType:@"bundle"] UTF8String]);
    
    myMandolin = new stk::Sitar(400);
    myMandolin->setFrequency(400);
    
    myMandolinChannel = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp  *time,
                                                           UInt32 frames,
                                                           AudioBufferList *audio) {
        for ( int i=0; i<frames; i++ ) {
            
            ((float*)audio->mBuffers[0].mData)[i] =
            ((float*)audio->mBuffers[1].mData)[i] = myMandolin->tick();
            
        }
    }];
    
    [[appDelegate audioController] addChannels:@[myMandolinChannel]];
}

- (IBAction)pluckMyMandolin {
    myMandolin->noteOn(400, 1);
}

- (IBAction)changeFrequency:(UISlider *)sender {
    myMandolin->setFrequency(sender.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
