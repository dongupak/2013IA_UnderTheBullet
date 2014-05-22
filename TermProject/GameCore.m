//
//  GameCore.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#import "GameCore.h"

@implementation GameCore

// 싱글턴이니까
static GameCore *sharedInstance = nil;
+ (GameCore *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init GameCore");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

// 게임 설정 저장, 불러오기
- (void) loadGameSettings
{
    // 설정을 불러온 후의 작업
    // 1) 진동 여부를 체크해서 진동이 불가능한 기기일 경우에는 진동 여부를 NO로 설정
}
- (void) saveGameSettings
{
}
// 게임 설정 관련
-(BOOL) getVibrationIsEnabled {return vibrationisenabled;}
- (void) enableVibration:(BOOL)value {self->vibrationisenabled = value;}

// 게임 상태 초기화
- (void) initGameStatus
{
    score = 0;
    destroyedtgts = 0;
    elapsedframe = 0;
    elapsedtime = 0;
}
// 게임 상에서 호출될 함수 (점수 관련)
- (NSInteger) getScore {return self->score;}
- (void) addScore:(NSInteger)value {self->score += value;}
- (NSInteger) getHighScore {return self->highscore;}
- (void) setHighScore:(NSInteger)value {self->highscore = value;}
- (NSInteger) getDestroyedTGT {return self->destroyedtgts;}
- (void) addDestroyedTGT:(NSInteger)tgttype
{
    // 유효한 타겟인지 체크
    // 유효할 경우 해당 타겟의 점수를 추가 후 격파수에 +1
}
// 게임 상에서 호출될 함수 (시간 관련)
- (NSInteger) getElapsedFrame {return self->elapsedframe;}
- (void) addElapsedFrame {self->elapsedframe++;}
- (NSInteger) getElapsedTime {return self->elapsedtime;}
- (void) addElapsedTime {self->elapsedtime++;}

@end
