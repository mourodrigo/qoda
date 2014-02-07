//
//  MyScene.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MyScene.h"

#define analogSize 130

#define p1ControlLeftX 10
#define p1ControlLeftY 10
#define p1ControlRightX 90
#define p1ControlRightY 10

#define p2ControlLeftX 10
#define p2ControlLeftY 90
#define p2ControlRightX 90
#define p2ControlRightY 90


@implementation MyScene{
    SKSpriteNode *analogp1Left;
    SKSpriteNode *analogp2Left;
    SKSpriteNode *analogp1Right;
    SKSpriteNode *analogp2Right;
    SKSpriteNode *analogp1LeftCenter;
    SKSpriteNode *analogp2LeftCenter;
    SKSpriteNode *analogp1RightCenter;
    SKSpriteNode *analogp2RightCenter;
    
    BOOL analogp1LeftCenterSelected;
    BOOL analogp2LeftCenterSelected;
    BOOL analogp1RightCenterSelected;
    BOOL analogp2RightCenterSelected;
    

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

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:location];
       // NSLog(@"nodes %@", nodes);
        if (nodes.count>0) {
            NSUInteger index;
            
            //===CONTROLE DOS BOTÕES

            //p1Left
            index = [nodes indexOfObject:analogp1Left];
            if (index!=NSNotFound) {
                SKSpriteNode *node = [nodes objectAtIndex:index];
                
                index = [nodes indexOfObject:analogp1LeftCenter];
                
            
                if (index!=NSNotFound) {
                    SKSpriteNode *nodeCenter = [nodes objectAtIndex:index];

                    float distance = [self getDistanceBetween:nodeCenter.position and:node.position];
                    if (distance<node.size.width*0.7) {
                        nodeCenter.position = location;
                        analogp1LeftCenterSelected = TRUE;
                        
                    }
                }
            }
            
            //p2Left
            index = [nodes indexOfObject:analogp2Left];
            if (index!=NSNotFound) {
                SKSpriteNode *node = [nodes objectAtIndex:index];
                
                index = [nodes indexOfObject:analogp2LeftCenter];
                
                
                if (index!=NSNotFound) {
                    SKSpriteNode *nodeCenter = [nodes objectAtIndex:index];
                    
                    float distance = [self getDistanceBetween:nodeCenter.position and:node.position];
                    if (distance<node.size.width*0.7) {
                        nodeCenter.position = location;
                        analogp2LeftCenterSelected = TRUE;

                    }
                }
            }
            
            //p1Right
            index = [nodes indexOfObject:analogp1Right];
            if (index!=NSNotFound) {
                SKSpriteNode *node = [nodes objectAtIndex:index];
                
                index = [nodes indexOfObject:analogp1RightCenter];
                
                
                if (index!=NSNotFound) {
                    SKSpriteNode *nodeCenter = [nodes objectAtIndex:index];
                    
                    float distance = [self getDistanceBetween:nodeCenter.position and:node.position];
                    if (distance<node.size.width*0.7) {
                        nodeCenter.position = location;
                        analogp1RightCenterSelected = TRUE;

                    }
                }
            }
            
            //p2Right
            index = [nodes indexOfObject:analogp2Right];
            if (index!=NSNotFound) {
                SKSpriteNode *node = [nodes objectAtIndex:index];
                
                index = [nodes indexOfObject:analogp2RightCenter];
                
                
                if (index!=NSNotFound) {
                    SKSpriteNode *nodeCenter = [nodes objectAtIndex:index];
                    
                    float distance = [self getDistanceBetween:nodeCenter.position and:node.position];
                    if (distance<node.size.width*0.7) {
                        nodeCenter.position = location;
                        analogp2RightCenterSelected = TRUE;

                    }
                }
            }
            
            
            
            
        }
    }
    
        [self controlAnalogs];
    
    
}

-(void)controlAnalogs{
    if (!analogp1LeftCenterSelected) {
        SKAction *move = [SKAction moveTo:[self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY] duration:0.1f];
        [analogp1LeftCenter runAction:move];
    }
    
    if (!analogp1RightCenterSelected) {
        SKAction *move = [SKAction moveTo:[self getPointFromScaleX:p1ControlRightX y:p1ControlRightY] duration:0.1f];
        [analogp1RightCenter runAction:move];
    }
    
    if (!analogp2LeftCenterSelected) {
        SKAction *move = [SKAction moveTo:[self getPointFromScaleX:p2ControlLeftX y:p2ControlLeftY] duration:0.1f];
        [analogp2LeftCenter runAction:move];
    }
    
    if (!analogp2RightCenterSelected) {
        SKAction *move = [SKAction moveTo:[self getPointFromScaleX:p2ControlRightX y:p2ControlRightY] duration:0.1f];
        [analogp2RightCenter runAction:move];
    }
    
    
  analogp1LeftCenterSelected = FALSE;
  analogp2LeftCenterSelected = FALSE;
  analogp1RightCenterSelected = FALSE;
  analogp2RightCenterSelected = FALSE;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:location];
        // NSLog(@"nodes %@", nodes);
      //  [self controlAnalogs];
    }

}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:location];
        // NSLog(@"nodes %@", nodes);
        if (nodes.count>0) {
            if ([nodes indexOfObject:analogp1LeftCenter]!=NSNotFound) {
                SKAction *move = [SKAction moveTo:[self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY] duration:0.1f];
                [analogp1LeftCenter runAction:move];
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    /*
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:location];
    NSLog(@"nodes %@", nodes);
    */
    /*
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }*/
    
    /*
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:location];
    
    if ([nodes count] == 0){
        SKNode *ladybug = [self childNodeWithName:@"ladybug"];
        SKAction *move = [SKAction moveTo:location duration:1.0f];
        [ladybug runAction:move];
        
        double angle = atan2(location.y-ladybug.position.y,location.x-ladybug.position.x);
        [ladybug runAction:[SKAction rotateToAngle:angle duration:.1]];
    } else {
        // tapped on a bug
     //   [self runAction:[SKAction playSoundFileNamed:@"ladybug.wav" waitForCompletion:NO]];
        NSLog(@"ACTION!")
    }
    */
    
    
    /*
    
    
    
    
*/
}

-(void)update:(CFTimeInterval)currentTime {
    if (analogp1LeftCenterSelected||analogp2RightCenterSelected||analogp1LeftCenterSelected||analogp2RightCenterSelected) {
        [self controlAnalogs];
    }
    /* Called before each frame is rendered */
}

-(void)didMoveToView:(SKView *)view{
    /* Called right after the view shows the scene */
    SKTexture *backGround = [SKTexture textureWithImageNamed:@"floor"];
    
    SKSpriteNode* backGroundNode = [SKSpriteNode spriteNodeWithTexture:backGround];
    backGroundNode.position = self.view.center;
    backGroundNode.size = self.view.frame.size;
    backGroundNode.name = @"backGroundNode";
    [self addChild:backGroundNode];
    
    
    SKTexture *texture_center_circle = [SKTexture textureWithImageNamed:@"center_circle"];
    SKTexture *texture_out_circle = [SKTexture textureWithImageNamed:@"out_circle"];
    
    analogp1Left = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp1Left.position = [self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY];
    analogp1Left.size = CGSizeMake(analogSize, analogSize);
    analogp1Left.name = @"analogp1Left";
    [self addChild:analogp1Left];

    analogp1Right = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp1Right.position = [self getPointFromScaleX:p1ControlRightX y:p1ControlRightY];
    analogp1Right.size = CGSizeMake(analogSize, analogSize);
    analogp1Right.name = @"analogp1Right";
    [self addChild:analogp1Right];
    
    analogp2Left = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp2Left.position = [self getPointFromScaleX:p2ControlLeftX y:p2ControlLeftY];
    analogp2Left.size = CGSizeMake(analogSize, analogSize);
    analogp2Left.name = @"analogp2Left";
    [self addChild:analogp2Left];
    
    analogp2Right = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp2Right.position = [self getPointFromScaleX:p2ControlRightX y:p2ControlRightY];
    analogp2Right.size = CGSizeMake(analogSize, analogSize);
    analogp2Right.name = @"analogp2Right";
    [self addChild:analogp2Right];
    
    
    analogp1LeftCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp1LeftCenter.position = [self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY];
    analogp1LeftCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp1LeftCenter.name = @"analogp1Left";
    [self addChild:analogp1LeftCenter];
    
    analogp1RightCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp1RightCenter.position = [self getPointFromScaleX:p1ControlRightX y:p1ControlRightY];
    analogp1RightCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp1RightCenter.name = @"analogp1Right";
    [self addChild:analogp1RightCenter];
    
    analogp2LeftCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp2LeftCenter.position = [self getPointFromScaleX:p2ControlLeftX y:p2ControlLeftY];
    analogp2LeftCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp2LeftCenter.name = @"analogp2Left";
    [self addChild:analogp2LeftCenter];
    
    analogp2RightCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp2RightCenter.position = [self getPointFromScaleX:p2ControlRightX y:p2ControlRightY];
    analogp2RightCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp2RightCenter.name = @"analogp2Right";
    [self addChild:analogp2RightCenter];
    
    
    
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
    return CGPointMake((self.view.frame.size.width/100)*x, (self.view.frame.size.height/100)*y);
}

- (float)getDistanceBetween:(CGPoint)p1 and:(CGPoint)p2 {
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

@end
