//
//  MyScene.h
//  qoda
//

//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKButton.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, retain) SKButton *btn1P1;
@property (nonatomic, retain) SKButton *btn2P1;
@property (nonatomic, retain) SKButton *btn3P1;
@property (nonatomic, retain) SKButton *btn4P1;

@property (nonatomic, retain) SKButton *btn1P2;
@property (nonatomic, retain) SKButton *btn2P2;
@property (nonatomic, retain) SKButton *btn3P2;
@property (nonatomic, retain) SKButton *btn4P2;

@end

