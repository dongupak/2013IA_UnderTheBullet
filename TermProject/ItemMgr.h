//
//  ItemManager.h
//  TermProject
//
//  Created by LYH on 13. 5. 22..
//
//

#import <Foundation/Foundation.h>

@interface ItemMgr : NSObject
{
    NSArray *data;   // 아이템 데이터를 담고 있는 배열
}

// 인스턴스 생성용
+ (ItemMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용될 함수
- (NSInteger) getDataCount;

- (NSInteger) getSpriteNo:(NSInteger)value;

@end
