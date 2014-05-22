//
//  GameLayer.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// BGM 관련
#import "SimpleAudioEngine.h"

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

// GameLayer
@interface GameLayer : CCLayerColor
{
    // 화면 크기
    CGSize size;
    // BGM
    SimpleAudioEngine   *sae;               // Audio Engine
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
    // 오브젝트(플레이어,타겟,탄환,아이템) 목록
    CCNode* objectlist;                     // 전체
    // 종류별
    GameObject* object_PC;                  // 플레이어
    NSMutableArray *objects_targets;        // 타겟
    NSMutableArray *objects_projectiles1;   // 탄환 (적이 쏜 탄환)
    NSMutableArray *objects_projectiles2;   // 탄환 (적이 쏜 탄환)
    NSMutableArray *objects_items;          // 아이템
    // 그 외
    CCNode* effects;                        // 이펙트 목록
    // 게임 상태 관련
    CGPoint playervelocity;                 // 플레이어의 이동 속도

    // 배경화면
    CCSprite* bg01;                         // 배경 (1/2)
    CCSprite* bg02;                         // 배경 (2/2)
    // 스코어 출력용
    CCLabelTTF* scorelabel1;
    CCLabelTTF* scorelabel2;
    CCLabelTTF* timelabel1;
    CCLabelTTF* timelabel2;
    // 조작용
    CCSprite* shootbutton_n;                  // 발사 버튼
    CCSprite* shootbutton_s;                  // 발사 버튼 (눌렀을 때)
    BOOL shootbuttonispressed;
    // 디버그용
    NSInteger projectilescreated;           // 생성된 탄환 수
    NSInteger projectilesdeleted;           // 삭제된 탄환 수
    NSInteger projectilesinscreen;          // 화면에 있는 탄환 수
    CCLabelTTF* debuglabel1;
    CCLabelTTF* debuglabel2;
    CCLabelTTF* debuglabel3;
    NSInteger targetscreated;               // 생성된 탄환 수
    NSInteger targetsdeleted;               // 삭제된 타겟 수
    NSInteger targetsinscreen;              // 화면에 있는 타겟 수
    CCLabelTTF* debuglabel4;
    CCLabelTTF* debuglabel5;
    CCLabelTTF* debuglabel6;
}

@property (nonatomic,retain) NSMutableArray *objects_targets;
@property (nonatomic,retain) NSMutableArray *objects_projectiles1;
@property (nonatomic,retain) NSMutableArray *objects_projectiles2;
@property (nonatomic,retain) NSMutableArray *objects_items;

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

@end
