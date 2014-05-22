//
//  ResultLayer.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "ResultLayer.h"
#import "GameLayer.h"
#import "TitleLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#pragma mark - ResultLayer

// ResultLayer implementation
@implementation ResultLayer

// Helper class method that creates a Scene with the ResultLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResultLayer *layer = [ResultLayer node];
	
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
	if( (self=[super initWithColor:ccc4(0,0,0,0)]) ) {
		// ask director for the window size
		size = [[CCDirector sharedDirector] winSize];
        // Audio Engine 설정
        sae = [SimpleAudioEngine sharedEngine];
        // GameCore 설정 (게임 초기화)
        gamecore = [GameCore sharedInstance];
        // 리소스 관련 객체 설정
        musicmanager = [MusicMgr sharedInstance];
        soundmanager = [SoundMgr sharedInstance];
        
        // BGM을 멈춘다
        [sae stopBackgroundMusic];

        // 배경을 출력한다
        // 배경 로드
        bg01 = [CCSprite spriteWithFile:@"bg_Result_1.png"];
        bg02 = [CCSprite spriteWithFile:@"bg_Result_2.png"];
        // 배경 초기위치 지정
        bg01.anchorPoint = CGPointZero;
        bg01.position = CGPointZero;
        bg02.anchorPoint = CGPointZero;
        bg02.position = ccp(0,-size.height);
        // 검은선 방지를 위해 AA를 끈다
        [bg01.texture setAntiAliasTexParameters];
        [bg02.texture setAntiAliasTexParameters];
        // 배경을 SceneGraph에 추가
        [self addChild:bg01 z:0];
        [self addChild:bg02 z:0];
        
        // 창을 띄운다
        CCSprite *scenetitle = [CCSprite spriteWithFile:@"result_title.png"];
        [scenetitle setPosition:ccp(size.width/2, size.height-(scenetitle.contentSize.height+32)/2)];
        [self addChild:scenetitle z:10];
        CCSprite *scenewindow = [CCSprite spriteWithFile:@"common_window1.png"];
        [scenewindow setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:scenewindow z:20];

        // 메뉴를 생성한다
        // 메뉴 생성 - 메뉴 아이템용 레이블
        CCMenuItem *menuitem1 = [CCMenuItemImage itemWithNormalImage:@"result_button01.png" selectedImage:@"result_button01s.png" target:self selector:@selector(goGame)];
        CCMenuItem *menuitem2 = [CCMenuItemImage itemWithNormalImage:@"result_button02.png" selectedImage:@"result_button02s.png" target:self selector:@selector(goTitle)];
        // 메뉴 생성 - 실제로 생성
        CCMenu *menu = [CCMenu menuWithItems:menuitem1, menuitem2, nil];
        // 메뉴 생성 - 메뉴 및 메뉴 아이템들의 위치 설정
        [menu setPosition:ccp(0,0)];
        [menuitem1 setPosition:ccp((menuitem1.contentSize.width+32)/2,(menuitem1.contentSize.height+32)/2)];
        [menuitem2 setPosition:ccp(size.width-(menuitem2.contentSize.width+32)/2,(menuitem2.contentSize.height+32)/2)];
        // 메뉴 생성 - SceneGraph에 추가
        [self addChild:menu z:30];

        // 화면에 점수 표시용 레이블 추가
        CCLabelTTF* scorelabel1 = [CCLabelTTF labelWithString:@"SCORE : " fontName:@"Dungeon" fontSize:18];
        CCLabelTTF* scorelabel2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%010d",[gamecore getScore]] fontName:@"Dungeon" fontSize:18];
        scorelabel1.position = ccp(size.width*0.5, size.height*0.8);
        scorelabel2.position = ccp(size.width*0.5, size.height*0.72);
        [self addChild:scorelabel1 z:20];
        [self addChild:scorelabel2 z:20];
        // 화면에 시간 표시용 레이블 추가
        CCLabelTTF* timelabel1 = [CCLabelTTF labelWithString:@"TIME :" fontName:@"Dungeon" fontSize:18];
        CCLabelTTF* timelabel2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%02d:%02d",[gamecore getElapsedTime]/60, [gamecore getElapsedTime]%60] fontName:@"Dungeon" fontSize:18];
        timelabel1.position = ccp(size.width*0.5, size.height*0.6);
        timelabel2.position = ccp(size.width*0.5, size.height*0.52);
        [self addChild:timelabel1 z:20];
        [self addChild:timelabel2 z:20];

        // [DEBUG]
        NSLog(@"[SYSTEM] : ResultLayer Initialized.");
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
    // 점수 설정하기
    if ([gamecore getScore] > [gamecore getHighScore])
        [gamecore setHighScore:[gamecore getScore]];
        
	[super onEnter];
	[self schedule:@selector(scrollBG)];
}


- (void) scrollBG
{
    // 배경화면 스크롤
	CGFloat scrollspeed = -0.5;
    
    // 1번째 배경을 스크롤
	if (bg01.position.y - scrollspeed < size.height)
        [bg01 setPosition:ccp(0, bg01.position.y - scrollspeed)];
	else
		[bg01 setPosition:ccp(0, -size.height)];
    
    // 2번째 배경을 스크롤
    if (bg02.position.y + scrollspeed < size.height)
		[bg02 setPosition:ccp(0, bg02.position.y - scrollspeed)];
	else
		[bg02 setPosition:ccp(0, -size.height)];
}


- (void) goGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
}

- (void) goTitle
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TitleLayer scene] withColor:ccWHITE]];
}

@end
