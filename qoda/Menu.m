//
//  Menu.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 11/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "Menu.h"
@implementation Menu
@synthesize audioPlayer;
-(void)viewDidLoad{
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%d",    [self playSoundFXnamed:@"RetroFutureDirty.mp3" Loop: NO]
          );

}
- (IBAction)play:(id)sender {
    [audioPlayer stop];
}


-(BOOL) playSoundFXnamed: (NSString*) vSFXName Loop: (BOOL) vLoop
{
    NSError *error;
    
    NSBundle* bundle = [NSBundle mainBundle];
    
    NSString* bundleDirectory = (NSString*)[bundle bundlePath];
    
    NSURL *url = [NSURL fileURLWithPath:[bundleDirectory stringByAppendingPathComponent:vSFXName]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.volume = 10;
    if(vLoop)
        audioPlayer.numberOfLoops = -1;
    else
        audioPlayer.numberOfLoops = 0;
    
    BOOL success = YES;
    
    if (audioPlayer == nil)
    {
        success = NO;
    }
    else
    {
        success = [audioPlayer play];
    }
    return success;
}
@end
