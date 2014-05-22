//
//  TitleLayer.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "TitleLayer.h"
#import "GameLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#pragma mark - TitleLayer

// TitleLayer implementation
@implementation TitleLayer

// Helper class method that creates a Scene with the TitleLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TitleLayer *layer = [TitleLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(0,0,255,255)]) ) {
		// ask director for the window size
		size = [[CCDirector sharedDirector] winSize];
        // Audio Engine 설정
        sae = [SimpleAudioEngine sharedEngine];
        // GameCore 설정 (게임 초기화)
        gamecore = [GameCore sharedInstance];
        [gamecore initGameStatus];
        // 리소스 관련 객체 설정
        musicmanager = [MusicMgr sharedInstance];
        soundmanager = [SoundMgr sharedInstance];
        
        // 배경 로드
        bg01 = [CCSprite spriteWithFile:@"bg_Title.png"];
        bg02 = [CCSprite spriteWithFile:@"bg_Title.png"];
        // 배경 초기위치 지정
        bg01.anchorPoint = CGPointZero;
        bg01.position = CGPointZero;
        bg02.anchorPoint = CGPointZero;
        bg02.position = ccp(size.width, 0);
        // 배경을 SceneGraph에 추가
        [self addChild:bg01 z:0];
        [self addChild:bg02 z:0];
        
        // 제목을 띄운다
        CCSprite* title = [CCSprite spriteWithFile:@"title_title.png"];
        [title setPosition:ccp(size.width*0.5,size.height*0.8)];
        [self addChild:title z:1];

        // 메뉴 생성
        CCMenuItem* menuitem1 = [CCMenuItemImage itemWithNormalImage:@"title_button01.png" selectedImage:@"title_button01s.png" target:self selector:@selector(goGame)];
        CCMenu *menu = [CCMenu menuWithItems:menuitem1, nil];
        // 메뉴 생성 - 메뉴 및 메뉴 아이템들의 위치 설정
        [menu setPosition:ccp(0,0)];
        menuitem1.position = ccp(size.width*0.5,size.height*0.36);
        // 메뉴 생성 - SceneGraph에 추가
        [self addChild:menu z:1];
        
        // [DEBUG]
        NSLog(@"[SYSTEM] : TitleLayer Initialized.");
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void)onEnter
{
	[super onEnter];
	[self schedule:@selector(scrollBG)];
}

- (void) scrollBG
{
    // 배경화면 스크롤
	CGFloat scrollspeed = 0.5;
    
    // 1번째 배경을 스크롤
	if (bg01.position.x - scrollspeed > -size.width)
        [bg01 setPosition:ccp(bg01.position.x - scrollspeed,0)];
	else
		[bg01 setPosition:ccp(size.width,0)];
    
    // 2번째 배경을 스크롤
    if (bg02.position.x - scrollspeed > -size.width)
		[bg02 setPosition:ccp(bg02.position.x - scrollspeed,0)];
	else
		[bg02 setPosition:ccp(size.width,0)];
}

- (void) goGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
}

@end
