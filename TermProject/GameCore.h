//
//  GameCore.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#ifndef _GAMECORE_
#define _GAMECORE_

#import <Foundation/Foundation.h>

@interface GameCore : NSObject
{
    // 점수 관련
    NSInteger score;
    NSInteger highscore;
    NSInteger destroyedtgts;
    // 시간 관련
    NSInteger elapsedframe;
    NSInteger elapsedtime;
    // 게임 설정 관련
    BOOL vibrationisenabled;
}

// 인스턴스 생성용
+ (GameCore *) sharedInstance;

// 게임 설정 저장, 불러오기
- (void) loadGameSettings;
- (void) saveGameSettings;
// 게임 상태 초기화
- (void) initGameStatus;

// 게임 상에서 사용될 것들 (점수 관련)
- (NSInteger) getScore;
- (void) addScore:(NSInteger)value;
- (NSInteger) getHighScore;
- (void) setHighScore:(NSInteger)value;
- (NSInteger) getDestroyedTGT;
- (void) addDestroyedTGT:(NSInteger)tgttype;
// 게임 상에서 사용될 것들 (시간 관련)
- (NSInteger) getElapsedFrame;
- (void) addElapsedFrame;
- (NSInteger) getElapsedTime;
- (void) addElapsedTime;

// 게임 설정 관련
- (BOOL) getVibrationIsEnabled;
- (void) enableVibration:(BOOL)value;

@end

#endif