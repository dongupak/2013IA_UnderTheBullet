//
//  ProjectileManager.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#import <Foundation/Foundation.h>

@interface ProjectileMgr : NSObject
{
    NSArray *data;   // 탄환 데이터를 담고 있는 배열
}

// 인스턴스 생성용
+ (ProjectileMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용될 함수
- (NSInteger) getDataCount;

- (NSInteger) getSpriteNo:(NSInteger)projectileno;
- (NSInteger) getSpeed:(NSInteger)projectileno;
- (NSInteger) getGuidance:(NSInteger)projectileno;
- (NSInteger) getBaseDamage:(NSInteger)projectileno;

@end
