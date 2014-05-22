//
//  AnimationMgr.h
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import <Foundation/Foundation.h>

@interface AnimationMgr : NSObject
{
    NSArray *data;   // CCAnimation 목록
}

// 인스턴스 생성용
+ (AnimationMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용되는 함수
- (NSInteger) getListSize;

@end