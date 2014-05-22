//
//  EnemyManager.h
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#import <Foundation/Foundation.h>

@interface EnemyMgr : NSObject
{
    NSArray *data;   // 적기 데이터를 담고 있는 배열
}

// 인스턴스 생성용
+ (EnemyMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용될 함수
- (NSInteger) getDataCount;

- (NSInteger) getSpriteNo:(NSInteger)enemyno;
- (NSInteger) getBaseScore:(NSInteger)enemyno;
- (NSInteger) getMovementType:(NSInteger)enemyno;
- (NSInteger) getMovementLevel:(NSInteger)enemyno;
- (NSInteger) getSpeed:(NSInteger)enemyno;
- (NSInteger) getTimeForWaiting:(NSInteger)enemyno;
- (BOOL) getIsIndestructable:(NSInteger)enemyno;
- (NSInteger) getMaxHP:(NSInteger)enemyno;
- (NSInteger) getStrikeZoneX:(NSInteger)enemyno;
- (NSInteger) getStrikeZoneY:(NSInteger)enemyno;
- (NSInteger) getStrikeZoneW:(NSInteger)enemyno;
- (NSInteger) getStrikeZoneH:(NSInteger)enemyno;
- (NSInteger) getWeaponNo:(NSInteger)enemyno;
- (BOOL) getIsEscapes:(NSInteger)enemyno;
- (NSInteger) getDestination2:(NSInteger)enemyno;
- (BOOL) getIsDisappears:(NSInteger)enemyno;
- (NSInteger) getTimeToLive:(NSInteger)enemyno;

@end
