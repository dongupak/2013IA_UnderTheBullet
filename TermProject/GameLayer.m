//
//  ResultLayer.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "TitleLayer.h"
#import "ResultLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#pragma mark - GameLayer

// GameLayer implementation
@implementation GameLayer

// 오브젝트 리스트 (종류별)
@synthesize objects_targets;
@synthesize objects_projectiles1;
@synthesize objects_projectiles2;
@synthesize objects_items;


// Helper class method that creates a Scene with the GameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
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
	if( (self=[super initWithColor:ccc4(0,0,0,255)]) ) {
		// ask director for the window size
		size = [[CCDirector sharedDirector] winSize];
        
        // Accelerometer, Touch 동작 개시
        self.isTouchEnabled = TRUE;
        self.isAccelerometerEnabled = TRUE;
        // 화면보호기 정지
        UIApplication *thisApp = [UIApplication sharedApplication];
        thisApp.idleTimerDisabled = TRUE;
        
        // SAE 초기화
        sae = [SimpleAudioEngine sharedEngine];
        
        // GameCore 설정 (게임 초기화)
        gamecore = [GameCore sharedInstance];
        [gamecore initGameStatus];
        // 관리용 객체 초기화
        enemymanager = [EnemyMgr sharedInstance];
        weaponmanager = [WeaponMgr sharedInstance];
        projectilemanager = [ProjectileMgr sharedInstance];
        itemmanager = [ItemMgr sharedInstance];
        // 리소스 관련 객체 초기화
        animationmanager = [AnimationMgr sharedInstance];
        spritemanager = [SpriteMgr sharedInstance];
        musicmanager = [MusicMgr sharedInstance];
        soundmanager = [SoundMgr sharedInstance];

        // objectlist 초기화
        objectlist = [CCNode node];
        [self addChild:objectlist z:1];
        // 각 오브젝트별 목록 초기화 (적 캐릭터, 탄환-적, 탄환-플레이어, 아이템)
        objects_targets = [[NSMutableArray alloc] init];
        objects_projectiles1 = [[NSMutableArray alloc] init];
        objects_projectiles2 = [[NSMutableArray alloc] init];
        objects_items = [[NSMutableArray alloc] init];
        
        // 배경을 출력한다
        // 배경 로드
        bg01 = [CCSprite spriteWithFile:@"bg_Game_1.png"];
        bg02 = [CCSprite spriteWithFile:@"bg_Game_2.png"];
        // 검은선 방지를 위해 AA를 끈다
        [bg01.texture setAntiAliasTexParameters];
        [bg02.texture setAntiAliasTexParameters];
        // 배경 초기위치 지정
        bg01.anchorPoint = CGPointZero;
        bg01.position = CGPointZero;
        bg02.anchorPoint = CGPointZero;
        bg02.position = ccp(0,-size.height);
        // 배경을 SceneGraph에 추가
        [self addChild:bg01 z:0];
        [self addChild:bg02 z:0];
        
        // 인터페이스 띄우기 : 프레임
        CCSprite* scrframe = [CCSprite spriteWithFile:@"game_frame.png"];
        scrframe.anchorPoint = CGPointZero;
        scrframe.position = CGPointZero;
        [self addChild:scrframe z:20];

        // 인터페이스 띄우기 : 버튼(발사)
        shootbutton_n = [CCSprite spriteWithFile:@"game_button02.png"];
        shootbutton_s = [CCSprite spriteWithFile:@"game_button02s.png"];
        [shootbutton_n setPosition:ccp(size.width-shootbutton_n.contentSize.width/2,shootbutton_n.contentSize.height/2)];
        [shootbutton_s setPosition:ccp(size.width-shootbutton_s.contentSize.width/2,shootbutton_s.contentSize.height/2)];
        [self addChild:shootbutton_n z:21];
        [self addChild:shootbutton_s z:20];

        // 인터페이스 띄우기 : 점수 표시용 레이블
        scorelabel1 = [CCLabelTTF labelWithString:@"0000000000" fontName:@"Dungeon" fontSize:10];
        scorelabel2 = [CCLabelTTF labelWithString:@"0000000000" fontName:@"Dungeon" fontSize:10];
        scorelabel1.anchorPoint = ccp(0,0);
        scorelabel2.anchorPoint = ccp(0,0);
        scorelabel1.position = ccp(size.width-scorelabel1.contentSize.width, size.height-scorelabel2.contentSize.height*2.5);
        scorelabel2.position = ccp(0,size.height-scorelabel2.contentSize.height*2.5);
        [self addChild:scorelabel1 z:20];
        [self addChild:scorelabel2 z:20];
        scorelabel1.string = [NSString stringWithFormat:@"%010d",[gamecore getHighScore]];
        // 인터페이스 띄우기 : 시간 표시용 레이블
        timelabel1 = [CCLabelTTF labelWithString:@"TIME" fontName:@"Dungeon" fontSize:10];
        timelabel2 = [CCLabelTTF labelWithString:@"0" fontName:@"Dungeon" fontSize:10];
        timelabel1.position = ccp(size.width/2,size.height-timelabel1.contentSize.height/2);
        timelabel2.position = ccp(size.width/2,size.height-timelabel1.contentSize.height/2-timelabel2.contentSize.height/1.5);
        [self addChild:timelabel1 z:20];
        [self addChild:timelabel2 z:20];

        // BGM 출력 (테스트)
        [sae playBackgroundMusic:[musicmanager getBGMPath:arc4random() % [musicmanager getListSize]]];
        
        // [DEBUG]
        NSLog(@"[SYSTEM] : GameLayer Initialized.");
        
//        // [디버그용]
//        targetscreated = 0;
//        targetsdeleted = 0;
//        targetsinscreen = 0;
//        projectilescreated = 0;
//        projectilesdeleted = 0;
//        projectilesinscreen = 0;
//        debuglabel1 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel2 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel3 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel4 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel5 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel6 = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
//        debuglabel1.position = ccp(0,128);
//        debuglabel2.position = ccp(0,96);
//        debuglabel3.position = ccp(0,64);
//        debuglabel4.position = ccp(0,224);
//        debuglabel5.position = ccp(0,192);
//        debuglabel6.position = ccp(0,160);
//        debuglabel1.anchorPoint = CGPointZero;
//        debuglabel2.anchorPoint = CGPointZero;
//        debuglabel3.anchorPoint = CGPointZero;
//        debuglabel4.anchorPoint = CGPointZero;
//        debuglabel5.anchorPoint = CGPointZero;
//        debuglabel6.anchorPoint = CGPointZero;
//        [self addChild:debuglabel1 z:20];
//        [self addChild:debuglabel2 z:20];
//        [self addChild:debuglabel3 z:20];
//        [self addChild:debuglabel4 z:20];
//        [self addChild:debuglabel5 z:20];
//        [self addChild:debuglabel6 z:20];
        
        // 게임 시작
        [self onStart];
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


//- (void) onEnter
//{
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//    [super onEnter];
//}

- (void) onStart
{
    // 게임 시작 시의 처리
    // 플레이어 캐릭터를 생성해준다 (플레이어 스프라이트는 0번이다)
    object_PC = [GameObject spriteWithFile:[spritemanager getSpritePath:0]];
    [object_PC setPosition:ccp(size.width*0.5, size.height*0.2)];
    [object_PC setWeaponno:0];
    [object_PC setIsinvincible:0];
    [self addChild:object_PC z:11];
//    // 패턴 테스트용 : 적 캐릭터를 생성
//    [self addTarget:1 XCoord:size.width*0.5 YCoord:size.height*0.8];
    // 3초간 대기 후 게임 로직을 실행시킨다
    [self showReadyScreen];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3.0],
                     [CCCallFunc actionWithTarget:self selector:@selector(hideReadyScreen)],
                     [CCCallFunc actionWithTarget:self selector:@selector(startGameLogics)],
                     nil]];
    // 배경화면 스크롤도
    [self schedule:@selector(scrollBG)];
    // 일단 적 캐릭터를 생성한다
    [self createTargets];
}

- (void) showReadyScreen
{
    // 시작할 때까지 3초간 카운트다운
}
- (void) hideReadyScreen
{
    // 카운트다운 끝난 후 화면을 삭제한다
}

- (void) startGameLogics
{
    // 게임 로직을 시작시킨다
    [self schedule:@selector(onUpdate:) interval:1/60];     // (매 프레임마다 갱신되는 것)
    [self schedule:@selector(onUpdate2:) interval:1.0];     // (매 초마다 갱신되는 것)
    // 적 캐릭터 생성은 3초마다 1번
    [self schedule:@selector(createTargets) interval:3.0];
}


- (void) onEnd
{
    // 게임 오버 시의 처리
    [self unschedule:@selector(onUpdate:)];
    [self unschedule:@selector(onUpdate2:)];
    // 결과 화면으로 이동한다
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[ResultLayer scene] withColor:ccWHITE]];
}


- (void) onUpdate:(ccTime)dt
{
    // 게임 로직 : 매 프레임마다
    
    // 현재 진행된 프레임 수 업데이트
    [gamecore addElapsedFrame];

    //    // [DEBUG]
    //    NSLog(@"Frames Elapsed : %d", [gamecore getElapsedFrame]);
    
    // 임시 변수
    NSMutableArray *objects_deleted_projectile1 = [NSMutableArray array];   // 삭제 대상 목록 (탄환-적)
    NSMutableArray *objects_deleted_projectile2 = [NSMutableArray array];   // 삭제 대상 목록 (탄환-플레이어)
    NSMutableArray *objects_deleted_target = [NSMutableArray array];        // 삭제 대상 목록 (타겟)
    NSMutableArray *objects_deleted_item = [NSMutableArray array];          // 삭제 대상 목록 (아이템)
    // 임시 변수 (충돌 판정용)
    CGRect playerrect1 = CGRectMake(object_PC.position.x, object_PC.position.y, object_PC.contentSize.width, object_PC.contentSize.height);
    CGRect playerrect2 = CGRectMake(object_PC.position.x, object_PC.position.y, object_PC.contentSize.width/2, object_PC.contentSize.height/2);
    
    // [디버그용]
    projectilesinscreen = 0;
    targetsinscreen = 0;

    // 상태 업데이트 (플레이어, 타겟, 탄환, 아이템)
    [self updatePlayerStatus];
    [self updateTargetStatus];
    [self updateProjectile1Status];
    [self updateProjectile2Status];
//    [self updateItemStatus];

    // 피탄판정 (플레이어)
    for (GameObject *object in objects_projectiles1)
    {
        // 충돌 감지용 사각형 (탄환)
        CGRect objectrect = CGRectMake(object.position.x, object.position.y, object.contentSize.width*0.75, object.contentSize.height*0.75);
        // 충돌 가능성을 확인한다 (1차 체크)
        if (CGRectIntersectsRect(playerrect1, objectrect) && object_PC.iscollided == FALSE && object.iscollided == FALSE)
        {
            // 진짜로 충돌인가? (2차 체크)
            if (CGRectIntersectsRect(playerrect2, objectrect))
            {
//                // [DEBUG]
//                NSLog(@"HIT");
                // 맞았을 경우에는 게임오버로 처리한다
                // 일단 적탄은 삭제처리
                object.iscollided = TRUE;                           // 오브젝트의 충돌여부를 TRUE로
                [objects_deleted_projectile1 addObject:object];     // 삭제 대상 리스트에 올린다
                // 만약에 플레이어가 무적상태가 아니라면 게임오버
                if (object_PC.isinvincible == 0)
                {
                    // 플레이어는 페이드아웃시키고, 플레이어의 폭발 이펙트 재생
                    object_PC.iscollided = TRUE;                        // 플레이어의 충돌여부를 TRUE로
                    [object_PC stopAllActions];
                    [self addExplosionEffectTo:object_PC];
                    [object_PC runAction:[CCFadeOut actionWithDuration:0.5]];
                    [self onEnd];
//                    // [DEBUG]
//                    NSLog(@"GAME OVER : HIT");
                }
            }
            else
            {
                // 아닐 경우에는 회피 보너스 점수를 추가
                //                // [DEBUG]
                //                NSLog(@"Graze Bonus");
            }
        }
    }
    // 피탄판정 (타겟)
    for (GameObject *object1 in objects_projectiles2)
    {
        // 충돌 감지용 사각형 (탄환 : 플레이어)
        CGRect object1rect = CGRectMake(object1.position.x, object1.position.y, object1.contentSize.width, object1.contentSize.height);
        // 플레이어 탄과 타겟의 충돌여부를 체크하는 것
        for (GameObject *object2 in objects_targets)
        {
//            // 충돌 감지용 사각형 (타겟) : 실제 코드
//            CGRect object2rect = CGRectMake(object2.position.x+object2.strikezoneX, object2.position.y+object2.strikezoneY, object2.strikezoneW, object2.strikezoneH);
            // 충돌 감지용 사각형 (타겟) : 테스트용 코드
            CGRect object2rect = CGRectMake(object2.position.x, object2.position.y, object2.contentSize.width*0.75, object2.contentSize.height*0.75);
            // 충돌 여부를 확인한다
            if (CGRectIntersectsRect(object1rect, object2rect) && object2.isremoved == FALSE)
            {
                // 충돌한 경우
                // 탄환의 충돌여부를 TRUE로
                object1.iscollided = TRUE;
                object2.iscollided = TRUE;
                // 탄환과 타겟에 각각 데미지를 입힌다 (탄환에는 타겟의 현재 HP만큼의 데미지를, 타겟에는 탄환 자체의 데미지를 입힌다)
                // 만약에 탄환이 소멸하지 않는다면 관통하고 지나간걸로 친다
                object1.currentHP -= object2.currentHP;
                if (object2.isindestructable == 0)  // 단, 타겟에 데미지를 입히는 건 타겟이 무적상태가 아닐 때만
                    object2.currentHP -= [projectilemanager getBaseDamage:object1];
                // 탄환의 소멸 여부를 체크한다 (탄환의 현재 HP가 0 이하인지를 체크한다
                if (object1.currentHP <= 0)
                {
                    // 소멸하는 경우
                    // 탄환을 삭제 대상 리스트에 올린다
                    object1.isremoved = TRUE;
                    [objects_deleted_projectile2 addObject:object1];
                }
                // 타겟의 소멸 여부를 체크한다 (타겟의 현재 HP가 0 이하인지를 체크한다)
                if (object2.currentHP <= 0)
                {
                    // 소멸하는 경우
                    // 타겟을 삭제 대상 리스트에 올린다
                    object2.isremoved = TRUE;
                    [objects_deleted_target addObject:object2];
                    // EnemyMgr를 통해서 타겟 격파시의 점수를 확인한 후 그 값을 점수에 추가해준다
                    [gamecore addScore:[enemymanager getBaseScore:object2.objecttype]];
                    // 화면에 폭발 이펙트를 재생한다
                    // 효과음을 재생한다
                    [sae playEffect:@"@explosion.wav"];
                }
            }
        }
    }
    // 충돌판정 (플레이어-타겟)
    for (GameObject *object in objects_targets)
    {
//        // 충돌 감지용 사각형 (타겟) : 실제 코드
//        CGRect objectrect = CGRectMake(object.position.x+object.strikezoneX, object.position.y+object.strikezoneY, object.strikezoneW, object.strikezoneH);
        // 충돌 감지용 사각형 (타겟) : 테스트용 코드
        CGRect objectrect = CGRectMake(object.position.x, object.position.y, object.contentSize.width, object.contentSize.height);
        // 충돌 가능성을 확인한다 (1차 체크)
        if (CGRectIntersectsRect(playerrect1, objectrect) && object_PC.iscollided == FALSE && object.iscollided == FALSE && object.isremoved == FALSE)
        {
            // 진짜로 충돌인가? (2차 체크)
            if (CGRectIntersectsRect(playerrect2, objectrect))
            {
                // 박았을 경우에는 게임오버로 처리한다
//                // [DEBUG]
//                NSLog(@"CRASH");
                // 일단 타겟은 삭제처리
                object.iscollided = TRUE;
                object.isremoved = TRUE;
                [objects_deleted_target addObject:object];
                // 만약에 플레이어가 무적상태가 아니라면 게임오버
                if (object_PC.isinvincible == 0)
                {
                    // 플레이어는 페이드아웃시키고, 플레이어의 폭발 이펙트 재생
                    object_PC.iscollided = TRUE;                        // 플레이어의 충돌여부를 TRUE로
                    [object_PC stopAllActions];
                    [self addExplosionEffectTo:object_PC];
                    [object_PC runAction:[CCFadeOut actionWithDuration:0.5]];
                    [self onEnd];
//                    // [DEBUG]
//                    NSLog(@"GAME OVER : CRASH");
                }
                else
                {
                    // 하지만 플레이어가 무적상태라면 어떨까
                    // EnemyMgr를 통해서 타겟 격파시의 점수를 확인한 후 그 값을 점수에 추가해준다
                    [gamecore addScore:[enemymanager getBaseScore:object.objecttype]];
                }
            }
            else
            {
                // 아닐 경우에는 회피 보너스 점수를 추가
                //                // [DEBUG]
                //                NSLog(@"Graze Bonus");
            }
        }
    }
    // 충돌판정 (플레이어-아이템)
    for (GameObject *object in objects_items)
    {
        // 충돌 감지용 사각형 (타겟)
        CGRect objectrect = CGRectMake(object.position.x, object.position.y, object.contentSize.width, object.contentSize.height);
        // 충돌 여부를 파악한다
        if (CGRectIntersectsRect(playerrect1, objectrect) && object.iscollided == FALSE)
        {
            // 충돌한 경우 아이템이 맞는지 확인해보고 나서 효과를 플레이어에게 적용
            if ([object objectcategory] == 3)
            {
                object.iscollided = TRUE;                               // 오브젝트의 충돌여부를 TRUE로
                [self applyItemEffectToPlayer:[object objecttype]];     // 효과 적용
                [objects_deleted_item addObject:object];                // 삭제 대상 리스트에 올린다
            }
        }
    }
    
    // 피탄이나 충돌로 인해 삭제 대상으로 등록된 오브젝트들은 모두 삭제
    for (GameObject *object in objects_deleted_projectile1)
    {
        [objects_projectiles1 removeObject:object];
        [objectlist removeChild:object cleanup:NO];
        // [디버그용]
        projectilesdeleted++;
//        // [DEBUG]
//        NSLog(@"Projectile1 deleted by collision");
    }
    for (GameObject *object in objects_deleted_projectile2)
    {
        [objects_projectiles2 removeObject:object];
        [objectlist removeChild:object cleanup:NO];
        // [디버그용]
        projectilesdeleted++;
//        // [DEBUG]
//        NSLog(@"Projectile2 deleted by collision");
    }
    for (GameObject *object in objects_deleted_target)
    {
        [objects_targets removeObject:object];
        [objectlist removeChild:object cleanup:NO];
        // [디버그용]
        targetsdeleted++;
//        // [DEBUG]
//        NSLog(@"Target deleted by collision");
    }
    for (GameObject *object in objects_deleted_item)
    {
        [objects_items removeObject:object];
        [objectlist removeChild:object cleanup:NO];
//        // [DEBUG]
//        NSLog(@"Item deleted by collision");
    }
    
    // 화면에 버틴 시간 출력
    timelabel2.string = [NSString stringWithFormat:@"%d",[gamecore getElapsedTime]];
    timelabel2.position = ccp(size.width/2,size.height-timelabel1.contentSize.height/2-timelabel2.contentSize.height/1.5);
    // 화면에 점수 출력
    scorelabel2.string = [NSString stringWithFormat:@"%010d",[gamecore getScore]];
    
    // [디버그용]
    debuglabel1.string = [NSString stringWithFormat:@"%d", projectilescreated];
    debuglabel2.string = [NSString stringWithFormat:@"%d", projectilesdeleted];
    debuglabel3.string = [NSString stringWithFormat:@"%d", projectilesinscreen];
    debuglabel4.string = [NSString stringWithFormat:@"%d", targetscreated];
    debuglabel5.string = [NSString stringWithFormat:@"%d", targetsdeleted];
    debuglabel6.string = [NSString stringWithFormat:@"%d", targetsinscreen];
}

- (void) updatePlayerStatus
{
    // 플레이어 상태 업데이트 : (프레임당 1회)
    
    // 이동 방향에 따라 플레이어의 위치를 변경한다
    [self movePlayer:playervelocity];
    
    // 공격이 가능한 경우에는 공격을 가한다
    if (shootbuttonispressed)
    {
        // 이미 공격중인 경우
        if (object_PC.isshooting == TRUE)
        {
            NSInteger tmpweaponno = object_PC.weaponno;
            // 다음 발사까지 남은 프레임이 0이면 탄을 쏜다.
            if (object_PC.framestonextshot == 0)
            {
                // 발사 횟수 1 증가.
                object_PC.shootcount++;
                // 발사 처리 부분 (루프로 돌린다)
                for (int i = 0; i < [weaponmanager getProjectilesPerShoot:tmpweaponno]; i++)
                {
                    [self addProjectile:[weaponmanager getProjectileTypeOfWeapon:tmpweaponno Projectile:i]
                                 XCoord:object_PC.position.x-[weaponmanager getprojectileInitialX:tmpweaponno Projectile:i]
                                 YCoord:object_PC.position.y-[weaponmanager getprojectileInitialY:tmpweaponno Projectile:i]
                                  Angle:[weaponmanager getProjectileAngle:tmpweaponno Projectile:i]
                           AngleChanges:[weaponmanager getProjectileAngleChanges:tmpweaponno Projectile:i]
                            AngleChange:[weaponmanager getProjectileAngleChange:tmpweaponno Projectile:i]
                           IsDisappears:[weaponmanager getProjectileDisappears:tmpweaponno Projectile:i]
                             TimeToLive:[weaponmanager getProjectileTTL:tmpweaponno Projectile:i]
                                 LockOn:FALSE
                             TargetType:1];
                }
                // 사운드 재생
                [soundmanager playSound:[weaponmanager getSoundEffect:tmpweaponno]];
                // 발사 완료. 다음번 발사까지 카운트 시작.
                object_PC.framestonextshot = [weaponmanager getFramesBetweenShoot:tmpweaponno];
                // 공격이 끝났는지 체크해본다 (정해진 탄을 다 쏘면 끝난 걸로 친다)
                if (object_PC.shootcount >= 11)
                {
                    // 끝났으면 공격을 멈추고 카운터를 리셋한다 (다음 공격까지 남은 시간을 돌린다)
                    object_PC.isshooting = FALSE;
                    object_PC.framestonextattack = [weaponmanager getFramesBetweenAttack:tmpweaponno];
                }
            }
            // 다음 발사까지 1프레임 이상 남은 경우
            else
            {
                // 다음 발사까지 남은 프레임 수를 1 줄인다
                object_PC.framestonextshot--;
            }
        }
        // 공격중이지 않은 경우
        else
        {
            // 다음 공격까지 남은 프레임 수가 0이면 공격을 시작한다.
            if (object_PC.framestonextattack == 0)
            {
                object_PC.isshooting = TRUE;       // 발사중인 걸로 친다
                object_PC.shootcount = 0;          // 발사 횟수 초기화
                object_PC.framestonextshot = 0;    // 일단 첫 발은 딜레이 없이 다음 프레임에서 곧장 발사
            }
            // 그렇지 않다면
            else
            {
                // 다음 공격까지 남은 프레임 수를 1 줄인다.
                object_PC.framestonextattack--;
            }
        }
    }
    
    // 효과가 적용중인 경우에는 효과를 설정한다
    if (object_PC.effectactiavated == TRUE)
    {
        // 지속시간이 다 된 경우에는 해제한다
        if (object_PC.effectremaining <= 0)
            [self deleteItemEffectToPlayer:object_PC.effectno];
        // 효과 지속시간을 줄인다
        object_PC.effectremaining--;
    }
}

- (void) updateTargetStatus
{
    // 타겟 업데이트 : (프레임당 1회)
    
//    // [DEBUG]
//    NSLog(@"Update Target's status");

    // 임시 변수
    NSMutableArray *objects_deleted = [NSMutableArray array];   // 삭제 대상 목록
    
    // 모든 타겟을 대상으로
    for (GameObject *object in objects_targets)
    {
        // 화면을 벗어났거나, 슬슬 삭제될 타이밍인 타겟은 삭제한다
        if (object.position.y < -1*(object.contentSize.height) || object.position.x > size.width || object.position.x < 0)
            [objects_deleted addObject:object];
        else if (object.isdisappears == TRUE && object.timetolive <= 0)
            [objects_deleted addObject:object];
        // 그렇지 않은 경우에는 상태를 업데이트한다
        else
        {
            // 충돌 여부는 0으로 변경
            object.iscollided = FALSE;
            
            // 이동 특성에 따라 이동 방향을 (0:직진, 1:플레이어에게 접근, 2:플레이어에게서 벗어나는 방향, 3:좌로 선회, 4:우로 선회, 5:랜덤)
            // 이동 방향에 따라 타겟의 위치를 변경한다
            object.position = ccpAdd(object.position, ccp(object.movementX,-1*object.movementY));
            
            // 공격 처리
            // 공격은 화면 상에 있을 때만
            if (object.position.y < size.height-object.contentSize.height &&
                object.position.y > object.contentSize.height &&
                object.position.x > 0 &&
                object.position.x < size.width+object.contentSize.width)
            {
                // [디버그용]
                targetsinscreen++;

                // 이미 공격중인 경우
                if (object.isshooting == TRUE)
                {
                    // 무기 번호를 가져온다
                    NSInteger tmpweaponno = [enemymanager getWeaponNo:object.objecttype];
                    // 다음 발사까지 남은 프레임이 0이면 탄을 쏜다.
                    if (object.framestonextshot == 0)
                    {
                        // 발사 횟수 1 증가.
                        object.shootcount++;
                        // 발사 처리 부분 (루프로 돌린다)
                        for (int i = 0; i < [weaponmanager getProjectilesPerShoot:tmpweaponno]; i++)
                        {
                            [self addProjectile:[weaponmanager getProjectileTypeOfWeapon:tmpweaponno Projectile:i]
                                         XCoord:object.position.x-[weaponmanager getprojectileInitialX:tmpweaponno Projectile:i]
                                         YCoord:object.position.y-[weaponmanager getprojectileInitialY:tmpweaponno Projectile:i]
                                          Angle:[weaponmanager getProjectileAngle:tmpweaponno Projectile:i]
                                   AngleChanges:[weaponmanager getProjectileAngleChanges:tmpweaponno Projectile:i]
                                    AngleChange:[weaponmanager getProjectileAngleChange:tmpweaponno Projectile:i]
                                   IsDisappears:[weaponmanager getProjectileDisappears:tmpweaponno Projectile:i]
                                     TimeToLive:[weaponmanager getProjectileTTL:tmpweaponno Projectile:i]
                                         LockOn:[weaponmanager getLockOn:tmpweaponno]
                                     TargetType:0];
                        }
                        // 사운드 재생
                        [soundmanager playSound:[weaponmanager getSoundEffect:tmpweaponno]];
                        // 발사 완료. 다음번 발사까지 카운트 시작.
                        object.framestonextshot = [weaponmanager getFramesBetweenShoot:tmpweaponno];
//                        // [DEBUG]
//                        NSLog(@"Frames to next shot : %d", object.framestonextshot);
                        // 공격이 끝났는지 체크해본다 (정해진 탄을 다 쏘면 끝난 걸로 친다)
                        if (object.shootcount >= [weaponmanager getShootsPerAttack:tmpweaponno])
                        {
//                            // [DEBUG]
//                            NSLog(@"ATTACK IS ENDED");
                            // 끝났으면 공격을 멈추고 카운터를 리셋한다 (다음 공격까지 남은 시간을 돌린다)
                            object.isshooting = FALSE;
                            object.framestonextattack = [weaponmanager getFramesBetweenAttack:tmpweaponno];
                        }
                    }
                    // 다음 발사까지 1프레임 이상 남은 경우
                    else
                    {
                        // 다음 발사까지 남은 프레임 수를 1 줄인다
                        object.framestonextshot--;
//                        // [DEBUG]
//                        NSLog(@"Frames to next shot : %d", object.framestonextshot);
                    }
                }
                // 공격중이지 않은 경우
                else
                {
                    // 다음 공격까지 남은 프레임 수가 0이면 공격을 시작한다.
                    if (object.framestonextattack == 0)
                    {
                        //                    // [DEBUG]
                        //                    NSLog(@"ATTACK IS STARTED");
                        object.isshooting = TRUE;       // 발사중인 걸로 친다
                        object.shootcount = 0;          // 발사 횟수 초기화
                        object.framestonextshot = 0;    // 일단 첫 발은 딜레이 없이 다음 프레임에서 곧장 발사
                    }
                    // 그렇지 않다면
                    else
                    {
                        // 다음 공격까지 남은 프레임 수를 1 줄인다.
                        object.framestonextattack--;
                        //                    // [DEBUG]
                        //                    NSLog(@"Frames to next attack : %d", object.framestonextattack);
                    }
                }
            }        
        }
    }
    // 화면을 벗어난 것들은 삭제
//    // [DEBUG]
//    NSLog(@"Deleting objects.....");
    for (GameObject *object in objects_deleted)
    {
        [objects_targets removeObject:object];
        [objectlist removeChild:object cleanup:YES];
    }
}

- (void) updateProjectile1Status
{
//    // [DEBUG]
//    NSLog(@"Update Projectile1's status");

    // 임시 변수
    NSMutableArray *objects_deleted = [NSMutableArray array];   // 삭제 대상 목록
    
    // 모든 탄환을 대상으로
    for (GameObject *object in objects_projectiles1)
    {
        // 화면을 벗어났거나 슬슬 삭제될 타이밍인 탄환은 삭제한다
        if (object.position.y > size.height+(object.contentSize.height)||object.position.y < -1*(object.contentSize.height) ||
            object.position.x > size.width+(object.contentSize.height)||object.position.x < -1*(object.contentSize.height))
            [objects_deleted addObject:object];
        else if (object.isdisappears == TRUE && object.timetolive < 0)
            [objects_deleted addObject:object];
        // 그렇지 않은 경우에는 상태를 업데이트한다
        else
        {
            // [디버그용]
            projectilesinscreen++;

            // 이동 특성에 따라 이동 방향을 변경 (0:직진, 1:회전, 2:유도, 3:랜덤)
            switch (object.movementtype)
            {
                case 0:     // 직진 : 아무 일도 없음
                    break;
                case 1:     // 회전 : 각도를 변경시키고, 그 각도에 따라 이동속도를 바꾼다
                    object.angle += (object.angledifference*3.14/180);
                    [object setMovementX:sqrtf([projectilemanager getSpeed:object.objecttype])*sin(object.angle)];
                    [object setMovementY:-1*sqrtf([projectilemanager getSpeed:object.objecttype])*cos(object.angle)];
                    break;
                case 2:     // 유도 : 플레이어와의 방향에 맞춰서 각도를 변경시키고, 그 각도에 따라 이동속도를 바꾼다
                    object.angle -= (atan2f(object.position.x-object_PC.position.x, object.position.y-object_PC.position.y) * object.guidance/100 * 4/3 * 1/60);
                    [object setMovementX:sqrtf([projectilemanager getSpeed:object.objecttype])*sin(object.angle)];
                    [object setMovementY:-1*sqrtf([projectilemanager getSpeed:object.objecttype])*cos(object.angle)];
                    break;
                case 3:     // 랜덤 : 각도를 랜덤하게 변경시키고, 그 각도에 따라 이동속도를 바꾼다
                    object.angle += ((arc4random() % 180 - 90)*3.14/180);
                    [object setMovementX:sqrtf([projectilemanager getSpeed:object.objecttype])*sin(object.angle)];
                    [object setMovementY:-1*sqrtf([projectilemanager getSpeed:object.objecttype])*cos(object.angle)];
                    break;
                default:
                    break;
            }
            // 각도에 따라 탄환의 위치와 스프라이트 방향을 변경한다
            object.rotation = object.angle*180/3.14;
            object.position = ccpAdd(object.position, ccp(object.movementX,object.movementY));
            // 소멸까지 남은 시간 감소
            object.timetolive--;
        }
    }
    // 화면을 벗어난 것들은 삭제
//    // [DEBUG]
//    NSLog(@"Deleting objects.....");
    for (GameObject *object in objects_deleted)
    {
        [objects_projectiles1 removeObject:object];
        [objectlist removeChild:object cleanup:YES];
        // [디버그용]
        projectilesdeleted++;
//        // [DEBUG]
//        NSLog(@"Object deleted");
    }
}

- (void) updateProjectile2Status
{
//    // [DEBUG]
//    NSLog(@"Update Projectile2's status");

    // 임시 변수
    NSMutableArray *objects_deleted = [NSMutableArray array];   // 삭제 대상 목록
    
    // 모든 탄환을 대상으로
    for (GameObject *object in objects_projectiles2)
    {
        // 화면을 벗어났거나 슬슬 사라질 타이밍인 탄환은 삭제한다
        if (object.position.y > size.height+(object.contentSize.height)||object.position.y < -1*(object.contentSize.height) ||
            object.position.x > size.width+(object.contentSize.height)||object.position.x < -1*(object.contentSize.height))
            [objects_deleted addObject:object];
        else if (object.isdisappears == TRUE && object.timetolive < 0)
            [objects_deleted addObject:object];
        // 그렇지 않은 경우에는 상태를 업데이트한다
        else
        {
            // [디버그용]
            projectilesinscreen++;

            // 유도가 되는 경우(guidance가 0 이상일 경우)에는 이동 방향을 수정한다
            switch (object.movementtype)
            {
                case 0:     // 직진 : 아무 일도 없음
                    break;
                case 1:     // 회전 : 각도를 변경시키고, 그 각도에 따라 이동속도를 바꾼다
                    object.angle += (object.angledifference*3.14/180);
                    [object setMovementX:sqrtf([projectilemanager getSpeed:object.objecttype])*sin(-1*object.angle)];
                    [object setMovementY:sqrtf([projectilemanager getSpeed:object.objecttype])*cos(object.angle)];
                    break;
                case 2:     // 유도 : 아무 일도 없음 (플레이어는 유도탄 안쓴다)
                    break;
                case 3:     // 랜덤 : 각도를 랜덤하게 변경시키고, 그 각도에 따라 이동속도를 바꾼다
                    object.angle += ((arc4random() % 180 - 90)*3.14/180);
                    [object setMovementX:sqrtf([projectilemanager getSpeed:object.objecttype])*sin(object.angle)];
                    [object setMovementY:-1*sqrtf([projectilemanager getSpeed:object.objecttype])*cos(object.angle)];
                    break;
                default:
                    break;
            }
            // 각도에 따라 탄환의 위치와 스프라이트 방향을 변경한다
            object.rotation = object.angle*180/3.14;
            object.position = ccpAdd(object.position, ccp(object.movementX,object.movementY));
            // 소멸까지 남은 시간 감소
            object.timetolive--;
        }
    }
    // 화면을 벗어난 것들은 삭제
//    // [DEBUG]
//    NSLog(@"Deleting objects.....");
    for (GameObject *object in objects_deleted)
    {
        [objects_projectiles2 removeObject:object];
        [objectlist removeChild:object cleanup:YES];
        // [디버그용]
        projectilesdeleted++;
    }
}

- (void) updateItemStatus
{
    // 아이템 위치 업데이트 : (프레임당 1회)
    
    // 임시 변수
    NSMutableArray *objects_deleted = [NSMutableArray array];   // 삭제 대상 목록
    
    // 모든 아이템을 대상으로 처리
    for (GameObject *object in objects_items)
    {
        // 화면을 벗어났거나, 슬슬 삭제될 타이밍인 아이템들은 삭제한다
        if (object.position.y < -1*(object.contentSize.height) || object.position.x > size.width || object.position.x < 0)
            [objects_deleted addObject:object];
        else if (object.isdisappears == TRUE && object.timetolive <= 0)
            [objects_deleted addObject:object];
        // 그 외에는 상태를 업데이트한다
        else
        {
            // 아이템의 위치를 변경 (어차피 아이템은 위에서 아래로만 이동한다)
            object.position = ccpAdd(object.position, ccp(0,object.movementY));
            // 화면을 벗어난 아이템은 삭제한다
            if (object.position.y < size.width + object.contentSize.height)
                [objects_deleted addObject:object];
        }
    }
    // 화면을 벗어난 것들은 삭제
    for (GameObject *object in objects_deleted)
    {
        [objects_items removeObject:object];
        [objectlist removeChild:object cleanup:NO];
    }
}


- (void) onUpdate2:(ccTime)dt
{
    // 초당 1회씩 호출되는 것들
    
//    // [DEBUG]
//    NSLog(@"Seconds Elapsed : %d", [gamecore getElapsedTime]);
    // 현재 시간을 업데이트
    [gamecore addElapsedTime];

    // 점수 증가
    [gamecore addScore:[gamecore getElapsedTime]*10];
    // 화면에 점수 출력
    scorelabel2.string = [NSString stringWithFormat:@"%010d",[gamecore getScore]];
}

- (void) createTargets
{
    // 화면에 타겟을 출현시킴
    
    // 변수 선언
    NSInteger elapsedtime = [gamecore getElapsedTime];          // 현재 시간
    NSInteger registeredtargets = [enemymanager getDataCount];  // 사용 가능한 타겟 수
    NSInteger createdtargets;                                   // 타겟 생성 수
    // 변수 선언 (임시)
    NSInteger tmpTGTtype;   // (임시) 타겟 종류
    NSInteger tmpXcoord;    // (임시) 타겟 X좌표
    NSInteger tmpYcoord;    // (임시) 타겟 Y좌표
    CGSize tmpTGTsize;      // (임시) 타겟 크기
    
    // 현재 시간을 기준으로 타겟의 출현 수를 설정
    createdtargets = elapsedtime / 10 + 1;
    // 타겟 생성 후 등록
    for (int tmpcounter1 = 0; tmpcounter1 < createdtargets; tmpcounter1++)
    {
        // 타겟 유형을 결정한다
        tmpTGTtype = arc4random() % registeredtargets;
        // 타겟의 데이터 받아오기
        tmpTGTsize.height = 48;     // (테스트용 코드) : 타겟의 크기
        tmpTGTsize.width = 48;      // (테스트용 코드) : 타겟의 크기
        // 출현 위치 설정
        tmpXcoord = (arc4random() % ((NSInteger)(size.width-tmpTGTsize.width))) + (tmpTGTsize.width/2);
        tmpYcoord = size.height + (tmpTGTsize.height) + (arc4random()%(NSInteger)tmpTGTsize.height);
        // 생성 후 등록
        [self addTarget:tmpTGTtype XCoord:tmpXcoord YCoord:tmpYcoord];
    }
}


- (void) loadResources
{
    // 리소스 불러오기
}

- (void) addTarget:(NSInteger)tgtno XCoord:(NSInteger)xcoord YCoord:(NSInteger)ycoord
{
    // 타겟 생성
    GameObject* createdtarget = nil;
    // 이미지 로드
    // 해당하는 적의 스프라이트 번호를 받고(EnemyMgr), 그 스프라이트 번호에서 스프라이트 파일 이름을 확인한 후(SpriteMgr), 그걸 로드한다
    createdtarget = [GameObject spriteWithFile:[spritemanager getSpritePath:[enemymanager getSpriteNo:tgtno]]];
    // 정상적으로 생성되었으면
    if (createdtarget)
    {
        // 데이터 입력
        [createdtarget setObjectcategory:1];                                                // 적 캐릭터니까 카테고리는 1로 설정
        [createdtarget setObjecttype:tgtno];                                              // 타입은 입력받은 번호로 설정
        // 이 값들은 enemymanager에서 불러와서 사용
        [createdtarget setMovementtype:[enemymanager getMovementType:tgtno]];
        [createdtarget setMovementlevel:[enemymanager getMovementLevel:tgtno]];
        [createdtarget setSpeed:[enemymanager getSpeed:tgtno]];
        [createdtarget setTimeforwaiting:[enemymanager getTimeForWaiting:tgtno]];
        [createdtarget setIsindestructable:[enemymanager getIsIndestructable:tgtno]];
        [createdtarget setMaxHP:[enemymanager getMaxHP:tgtno]];
        [createdtarget setCurrentHP:[enemymanager getMaxHP:tgtno]];
        [createdtarget setStrikezoneX:[enemymanager getStrikeZoneX:tgtno]];
        [createdtarget setStrikezoneX:[enemymanager getStrikeZoneY:tgtno]];
        [createdtarget setStrikezoneW:[enemymanager getStrikeZoneW:tgtno]];
        [createdtarget setStrikezoneH:[enemymanager getStrikeZoneH:tgtno]];
        [createdtarget setWeaponno:[enemymanager getWeaponNo:tgtno]];
        [createdtarget setIsescapes:[enemymanager getIsEscapes:tgtno]];
        [createdtarget setDestination2:[enemymanager getDestination2:tgtno]];
        [createdtarget setIsdisappears:[enemymanager getIsDisappears:tgtno]];
        [createdtarget setTimetolive:[enemymanager getTimeToLive:tgtno]];
        // 공격 관련 값들 (초기화)
        [createdtarget setIsshooting:FALSE];
        [createdtarget setShootcount:0];
        [createdtarget setFramestonextshot:0];
        [createdtarget setFramestonextattack:0];
        // 테스트용 값
        [createdtarget setMovementY:sqrtf([enemymanager getSpeed:tgtno])];
        // 생성된 타겟을 추가
        [createdtarget setPosition:ccp(xcoord,ycoord)];     // 위치 설정
        [objectlist addChild:createdtarget z:15];           // 생성한 타겟을 objectlist에 추가
        [objects_targets addObject:createdtarget];          // 생성한 타겟을 배열에 추가 (object_targets)
        // [디버그용]
        targetscreated++;
    }
}

- (void) addProjectile:(NSInteger)projectileno XCoord:(NSInteger)xcoord YCoord:(NSInteger)ycoord
                 Angle:(CGFloat)angle AngleChanges:(BOOL)anglechanges AngleChange:(CGFloat)anglechange
          IsDisappears:(BOOL)isdisappears TimeToLive:(NSInteger)timetolive LockOn:(BOOL)lockon TargetType:(NSInteger)tgttype
{
    // 총알 생성
    GameObject* createdprojectile = nil;
    // 해당하는 총알의 스프라이트 번호를 받고(ProjectileMgr), 그 스프라이트 번호에서 스프라이트 파일 이름을 확인한 후(SpriteMgr), 그걸 로드한다
    createdprojectile = [GameObject spriteWithFile:[spritemanager getSpritePath:[projectilemanager getSpriteNo:projectileno]]];
    // 생성된 총알을 추가하는 부분
    if (createdprojectile)
    {
        // 데이터 입력
        [createdprojectile setObjectcategory:2];    // 데이터 입력
        [createdprojectile setTargettype:tgttype];  // 데이터 입력 (뭘 노리고 쐈는가)
        // 방향, 속도 입력 (총알의 기본 속도에다 각도의 sin값과 cos값을 곱해서 가로-세로 방향 속도를 계산한다)
        // 만약에 플레이어가 쏜 탄일 경우에는 좌우를 반전시킨다 (plist 상의 값은 적이 쏠 때가 기준이기 때문에 플레이어가 쏠 경우에는 방향을 반전시켜야 한다)
        [createdprojectile setAngle:angle];
        if (tgttype == 1)
        {
            [createdprojectile setMovementX:sqrtf([projectilemanager getSpeed:projectileno])*sin(angle*-3.14/180)];
            [createdprojectile setMovementY:sqrtf([projectilemanager getSpeed:projectileno])*cos(angle*3.14/180)];
        }
        else
        {
            // 조준되었는가의 여부에 따라 달라짐
            if (lockon == TRUE)
            {
                // 조준된 탄의 발사 각도는 설정된 발사 각도에다 플레이어와의 각도 차이를 뺀 만큼.
                CGFloat angle2 = atan2f(xcoord-object_PC.position.x, ycoord-object_PC.position.y)*180/3.14;
                [createdprojectile setMovementX:sqrtf([projectilemanager getSpeed:projectileno])*sin((angle-angle2)*3.14/180)];
                [createdprojectile setMovementY:-1*sqrtf([projectilemanager getSpeed:projectileno])*cos((angle-angle2)*3.14/180)];
            }
            else
            {
                [createdprojectile setMovementX:sqrtf([projectilemanager getSpeed:projectileno])*sin(angle*3.14/180)];
                [createdprojectile setMovementY:-1*sqrtf([projectilemanager getSpeed:projectileno])*cos(angle*3.14/180)];
            }
        }
        // 특성 설정
        if ([projectilemanager getGuidance:projectileno] > 0)   // 유도되는 탄일 경우
        {
            [createdprojectile setMovementtype:2];
            [createdprojectile setGuidance:[projectilemanager getGuidance:projectileno]];
            // 지나치게 유도성능이 높게 설정된 경우에는 좀 깎는다
            if ([projectilemanager getGuidance:projectileno] < 100)
                [createdprojectile setGuidance:100];
        }
        else if (anglechanges == 1)                             // 유도는 안 되는데 휘는 경우
        {
            [createdprojectile setMovementtype:1];
            [createdprojectile setAngledifference:anglechange];
        }
        // 소멸 시간 설정
        if (isdisappears == TRUE)
        {
            // 설정되어 있는 경우에는 설정된 값을 넣는다
            [createdprojectile setIsdisappears:TRUE];
            [createdprojectile setTimetolive:timetolive];
        }
        else
        {
            // 그냥 벗어나면 삭제시키려 했으나 기본값을 넣을수밖에 없다 (탄 패턴이 복잡해져서 자동으로 삭제 안시키면 대략 난감함)
            [createdprojectile setIsdisappears:TRUE];
            [createdprojectile setTimetolive:180];      // 대략 3초간 화면에서 버티는 걸로 한다
        }
        // 위치 설정 후 objectList에 추가.
        [createdprojectile setPosition:ccp(xcoord,ycoord)]; // 위치 설정
        [objectlist addChild:createdprojectile z:13];       // 생성한 총알을 objectlist에 추가
        // 생성한 총알을 배열에 추가 (타겟이 쏜 경우에는 projectiles1, 플레이어가 쏜 경우에는 projectiles2)
        if (tgttype == 1)   // (만약에 플레이어가 쐈다면)
            [objects_projectiles2 addObject:createdprojectile];  // 생성한 총알을 배열에 추가 (object_projectiles2)
        else
            [objects_projectiles1 addObject:createdprojectile];  // 생성한 총알을 배열에 추가 (object_projectiles1)
//        // [DEBUG]
//        NSLog(@"Object Created (type:%d, IsDisappears:%d, TTL:%d)", createdprojectile.objecttype, createdprojectile.isdisappears, createdprojectile.timetolive);
        // [디버그용]
        projectilescreated++;
    }
}

- (void) addItem:(NSInteger)itemno XCoord:(NSInteger)xcoord YCoord:(NSInteger)ycoord
{
    // 아이템 생성
    GameObject* createditem = nil;
    // 아이템 종류 확인
    // 이미지 로드
    // 데이터 입력
    [createditem setObjectcategory:3];          // 데이터 입력
    // 생성된 아이템을 추가
    if (createditem)
    {
        [createditem setPosition:ccp(xcoord,ycoord)];       // 위치 설정
        [objectlist addChild:createditem z:15];             // 생성한 타겟을 objectlist에 추가
        [objects_targets addObject:createditem];            // 생성한 타겟을 배열에 추가 (object_items)
    }
}

- (void) addExplosionEffectTo:(id)targetobject
{
    // 폭발 효과를 화면에다 표시
}

- (void) removeExplosionEffect:(id)targeteffect
{
    // 폭발 효과를 화면에서 제거
}

- (void) applyItemEffectToPlayer:(NSInteger)itemtype
{
    // 아이템의 효과를 플레이어에게 적용
}

- (void) deleteItemEffectToPlayer:(NSInteger)itemtype
{
    // 아이템의 효과를 플레이어에게서 해제
}

- (void) movePlayer:(CGPoint)pos
{
    // 플레이어를 해당하는 칸만큼 이동시킨다
    // 일단 위치를 조정하고
    [object_PC setPosition:ccpAdd(object_PC.position, pos)];
    // 화면 밖으로 안 나가도록 X좌표 조정
    if (object_PC.position.x > size.width - object_PC.contentSize.width/2)
        [object_PC setPosition:ccp(size.width-(object_PC.contentSize.width/2),object_PC.position.y)];
    else if (object_PC.position.x < object_PC.contentSize.width/2)
        [object_PC setPosition:ccp(object_PC.contentSize.width/2,object_PC.position.y)];
    // 화면 밖으로 안 나가도록 Y좌표 조정
    if (object_PC.position.y > size.height - object_PC.contentSize.height/2)
        [object_PC setPosition:ccp(object_PC.position.x,size.height-(object_PC.contentSize.height/2))];
    else if (object_PC.position.y < object_PC.contentSize.height/2)
        [object_PC setPosition:ccp(object_PC.position.x,object_PC.contentSize.height/2)];
}


- (void) scrollBG
{
    // 배경화면 스크롤
	CGFloat scrollspeed = 6.9;

    // 1번째 배경을 스크롤
	if (bg01.position.y - scrollspeed > -size.height)
        [bg01 setPosition:ccp(0, bg01.position.y - scrollspeed)];
	else
		[bg01 setPosition:ccp(0, size.height)];
    
    // 2번째 배경을 스크롤
    if (bg02.position.y - scrollspeed > -size.height)
		[bg02 setPosition:ccp(0, bg02.position.y - scrollspeed)];
	else
		[bg02 setPosition:ccp(0, size.height)];
}


// 가속도 센서 입력처리
#define DEFAULT_DECELERATION    (0.4f)
#define DEFAULT_SENSITIVITY1    (6.0F)  // 가로로 기울일 경우의 감도
#define DEFAULT_SENSITIVITY2    (4.0F)  // 세로로 기울일 경우의 감도
#define MAX_VELOCITY            (100)
-(void) accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration
{
	// 가속도계를 사용하여, 현재 기기가 얼마나 기울었는가를 체크한다.

    // 좌-우 이동은 가속도계의 x값으로
    playervelocity.x = playervelocity.x * DEFAULT_DECELERATION + acceleration.x * DEFAULT_SENSITIVITY1;
    // 상-하 이동은 가속도계의 y값으로
    playervelocity.y = playervelocity.y * DEFAULT_DECELERATION + acceleration.y * DEFAULT_SENSITIVITY2;

    // 플레이어 스프라이트의 최대 속도는 제한한다
    if (playervelocity.x > MAX_VELOCITY)
        playervelocity.x = MAX_VELOCITY;
    else if (playervelocity.x < -MAX_VELOCITY)
        playervelocity.x = -MAX_VELOCITY;
    if (playervelocity.y > MAX_VELOCITY)
        playervelocity.y = MAX_VELOCITY;
    else if (playervelocity.y < -MAX_VELOCITY)
        playervelocity.y = -MAX_VELOCITY;
}

// 터치 입력처리
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    
    // 버튼 입력여부는 해제한다
    shootbuttonispressed = NO;
    
    // 위치를 받고
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedlocation = [[CCDirector sharedDirector] convertToGL:location];

    if (CGRectContainsPoint(shootbutton_n.boundingBox, convertedlocation))
    {
        shootbutton_n.visible = FALSE;
        shootbuttonispressed = YES;
    }
}
- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
        shootbuttonispressed = NO;
        shootbutton_n.visible = TRUE;
}

// 저속 버튼 눌렀을 때의 처리
- (void) pressedSlowButton
{
}

// 발사 버튼 눌렀을 때의 처리
- (void) pressedShotButton
{
}

@end
