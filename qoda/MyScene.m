//
//  MyScene.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MyScene.h"
#import "SKButton.h"

#define btns 4
@implementation MyScene{
    NSMutableArray *arrBtnsP1;
    NSMutableArray *arrBtnsP2;
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        /*
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
 */
 }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:location];
    NSLog(@"nodes %@", nodes);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didMoveToView:(SKView *)view{
    /* Called right after the view shows the scene */
    
    arrBtnsP1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int h=1; h<=btns; h++) {
        /*
        SKSpriteNode *btnp = [SKSpriteNode spriteNodeWithImageNamed:@"buttonRed.png"];
        [self addChild:btnp];
        btnp.position = [self getPointFromScaleX:((100/btns/2)*h)+5 y:98];
        btnp.size = CGSizeMake(self.view.frame.size.width/15, self.view.frame.size.width/15);
        [arrBtnsP1 addObject:btnp];
    */
        SKButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"buttonRed.png" selected:@"buttonPressed.png"];
        [backButton setPosition:[self getPointFromScaleX:((100/btns/2)*h)+5 y:98]];
        [backButton.title setText:@"Button"];
        [backButton.title setFontName:@"Chalkduster"];
        [backButton.title setFontSize:20.0];
        [backButton setTouchUpInsideTarget:self action:@selector(actionBtn)];
        [self addChild:backButton];
         }
    
    for (int h=1; h<=btns; h++) {
        SKSpriteNode *btnp = [SKSpriteNode spriteNodeWithImageNamed:@"buttonGreen.png"];
        
        [self addChild:btnp];
        btnp.position = [self getPointFromScaleX:((100/btns/2)*h)+5 y:35];
        btnp.size = CGSizeMake(self.view.frame.size.width/15, self.view.frame.size.width/15);
        [arrBtnsP2 addObject:btnp];
        
    }
    
}

-(IBAction)actionBtn{
    NSLog(@"ACTION!");
}

-(CGPoint)getPointFromScaleX:(float)x y:(float)y{
    NSLog(@"return view %f %f ", (self.view.frame.size.height/100)*x, (self.view.frame.size.width/100)*y);
    
    return CGPointMake((self.view.frame.size.height/100)*x, (self.view.frame.size.width/100)*y);
}


@end
