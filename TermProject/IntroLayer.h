//
//  IntroLayer.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// 게임 진행에 관여
#import "GameCore.h"
#import "GameObject.h"
#import "EnemyMgr.h"
#import "WeaponMgr.h"
#import "ProjectileMgr.h"
#import "ItemMgr.h"
// 리소스 사용에 관여
#import "AnimationMgr.h"
#import "SpriteMgr.h"
#import "MusicMgr.h"
#import "SoundMgr.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    // 게임 제어용
    GameCore* gamecore;                     // 게임 총괄용 객체
    EnemyMgr* enemymanager;                 // 적 캐릭터 데이터 관리용 객체
    WeaponMgr* weaponmanager;               // 무기(그러니까 공격 패턴) 데이터 관리용 객체
    ProjectileMgr* projectilemanager;       // 탄환 데이터 관리용 객체
    ItemMgr* itemmanager;                   // 아이템 데이터 관리용 객체
    // 리소스 관리용
    AnimationMgr* animationmanager;         // 애니메이션 관련
    SpriteMgr* spritemanager;               // 스프라이트 관련
    MusicMgr* musicmanager;                 // BGM 관련
    SoundMgr* soundmanager;                 // 사운드 관련
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
