//
//  MyScene.m
//  qoda
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MyScene.h"

#define analogSize 130
#define mechSizeWidth 100
#define mechSizeHeight 80
#define mechStep 7
#define mechStepTime .1


#define p1ControlLeftX 10
#define p1ControlLeftY 10
#define p1ControlRightX 90
#define p1ControlRightY 10

#define p2ControlLeftX 10
#define p2ControlLeftY 90
#define p2ControlRightX 90
#define p2ControlRightY 90

#define ControlDeadZone 20
#define ControlAlpha 1
#define ControlCenterAlpha 1

#define wallPositionX 3
#define wallPositionY 4
#define wallWidth 15
#define wallHeight 10

#define wallAlpha 0


static const uint32_t borderCategory     =  0x1 << 0;
static const uint32_t mechCategory        =  0x1 << 1;
//static const uint32_t borderCategory        =  0x1 << 2;


@implementation MyScene{
    SKSpriteNode *analogp1Left;
    SKSpriteNode *analogp2Left;
    SKSpriteNode *analogp1Right;
    SKSpriteNode *analogp2Right;
    SKSpriteNode *analogp1LeftCenter;
    SKSpriteNode *analogp2LeftCenter;
    SKSpriteNode *analogp1RightCenter;
    SKSpriteNode *analogp2RightCenter;
    
    SKSpriteNode *mech1;
    SKSpriteNode *mech2;
    
    BOOL analogp1LeftCenterSelected;
    BOOL analogp2LeftCenterSelected;
    BOOL analogp1RightCenterSelected;
    BOOL analogp2RightCenterSelected;
    
    SKSpriteNode *wallLeft;
    SKSpriteNode *wallRight;
    SKSpriteNode *wallUp;
    SKSpriteNode *wallDown;

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
    
    //    [self controlAnalogs];
    
    
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

-(void)controlMechShoot:(SKNode*)Mech withControl:(SKNode*)Control andCenter:(SKNode*)ControlCenter{
    
    CGPoint point = Mech.position;
    bool movement = false;
    if ((ControlCenter.position.y - Control.position.y)>ControlDeadZone) {
        point.y = Mech.position.y+mechStep;
        movement = true;
    }else if ((ControlCenter.position.y - Control.position.y)<-ControlDeadZone) {
        point.y = Mech.position.y-mechStep;
        movement = true;
        
    }
    
    if ((ControlCenter.position.x - Control.position.x)>ControlDeadZone) {
        point.x = Mech.position.x-mechStep;
        movement = true;
        
    }else if ((ControlCenter.position.x - Control.position.x)<-ControlDeadZone) {
        point.x = Mech.position.x+mechStep;
        movement = true;
        
    }
    
    if (movement) {
        double angle = atan2(point.x-Mech.position.x,point.y-Mech.position.y);
      //  NSLog(@"ANGLE %f", angle);
        
        [Mech runAction:[SKAction rotateToAngle:angle duration:mechStepTime]];
    }
    

}

-(void)controlMech:(SKNode*)Mech withControl:(SKNode*)Control andCenter:(SKNode*)ControlCenter{
    
    //NSLog(@"distance y %f", ControlCenter.position.y - Control.position.y);
    //NSLog(@"distance x %f", ControlCenter.position.x - Control.position.x);
    CGPoint point = Mech.position;
    bool movement = false;
    [Mech removeActionForKey:[NSString stringWithFormat:@"moveMech%@", Mech.name]];

    if ((ControlCenter.position.y - Control.position.y)>ControlDeadZone) {
        point.y = Mech.position.y+mechStep;
        movement = true;
    }else if ((ControlCenter.position.y - Control.position.y)<-ControlDeadZone) {
        point.y = Mech.position.y-mechStep;
        movement = true;

    }
    
    if ((ControlCenter.position.x - Control.position.x)>ControlDeadZone) {
        point.x = Mech.position.x+mechStep;
        movement = true;

    }else if ((ControlCenter.position.x - Control.position.x)<-ControlDeadZone) {
        point.x = Mech.position.x-mechStep;
        movement = true;

    }
    
    if (movement) {
        SKAction *move = [SKAction moveTo:point duration:mechStepTime];
        [Mech runAction:move withKey:[NSString stringWithFormat:@"moveMech%@", Mech.name]];
    }
    
//    double angle = atan2(point.y-Mech.position.y,point.x-Mech.position.x);
  //  [Mech runAction:[SKAction rotateToAngle:angle duration:mechStepTime]];

    
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
    
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:location];
    //NSLog(@"nodes %@", nodes);
    
    
    if ([nodes count] != 0){
        // 1 - Choose one of the touches to work with
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        // 2 - Set up initial location of projectile
        SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"center_circle"];
        projectile.position = mech1.position;
        
        // 3- Determine offset of location to projectile
        CGPoint offset = rwSub(location, projectile.position);
        
        // 4 - Bail out if you are shooting down or backwards
        if (offset.x <= 0) return;
        
        // 5 - OK to add now - we've double checked position
        [self addChild:projectile];
        NSLog(@"projectile");
        // 6 - Get the direction of where to shoot
        CGPoint direction = rwNormalize(offset);
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        CGPoint shootAmount = rwMult(direction, 1000);
        
        // 8 - Add the shoot amount to the current position
        CGPoint realDest = rwAdd(shootAmount, projectile.position);
        
        // 9 - Create the actions
        float velocity = 480.0/1.0;
        float realMoveDuration = self.size.width / velocity;
        SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
        SKAction * actionMoveDone = [SKAction removeFromParent];
        [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
        
        
    }
    
    
    /*
    
    
    
    
*/
    
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    [self controlMech:mech1 withControl:analogp1Left andCenter:analogp1LeftCenter];
    [mech1 runAction:[mech1  actionForKey:[NSString stringWithFormat:@"moveMech%@", mech1.name]]];
    NSLog(@"RunAction");
    [self controlMechShoot:mech1 withControl:analogp1Right andCenter:analogp1RightCenter];

    
    if (analogp1LeftCenterSelected||analogp2RightCenterSelected||analogp1LeftCenterSelected||analogp2RightCenterSelected) {
   //     [self controlAnalogs];
    }
    
    /* Called before each frame is rendered */
}

-(void)didMoveToView:(SKView *)view{
    /* Called right after the view shows the scene */
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    SKTexture *backGround = [SKTexture textureWithImageNamed:@"floor"];
   
    
    SKSpriteNode* backGroundNode = [SKSpriteNode spriteNodeWithTexture:backGround];
    backGroundNode.position = self.view.center;
    backGroundNode.size = self.view.frame.size;
    backGroundNode.name = @"backGroundNode";
    [self addChild:backGroundNode];
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    SKTexture *borders = [SKTexture textureWithImageNamed:@"borders"];

    SKSpriteNode* bordersNode = [SKSpriteNode spriteNodeWithTexture:borders];
    bordersNode.position = self.view.center;
    bordersNode.size = self.view.frame.size;
    bordersNode.name = @"borders";
    [self addChild:bordersNode];
    
    SKTexture *texture_center_circle = [SKTexture textureWithImageNamed:@"center_circle"];
    SKTexture *texture_out_circle = [SKTexture textureWithImageNamed:@"out_circle"];
    
    analogp1Left = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp1Left.position = [self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY];
    analogp1Left.size = CGSizeMake(analogSize, analogSize);
    analogp1Left.name = @"analogp1Left";
    analogp1Left.alpha = ControlAlpha;
    [self addChild:analogp1Left];

    analogp1Right = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp1Right.position = [self getPointFromScaleX:p1ControlRightX y:p1ControlRightY];
    analogp1Right.size = CGSizeMake(analogSize, analogSize);
    analogp1Right.name = @"analogp1Right";
    analogp1Right.alpha = ControlAlpha;

    [self addChild:analogp1Right];
    
    analogp2Left = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp2Left.position = [self getPointFromScaleX:p2ControlLeftX y:p2ControlLeftY];
    analogp2Left.size = CGSizeMake(analogSize, analogSize);
    analogp2Left.name = @"analogp2Left";
    analogp2Left.alpha = ControlAlpha;

    [self addChild:analogp2Left];
    
    analogp2Right = [SKSpriteNode spriteNodeWithTexture:texture_out_circle];
    analogp2Right.position = [self getPointFromScaleX:p2ControlRightX y:p2ControlRightY];
    analogp2Right.size = CGSizeMake(analogSize, analogSize);
    analogp2Right.name = @"analogp2Right";
    analogp2Right.alpha = ControlAlpha;

    [self addChild:analogp2Right];
    
    
    analogp1LeftCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp1LeftCenter.position = [self getPointFromScaleX:p1ControlLeftX y:p1ControlLeftY];
    analogp1LeftCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp1LeftCenter.name = @"analogp1Left";
    analogp1LeftCenter.alpha = ControlCenterAlpha;

    [self addChild:analogp1LeftCenter];
    
    analogp1RightCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp1RightCenter.position = [self getPointFromScaleX:p1ControlRightX y:p1ControlRightY];
    analogp1RightCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp1RightCenter.name = @"analogp1Right";
    analogp1RightCenter.alpha = ControlCenterAlpha;

    [self addChild:analogp1RightCenter];
    
    analogp2LeftCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp2LeftCenter.position = [self getPointFromScaleX:p2ControlLeftX y:p2ControlLeftY];
    analogp2LeftCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp2LeftCenter.name = @"analogp2Left";
    analogp2LeftCenter.alpha = ControlCenterAlpha;

    [self addChild:analogp2LeftCenter];
    
    analogp2RightCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    analogp2RightCenter.position = [self getPointFromScaleX:p2ControlRightX y:p2ControlRightY];
    analogp2RightCenter.size = CGSizeMake(analogSize/2, analogSize/2);
    analogp2RightCenter.name = @"analogp2Right";
    analogp2RightCenter.alpha = ControlCenterAlpha;

    [self addChild:analogp2RightCenter];
    
    SKTexture *mech1Texture = [SKTexture textureWithImageNamed:@"Mech1"];
    
    mech1 = [SKSpriteNode spriteNodeWithTexture:mech1Texture];
    mech1.position = [self getPointFromScaleX:50 y:p1ControlLeftY+10];
    mech1.size = CGSizeMake(mechSizeWidth, mechSizeHeight);
    mech1.name = @"mech1";
    [self addChild:mech1];
    
    mech1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:mech1.size]; // 1
    mech1.physicsBody.dynamic = YES; // 2
    mech1.physicsBody.categoryBitMask = mechCategory; // 3
    mech1.physicsBody.contactTestBitMask = mechCategory; // 4
    mech1.physicsBody.collisionBitMask = 0; // 5

    
    SKTexture *mech2Texture = [SKTexture textureWithImageNamed:@"Mech2"];
    
    mech2 = [SKSpriteNode spriteNodeWithTexture:mech2Texture];
    mech2.position = [self getPointFromScaleX:50 y:p2ControlLeftY-10];
    mech2.size = CGSizeMake(mechSizeWidth, mechSizeHeight);
    mech2.name = @"mech2";
    [self addChild:mech2];

    mech2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:mech2.size]; // 1
    mech2.physicsBody.dynamic = YES; // 2
    mech2.physicsBody.categoryBitMask = mechCategory; // 3
    mech2.physicsBody.contactTestBitMask = mechCategory; // 4
    mech2.physicsBody.collisionBitMask = 0; // 5

    wallLeft = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.view.frame.size.width/wallWidth, self.view.frame.size.height)];
    wallLeft.position = [self getPointFromScaleX:wallPositionX y:50];
    wallLeft.alpha = wallAlpha;
    [self addChild:wallLeft];
    
    wallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallLeft.size]; // 1
    wallLeft.physicsBody.dynamic = YES; // 2
    wallLeft.physicsBody.categoryBitMask = borderCategory; // 3
    wallLeft.physicsBody.contactTestBitMask = mechCategory; // 4
    wallLeft.physicsBody.collisionBitMask = 0; // 5

    wallRight = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.view.frame.size.width/wallWidth, self.view.frame.size.height)];
    wallRight.position = [self getPointFromScaleX:100-wallPositionX y:50];
    wallRight.alpha = wallAlpha;
    [self addChild:wallRight];
    
    wallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallRight.size]; // 1
    wallRight.physicsBody.dynamic = YES; // 2
    wallRight.physicsBody.categoryBitMask = borderCategory; // 3
    wallRight.physicsBody.contactTestBitMask = mechCategory; // 4
    wallRight.physicsBody.collisionBitMask = 0; // 5

    wallUp = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/wallHeight)];
    wallUp.position = [self getPointFromScaleX:50 y:wallPositionY];
    wallUp.alpha = wallAlpha;
    [self addChild:wallUp];
    
    wallUp.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallUp.size]; // 1
    wallUp.physicsBody.dynamic = YES; // 2
    wallUp.physicsBody.categoryBitMask = borderCategory; // 3
    wallUp.physicsBody.contactTestBitMask = mechCategory; // 4
    wallUp.physicsBody.collisionBitMask = 0; // 5
    
    wallDown = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/wallHeight)];
    wallDown.position = [self getPointFromScaleX:50 y:100-wallPositionY];
    wallDown.alpha = wallAlpha;
    [self addChild:wallDown];
    
    wallDown.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallDown.size]; // 1
    wallDown.physicsBody.dynamic = YES; // 2
    wallDown.physicsBody.categoryBitMask = borderCategory; // 3
    wallDown.physicsBody.contactTestBitMask = mechCategory; // 4
    wallDown.physicsBody.collisionBitMask = 0; // 5
    
}

- (void)mech:(SKNode *)mech1 didCollideWithMech:(SKNode *)mech2 {
    
    NSLog(@"Mech Hit with Mech");
}

- (void)mech:(SKNode *)mech didCollideWithBorder:(SKNode *)border {
    
    NSLog(@"Mech %@ Hit with Border", mech.name);
    [mech removeActionForKey:[NSString stringWithFormat:@"moveMech%@", mech.name]];
    [mech1 removeAllActions];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"didBeginContact");
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & mechCategory) != 0 && (secondBody.categoryBitMask & mechCategory) != 0)
    {
        [self mech:firstBody.node didCollideWithMech:secondBody.node];

    }
    /*
    if ((firstBody.categoryBitMask & mechCategory) != 0 && (secondBody.categoryBitMask & borderCategory) != 0)
    {
        [self mech:firstBody.node didCollideWithBorder:secondBody.node];
    }
    */
    if ((firstBody.categoryBitMask & borderCategory) != 0 && (secondBody.categoryBitMask & mechCategory) != 0)
    {
        [self mech:secondBody.node didCollideWithBorder:firstBody.node];
    }
}

#pragma Mark - Math stuff

-(CGPoint)getPointFromScaleX:(float)x y:(float)y{
    return CGPointMake((self.view.frame.size.width/100)*x, (self.view.frame.size.height/100)*y);
}

- (float)getDistanceBetween:(CGPoint)p1 and:(CGPoint)p2 {
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@end
