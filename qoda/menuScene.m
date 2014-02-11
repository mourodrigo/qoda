//
//  menuScene.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 11/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "menuScene.h"

@implementation menuScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
    }
    return self;
}
-(void)didMoveToView:(SKView *)view{

}
@end
