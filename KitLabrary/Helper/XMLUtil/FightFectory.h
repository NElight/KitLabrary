//
//  FightFectory.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/10.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coach.h"
#import "Coordinate.h"
#import "event.h"
#import "EventPlayer.h"
#import "Fight.h"
#import "Formation.h"
#import "Leader.h"
#import "MainPlayer.h"
#import "Player.h"
#import "Refree.h"
#import "RootClass.h"
#import "Team.h"
#import "EventFormation.h"

//生成fight中各种事件的方法
@interface FightFectory : NSObject

+ (Fight *)createFightWithFightEndTime:(NSString *)fightEndTime fightId:(NSString *)fightId fightMessage:(NSString *)fightMessage fightStatus:(NSString *)fightStatus fightNumberType:(NSString *)fightNumberType fightStartTime:(NSString *)fightStartTime fightPauseTime:(NSString *)fightPauseTime fightPauseSpace:(NSString *)fightPauseSpace fightType:(NSString *)fightType fightGround:(NSString *)fightGround fightName:(NSString *)fightName fightImg:(NSString *)fightImg fightVideo:(NSString *)fightVideo signImg:(NSString *)signImg refrees:(NSMutableArray<Refree *> *)refrees teams:(NSMutableArray<Team *> *)teams events:(NSMutableArray<Event *> *)events;

+ (Refree *)createRefreeWithRefreeId:(NSString *)refreeId refreeName:(NSString *)refreeName refreeImg:(NSString *)refreeImg;

+ (Team *)createTeamWithIsHostTeam:(NSString *)isHostTeam teamColor:(NSString *)teamColor teamId:(NSString *)teamId teamMessage:(NSString *)teamMessage teamName:(NSString *)teamName score:(NSString *)score clothes:(NSString *)clothes teamSignImg:(NSString *)teamSignImg teamRedcard:(NSString *)redcard teamYellowcard:(NSString *)yellowcard substitution:(NSString *)substitution teamImg:(NSString *)teamImg formations:(NSMutableArray<Formation *> *)formations leaders:(NSMutableArray<Leader *> *)leaders coachs:(NSMutableArray<Coach *> *)coachs players:(NSMutableArray<Player *> *)players;

+ (Formation *)createFormationWithFormationId:(NSString *)formationId formationStartTime:(NSString *)formationStartTime formationEndTime:(NSString *)formationEndTime formationName:(NSString *)formationName formationImg:(NSString *)formationImg mainPlayers:(NSMutableArray<MainPlayer *> *)mainPlayers;

+ (MainPlayer *)createMainPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate;

+ (Coordinate *)createCoordinateWithX:(NSString *)coordinateX Y:(NSString *)coordinateY Z:(NSString *)coordinateZ;

+ (Leader *)createLeaderWithLeaderId:(NSString *)leaderId leaderName:(NSString *)leaderName leaderImg:(NSString *)leaderImg;

+ (Coach *)createCoachWithCoachId:(NSString *)coachId coachType:(NSString *)coachType coachName:(NSString *)coachName coachImg:(NSString *)coachImg;

+ (Player *)createPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate;

+ (Event *)createEventWithEventTypeId:(NSString *)eventTypeId eventId:(NSString *)eventId teamId:(NSString *)teamId eventTeamId:(NSString *)eventTeamId eventTypeName:(NSString *)eventTypeName matchTime:(NSString *)matchTime eventTime:(NSString *)eventTime eventMessage:(NSString *)eventMessage eventImg:(NSString *)eventImg eventVideo:(NSString *)eventVideo eventHostFormation:(EventFormation *)eventHostFormation eventGuestFormation:(EventFormation *)eventGuestFormation eventPlayers:(NSMutableArray<EventPlayer *> *)eventPlayers;

+ (EventPlayer *)createEventPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate;

@end
