//
//  FightFectory.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/10.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "FightFectory.h"

@implementation FightFectory

+ (Fight *)createFightWithFightEndTime:(NSString *)fightEndTime fightId:(NSString *)fightId fightMessage:(NSString *)fightMessage fightStatus:(NSString *)fightStatus fightNumberType:(NSString *)fightNumberType fightStartTime:(NSString *)fightStartTime fightPauseTime:(NSString *)fightPauseTime fightPauseSpace:(NSString *)fightPauseSpace fightType:(NSString *)fightType fightGround:(NSString *)fightGround fightName:(NSString *)fightName fightImg:(NSString *)fightImg fightVideo:(NSString *)fightVideo signImg:(NSString *)signImg refrees:(NSMutableArray<Refree *> *)refrees teams:(NSMutableArray<Team *> *)teams events:(NSMutableArray<Event *> *)events{
    
    Fight *fight = [[Fight alloc]init];
    fight.fightEndTime = fightEndTime;
    fight.fightId = fightId;
    fight.fightMessage = fightMessage;
    fight.fightStatus = fightStatus;
    fight.fightNumberType = fightNumberType;
    fight.fightStartTime = fightStartTime;
    fight.fightPauseTime = fightPauseTime;
    fight.fightPauseSpace = fightPauseSpace;
    fight.fightType = fightType;
    fight.fightGround = fightGround;
    fight.fightName = fightName;
    fight.fightImg = fightImg;
    fight.fightVideo = fightVideo;
    fight.refrees = refrees;
    fight.teams = teams;
    fight.events = events;
    fight.signImg = signImg;
    return fight;
}

+ (Refree *)createRefreeWithRefreeId:(NSString *)refreeId refreeName:(NSString *)refreeName refreeImg:(NSString *)refreeImg {
    Refree *refree = [[Refree alloc]init];
    refree.refreeId = refreeId;
    refree.refreeName = refreeName;
    refree.refreeImg = refreeImg;
    return refree;
}

+ (Team *)createTeamWithIsHostTeam:(NSString *)isHostTeam teamColor:(NSString *)teamColor teamId:(NSString *)teamId teamMessage:(NSString *)teamMessage teamName:(NSString *)teamName score:(NSString *)score clothes:(NSString *)clothes teamSignImg:(NSString *)teamSignImg teamRedcard:(NSString *)redcard teamYellowcard:(NSString *)yellowcard substitution:(NSString *)substitution teamImg:(NSString *)teamImg formations:(NSMutableArray<Formation *> *)formations leaders:(NSMutableArray<Leader *> *)leaders coachs:(NSMutableArray<Coach *> *)coachs players:(NSMutableArray<Player *> *)players {
    Team *team = [[Team alloc]init];
    team.isHostTeam = isHostTeam;
    team.teamColor = teamColor;
    team.teamId = teamId;
    team.teamMessage = teamMessage;
    team.teamName = teamName;
    team.score = score;
    team.clothes = clothes;
    team.formations = formations;
    team.leaders = leaders;
    team.coachs = coachs;
    team.players = players;
    team.teamRedcard = redcard;
    team.teamYellowcard = yellowcard;
    team.teamSubstitution = substitution;
    team.teamImg = teamImg;
    team.teamSignImg = teamSignImg;
    return team;
}

+ (Formation *)createFormationWithFormationId:(NSString *)formationId formationStartTime:(NSString *)formationStartTime formationEndTime:(NSString *)formationEndTime formationName:(NSString *)formationName formationImg:(NSString *)formationImg mainPlayers:(NSMutableArray<MainPlayer *> *)mainPlayers {
    Formation *formation = [[Formation alloc]init];
    formation.formationId = formationId;
    formation.formationStartTime = formationStartTime;
    formation.formationEndTime = formationEndTime;
    formation.formationName = formationName;
    formation.formationImg = formationImg;
    formation.mainPlayers = mainPlayers;
    return formation;
}

+ (MainPlayer *)createMainPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate {
    MainPlayer *mainPlayer = [[MainPlayer alloc]init];
    mainPlayer.isCaptain = isCaptain;
    mainPlayer.isGoalkeeper = isGoalkeeper;
    mainPlayer.isStart = isStart;
    mainPlayer.playerId = playerId;
    mainPlayer.teamId = teamId;
    mainPlayer.playerName = playerName;
    mainPlayer.playerImg = playerImg;
    mainPlayer.clothesNumber = clothesNumber;
    mainPlayer.yellowcard = yellowcard;
    mainPlayer.redcard = redcard;
    mainPlayer.goldCount = goldCount;
    mainPlayer.assistCount = assistCount;
    mainPlayer.position = position;
    mainPlayer.playingTime = playingTime;
    mainPlayer.saveCount = saveCount;
    mainPlayer.coordinate = coordinate;
    return mainPlayer;
}

+ (Coordinate *)createCoordinateWithX:(NSString *)coordinateX Y:(NSString *)coordinateY Z:(NSString *)coordinateZ {
    Coordinate *coordinate = [[Coordinate alloc]init];
    coordinate.coordinateX = coordinateX;
    coordinate.coordinateY = coordinateY;
    coordinate.coordinateZ = coordinateZ;
    return coordinate;
}

+ (Leader *)createLeaderWithLeaderId:(NSString *)leaderId leaderName:(NSString *)leaderName leaderImg:(NSString *)leaderImg {
    Leader *leader = [[Leader alloc]init];
    leader.leader = leaderId;
    leader.leaderImg = leaderImg;
    leader.leaderName = leaderName;
    return leader;
}

+ (Coach *)createCoachWithCoachId:(NSString *)coachId coachType:(NSString *)coachType coachName:(NSString *)coachName coachImg:(NSString *)coachImg {
    Coach *coach = [[Coach alloc]init];
    coach.coachId = coachId;
    coach.coachType = coachType;
    coach.coachName = coachName;
    coach.coachImg = coachImg;
    return coach;
}

+ (Player *)createPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate {
    Player *player = [[Player alloc]init];
    player.isCaptain = isCaptain;
    player.isGoalkeeper = isGoalkeeper;
    player.isStart = isStart;
    player.playerId = playerId;
    player.teamId = teamId;
    player.playerName = playerName;
    player.playerImg = playerImg;
    player.clothesNumber = clothesNumber;
    player.yellowcard = yellowcard;
    player.redcard = redcard;
    player.goldCount = goldCount;
    player.assistCount = assistCount;
    player.position = position;
    player.playingTime = playingTime;
    player.saveCount = saveCount;
    player.coordinate = coordinate;
    return player;
}

+ (Event *)createEventWithEventTypeId:(NSString *)eventTypeId eventId:(NSString *)eventId teamId:(NSString *)teamId eventTeamId:(NSString *)eventTeamId eventTypeName:(NSString *)eventTypeName matchTime:(NSString *)matchTime eventTime:(NSString *)eventTime eventMessage:(NSString *)eventMessage eventImg:(NSString *)eventImg eventVideo:(NSString *)eventVideo eventHostFormation:(EventFormation *)eventHostFormation eventGuestFormation:(EventFormation *)eventGuestFormation eventPlayers:(NSMutableArray<EventPlayer *> *)eventPlayers {
    Event *event = [[Event alloc] init];
    event.eventTypeId = eventTypeId;
    event.eventId = eventId;
    event.teamId = teamId;
    event.eventTypeName = eventTypeName;
    event.matchTime = matchTime;
    event.eventTime = eventTime;
    event.eventMessage = eventMessage;
    event.eventImg = eventImg;
    event.eventVideo = eventVideo;
    event.eventHostFormation = eventHostFormation;
    event.eventGuestFormation = eventGuestFormation;
    event.eventPlayers = eventPlayers;
    return event;
}

+ (EventPlayer *)createEventPlayerWithIsCaptain:(NSString *)isCaptain isGoalkeeper:(NSString *)isGoalkeeper isStart:(NSString *)isStart playerId:(NSString *)playerId teamId:(NSString *)teamId playerName:(NSString *)playerName playerImg:(NSString *)playerImg clothesNumber:(NSString *)clothesNumber yellowcard:(NSString *)yellowcard redcard:(NSString *)redcard goldCount:(NSString *)goldCount assistCount:(NSString *)assistCount position:(NSString *)position playingTime:(NSString *)playingTime saveCount:(NSString *)saveCount coordinate:(Coordinate *)coordinate {
    EventPlayer *eventPlayer = [[EventPlayer alloc]init];
    eventPlayer.isCaptain = isCaptain;
    eventPlayer.isGoalkeeper = isGoalkeeper;
    eventPlayer.isStart = isStart;
    eventPlayer.playerId = playerId;
    eventPlayer.teamId = teamId;
    eventPlayer.playerName = playerName;
    eventPlayer.playerImg = playerImg;
    eventPlayer.clothesNumber = clothesNumber;
    eventPlayer.yellowcard = yellowcard;
    eventPlayer.redcard = redcard;
    eventPlayer.goldCount = goldCount;
    eventPlayer.assistCount = assistCount;
    eventPlayer.position = position;
    eventPlayer.playingTime = playingTime;
    eventPlayer.saveCount = saveCount;
    eventPlayer.coordinate = coordinate;
    return eventPlayer;
}

@end
