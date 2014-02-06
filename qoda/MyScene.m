//
//  MyScene.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MyScene.h"

#define btns 4
#define btnSizeScale 10
@implementation MyScene{
    NSMutableArray *arrBtnsP1;
    NSMutableArray *arrBtnsP2;
    
}
@synthesize btn1P1, btn1P2, btn2P1, btn2P2, btn3P1, btn3P2, btn4P1, btn4P2;

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

    for (int p = 1; p<=2; p++) {
        int posy;
        if (p==1) {
            posy = 20;
        }else{
            posy = 80;
        }
        
        for (int b=1; b<=btns; b++) {
            SKButton *tempButton = [[SKButton alloc] initWithImageNamedNormal:@"buttonRed.png" selected:@"buttonPressed.png"];
            [tempButton setSize:CGSizeMake(self.view.frame.size.width/btnSizeScale, self.view.frame.size.width/btnSizeScale)];
            [tempButton setPosition:[self getPointFromScaleX:((100/btns/1.2)*b) y:posy]];
            
            switch (b) {
                case 1:
                    if (p==1) {
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn1P1)];
                        btn1P1 = tempButton;
                    }else{
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn1P2)];
                        btn1P2 = tempButton;
                    }
                    
                    break;
                case 2:
                    if (p==1) {
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn2P1)];
                        btn2P1 = tempButton;
                    }else{
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn2P2)];
                        btn2P2 = tempButton;
                    }
                    
                    break;
                case 3:
                    if (p==1) {
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn3P1)];
                        btn3P1 = tempButton;
                    }else{
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn3P2)];
                        btn3P2 = tempButton;
                    }
                    
                    break;
                case 4:
                    if (p==1) {
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn4P1)];
                        btn4P1 = tempButton;
                    }else{
                        [tempButton setTouchUpInsideTarget:self action:@selector(actionBtn4P2)];
                        btn4P2 = tempButton;
                    }
                    
                    break;
            }

            
        }
    }
    
    [self addChild:btn1P1];
    [self addChild:btn2P1];
    [self addChild:btn3P1];
    [self addChild:btn4P1];
    [self addChild:btn1P2];
    [self addChild:btn2P2];
    [self addChild:btn3P2];
    [self addChild:btn4P2];
    
}

-(IBAction)actionBtn1P1{
    NSLog(@"actionBtn1P1!");
}

-(IBAction)actionBtn2P1{
    NSLog(@"actionBtn2P1!");
}

-(IBAction)actionBtn3P1{
    NSLog(@"actionBtn3P1!");
}

-(IBAction)actionBtn4P1{
    NSLog(@"actionBtn4P1!");
}

-(IBAction)actionBtn1P2{
    NSLog(@"actionBtn1P2!");
}

-(IBAction)actionBtn2P2{
    NSLog(@"actionBtn2P2!");
}

-(IBAction)actionBtn3P2{
    NSLog(@"actionBtn3P2!");
}

-(IBAction)actionBtn4P2{
    NSLog(@"actionBtn4P2!");
}


-(CGPoint)getPointFromScaleX:(float)x y:(float)y{
    NSLog(@"return view %f %f ", (self.view.frame.size.height/100)*x, (self.view.frame.size.width/100)*y);
    
    return CGPointMake((self.view.frame.size.height/100)*x, (self.view.frame.size.width/100)*y);
}


@end
