#import "SKButton.h"
#import <objc/message.h>

#define max 10

@implementation SKButton{
    SKSpriteNode *analogp1LeftCenter;
}
@synthesize posX, posY;
#pragma mark Texture Initializer

/**
 * Override the super-classes designated initializer, to get a properly set SKButton in every case
 */
- (id)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size {
    return [self initWithTextureNormal:texture selected:nil disabled:nil];
}

- (id)initWithTextureNormal:(SKTexture *)normal selected:(SKTexture *)selected {
    return [self initWithTextureNormal:normal selected:selected disabled:nil];
}

/**
 * This is the designated Initializer
 */
- (id)initWithTextureNormal:(SKTexture *)normal selected:(SKTexture *)selected disabled:(SKTexture *)disabled {
    self = [super initWithTexture:normal color:[UIColor whiteColor] size:normal.size];
    if (self) {
        [self setNormalTexture:normal];
        [self setSelectedTexture:selected];
        [self setDisabledTexture:disabled];
        [self setIsEnabled:YES];
        [self setIsSelected:NO];
        
        _title = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        [_title setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [_title setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        
        [self addChild:_title];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark Image Initializer

- (id)initWithImageNamedNormal:(NSString *)normal selected:(NSString *)selected {
    return [self initWithImageNamedNormal:normal selected:selected disabled:nil];
}

- (id)initWithImageNamedNormal:(NSString *)normal selected:(NSString *)selected disabled:(NSString *)disabled {
    SKTexture *textureNormal = nil;
    if (normal) {
        textureNormal = [SKTexture textureWithImageNamed:normal];
    }
    
    SKTexture *textureSelected = nil;
    if (selected) {
        textureSelected = [SKTexture textureWithImageNamed:selected];
    }
    
    SKTexture *textureDisabled = nil;
    if (disabled) {
        textureDisabled = [SKTexture textureWithImageNamed:disabled];
    }
    
    return [self initWithTextureNormal:textureNormal selected:textureSelected disabled:textureDisabled];
}




#pragma -
#pragma mark Setting Target-Action pairs

- (void)setTouchUpInsideTarget:(id)target action:(SEL)action {
    _targetTouchUpInside = target;
    _actionTouchUpInside = action;
}

- (void)setTouchDownTarget:(id)target action:(SEL)action {
    _targetTouchDown = target;
    _actionTouchDown = action;
}

- (void)setTouchUpTarget:(id)target action:(SEL)action {
    _targetTouchUp = target;
    _actionTouchUp = action;
}

#pragma -
#pragma mark Setter overrides

- (void)setIsEnabled:(BOOL)isEnabled {
    _isEnabled = isEnabled;
    if ([self disabledTexture]) {
        if (!_isEnabled) {
            [self setTexture:_disabledTexture];
        } else {
            [self setTexture:_normalTexture];
        }
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if ([self selectedTexture] && [self isEnabled]) {
        if (_isSelected) {
            [self setTexture:_selectedTexture];
        } else {
            [self setTexture:_normalTexture];
        }
    }
}

#pragma -
#pragma mark Touch Handling

/**
 * This method only occurs, if the touch was inside this node. Furthermore if
 * the Button is enabled, the texture should change to "selectedTexture".
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isEnabled]) {
        objc_msgSend(_targetTouchDown, _actionTouchDown);
        [self setIsSelected:YES];
    }
    SKTexture *texture_center_circle = [SKTexture textureWithImageNamed:@"center_circle"];
    
    
    
    analogp1LeftCenter = [SKSpriteNode spriteNodeWithTexture:texture_center_circle];
    
    analogp1LeftCenter.size = CGSizeMake(self.frame.size.width/2, self.frame.size.height/2);
    analogp1LeftCenter.name = [NSString stringWithFormat:@"%@-analogCenter", self.name];

    [self addChild:analogp1LeftCenter];
//    analogp1LeftCenter.position = [self getPointFromTouches:touches];
    posX = analogp1LeftCenter.position.x;
    posY = analogp1LeftCenter.position.y;

    
    
}

/**
 * If the Button is enabled: This method looks, where the touch was moved to.
 * If the touch moves outside of the button, the isSelected property is restored
 * to NO and the texture changes to "normalTexture".
 */

-(CGPoint)getPointFromTouch:(CGPoint)touchPoint{
    
    return CGPointMake(posX+touchPoint.x-self.position.x, posX+touchPoint.y-self.position.y);
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isEnabled]) {

        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            NSArray *nodes = [self nodesAtPoint:location];
            for (SKNode *node in nodes) {
               
                if ([node.name isEqualToString:[self.name stringByAppendingString:@"-analogCenter"]]) {
                    CGPoint touchPoint = [touch locationInNode:self.parent];
                    NSLog(@"touchpoint %f %f", touchPoint.x, touchPoint.y);
                    if (CGRectContainsPoint(self.frame, touchPoint)) {
                        [self setIsSelected:YES];
                    } else {
                        [self setIsSelected:NO];
                    }
                    
                    posX = posY = 0;
                    
                    
                    analogp1LeftCenter.position = [self getPointFromTouch:touchPoint];
                    
                    if (posX>max) {
                        posX = max;
                    }else if (posX<-max){
                        posX = -max;
                    }else{
                        posX = analogp1LeftCenter.position.x;
                    }
                    
                    if (posY>max) {
                        posY = max;
                    }else if (posY<-max){
                        posY = -max;
                    }else{
                        posY = analogp1LeftCenter.position.y;
                    }
                }
            }
            //  [self controlAnalogs];
        }
        

    }
}

/**
 * If the Button is enabled AND the touch ended in the buttons frame, the
 * selector of the target is run.
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self.parent];
    
    if ([self isEnabled] && CGRectContainsPoint(self.frame, touchPoint)) {
        objc_msgSend(_targetTouchUpInside, _actionTouchUpInside);
    }
    [self setIsSelected:NO];
    objc_msgSend(_targetTouchUp, _actionTouchUp);
    [analogp1LeftCenter removeFromParent];
    posX = posY = 0;
}

@end