//
//  GameObject.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameObject : CCSprite {
    // 상태 (공통)
    BOOL iscollided;                // 충돌 여부
    BOOL isremoved;                 // 삭제 가능 여부 (판정 과정에서 삭제했을 경우 어떻게 될지 모르므로 해당 프레임이 끝나는 시점에서 삭제한다)
    NSInteger objectcategory;       // 개체 종류 (대분류 : 플레이어, 타겟, 탄환-타겟, 탄환-플레이어, 아이템)
    NSInteger objecttype;           // 개체 종류 (소분류 : 대분류 내에서의 유형)
    // 상태 (플레이어)
    BOOL isinvisible;               // 스텔스 여부 (플레이어 캐릭터에만 해당)
    BOOL isinvincible;              // 무적 여부 (플레이어 캐릭터에만 해당)
    BOOL effectactivated;           // 효과 적용 여부 (플레이어 캐릭터에만 해당)
    NSInteger effectno;             // 적용중인 효과 종류 (플레이어 캐릭터에만 해당)
    NSInteger effectremaining;      // 적용중인 효과 남은시간 (플레이어 캐릭터에만 해당)
    // 공격 관련 (플레이어, 타겟)
    BOOL isshooting;                // 공격 중인가 여부
    NSInteger weaponno;             // 무기 유형
    NSInteger shootcount;           // 발사 횟수 (1번 공격할 때마다)
    NSInteger framestonextshot;     // 다음 발사까지 남은 프레임수
    NSInteger framestonextattack;   // 다음 공격까지 남은 프레임수
    // 피격 판정 관련 (타겟)
    BOOL isindestructable;          // 파괴 가능 여부 (타겟 캐릭터에만 해당)
    NSInteger maxHP;                // 최대 HP
    NSInteger currentHP;            // 현재 HP
    NSInteger strikezoneX;          // 피격 판정 지점 (X)
    NSInteger strikezoneY;          // 피격 판정 지점 (Y)
    NSInteger strikezoneW;          // 피격 판정 지점 (가로)
    NSInteger strikezoneH;          // 피격 판정 지점 (세로)
    // 이동 특성 (타겟, 탄환)
    NSInteger speed;                // 이동속도 (100이 표준)
    CGFloat movementX;              // 이동속도 (X)
    CGFloat movementY;              // 이동속도 (Y)
    CGFloat angle;                  // 각도
    CGFloat angledifference;        // 각도 변화량
    // 이동 특성 (탄환)
    NSInteger movementtype;         // 이동 특성
    NSInteger movementlevel;        // 특성의 세기
    NSInteger targettype;           // 어느 타겟에 반응하는가 (충돌 시 이 객체의 targettype과 충돌한 객체의 objecttype이 일치할 경우 판정)
    NSInteger guidance;             // 유도성능 (0 이하일 경우 비유도)
    // 이동 특성 (타겟)
    BOOL isescapes;                 // 도망 여부
    NSInteger destinationX;         // 목적지 (X)
    NSInteger destinationY;         // 목적지 (Y)
    NSInteger timeforwaiting;       // 목적지 도착 후의 대기 시간
    float destination2;             // 도망갈 때의 방향 (각도 : 0~360)
    // 수명 특성 (타겟, 탄환)
    BOOL isdisappears;              // 시간이 지나면 소멸하는가 여부
    NSInteger timetolive;           // TTL (Time To Live, 소멸할 때까지 남은 시간)
}

@property(readwrite) BOOL iscollided;
@property(readwrite) BOOL isremoved;
@property(readwrite) NSInteger objectcategory;
@property(readwrite) NSInteger objecttype;
@property(readwrite) BOOL isinvisible;
@property(readwrite) BOOL isinvincible;
@property(readwrite) BOOL effectactiavated;
@property(readwrite) NSInteger effectno;
@property(readwrite) NSInteger effectremaining;
@property(readwrite) BOOL isshooting;
@property(readwrite) NSInteger weaponno;
@property(readwrite) NSInteger shootcount;
@property(readwrite) NSInteger framestonextshot;
@property(readwrite) NSInteger framestonextattack;
@property(readwrite) BOOL isindestructable;
@property(readwrite) NSInteger maxHP;
@property(readwrite) NSInteger currentHP;
@property(readwrite) NSInteger strikezoneX;
@property(readwrite) NSInteger strikezoneY;
@property(readwrite) NSInteger strikezoneW;
@property(readwrite) NSInteger strikezoneH;
@property(readwrite) NSInteger speed;
@property(readwrite) CGFloat movementX;
@property(readwrite) CGFloat movementY;
@property(readwrite) CGFloat angle;
@property(readwrite) CGFloat angledifference;
@property(readwrite) NSInteger movementtype;
@property(readwrite) NSInteger movementlevel;
@property(readwrite) NSInteger targettype;
@property(readwrite) NSInteger guidance;
@property(readwrite) BOOL isescapes;
@property(readwrite) NSInteger destinationX;
@property(readwrite) NSInteger destinationY;
@property(readwrite) NSInteger timeforwaiting;
@property(readwrite) float destination2;
@property(readwrite) BOOL isdisappears;
@property(readwrite) NSInteger timetolive;

@end
