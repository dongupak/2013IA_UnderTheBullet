//
//  MusicMgr.h
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import <Foundation/Foundation.h>

@interface MusicMgr : NSObject
{
    NSArray *data;   // BGM 목록
}

// 인스턴스 생성용
+ (MusicMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용되는 함수
- (NSInteger) getListSize;
- (NSString*) getBGMPath:(NSInteger)bgmno;

@end
