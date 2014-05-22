//
//  SoundMgr.h
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import <Foundation/Foundation.h>

#import "SimpleAudioEngine.h"


@interface SoundMgr : NSObject
{
    NSArray *data;   // 사운드 목록
    SimpleAudioEngine *sae;
}

// 인스턴스 생성용
+ (SoundMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용되는 함수
- (NSInteger) getListSize;
- (NSInteger) playSound:(NSInteger)soundno;

@end
