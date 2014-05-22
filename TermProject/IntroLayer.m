//
//  IntroLayer.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "TitleLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    // [DEBUG]
    NSLog(@"[SYSTEM] : IntroLayer Initialized.");
	
	// return the scene
	return scene;
}

//
-(void) onEnter
{
	[super onEnter];
    
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
	// add the label as a child to this Layer
	[self addChild: background];

    // GameCore 초기화 후 설정 불러오기
    gamecore = [GameCore sharedInstance];
    [gamecore loadGameSettings];
    [gamecore initGameStatus];
    // 관리용 객체 초기화
    enemymanager = [EnemyMgr sharedInstance];
    [enemymanager LoadData];
    weaponmanager = [WeaponMgr sharedInstance];
    [weaponmanager LoadData];
    projectilemanager = [ProjectileMgr sharedInstance];
    [projectilemanager LoadData];
    itemmanager = [ItemMgr sharedInstance];
    [itemmanager LoadData];
    // 리소스 관련 객체 초기화
    animationmanager = [AnimationMgr sharedInstance];
    [animationmanager LoadData];
    spritemanager = [SpriteMgr sharedInstance];
    [spritemanager LoadData];
    musicmanager = [MusicMgr sharedInstance];
    [musicmanager LoadData];
    soundmanager = [SoundMgr sharedInstance];
    [soundmanager LoadData];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TitleLayer scene] withColor:ccWHITE]];
}
@end
