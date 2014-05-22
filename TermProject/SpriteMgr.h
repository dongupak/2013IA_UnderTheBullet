//
//  SpriteMgr.h
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import <Foundation/Foundation.h>

@interface SpriteMgr : NSObject
{
    NSArray *data;   // CCSprite 목록
}

// 인스턴스 생성용
+ (SpriteMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용되는 함수
- (NSInteger) getListSize;
- (NSString*) getSpritePath:(NSInteger)spriteno;

@end
