//
//  ResultLayer.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// 게임 진행용
#import "GameCore.h"
// 리소스 관련
#import "MusicMgr.h"
#import "SoundMgr.h"

// ResultLayer
@interface ResultLayer : CCLayerColor
{
    // 화면 관련
    CGSize size;                            // 화면 크기
    // BGM
    SimpleAudioEngine   *sae;               // Audio Engine
    // 제어용 객체
    GameCore* gamecore;                     // Game Core
    // 리소스 관련
    MusicMgr* musicmanager;                 // BGM 관련
    SoundMgr* soundmanager;                 // 사운드 관련
    // 배경화면
    CCSprite* bg01;                         // 배경 (1/2)
    CCSprite* bg02;                         // 배경 (2/2)
}

// returns a CCScene that contains the ResultLayer as the only child
+(CCScene *) scene;

@end
