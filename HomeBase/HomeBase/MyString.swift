//
//  MyString.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 23..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation
extension String {
    // title
    static let alertTitleOfEditTeamImage = NSLocalizedString(
        "팀 이미지 변경",
        comment: "Edit Team Image Alert Title")
    static let alertTitleOfEditTeamInfo = NSLocalizedString(
        "팀 정보 수정",
        comment: "Edit Team Info Alert Title")
    static let alertTitleOfEditSchedule = NSLocalizedString(
        "일정 수정",
        comment: "Edit Schedule Alert Title")
    static let alertTitleOfAddSchedule = NSLocalizedString(
        "일정 추가",
        comment: "Add Schedule Alert Title")
    static let alertTitleOfAddPlayer = NSLocalizedString(
        "선수 추가",
        comment: "Add Player Alert Title")
    static let alertTitleOfEditPlayer = NSLocalizedString(
        "선수 수정",
        comment: "Edit Player Alert Title")
    static let alertTitleOfDeletePlayer = NSLocalizedString(
        "선수 삭제",
        comment: "Delete Player Alert Title")
    
    static let alertTitleOfEnterResult = NSLocalizedString(
        "결과 입력",
        comment: "Enter Score Alert Title")
    static let alertTitleOfPitcherButton = NSLocalizedString(
        "팀 대표 이미지를 등록하세요",
        comment: "Picker Button Title")
    static let deleteActionTitle = NSLocalizedString(
        "삭제",
        comment: "Delete Action Title")
    
    static let cancelActionTitle = NSLocalizedString(
        "취소",
        comment: "Cancel Action Title")
    static let confirmActionTitle = NSLocalizedString(
        "확인",
        comment: "Confirm Action Title")
    static let alertActionTitle = NSLocalizedString(
        "경고",
        comment: "Alert Action Title")
    static let doneButtonTitle = NSLocalizedString(
        "완료",
        comment: "Done Button Title")
    static let editButtonTitle = NSLocalizedString(
        "수정",
        comment: "Edit Button Title")

    
    // message
    
    static let alertMessageOfShortageTeamName = NSLocalizedString(
        "팀 명은 최소 2글자 입니다",
        comment: "Shortage team name alert message")
    static let alertMessageOfAbundanceTeamName = NSLocalizedString(
        "팀 명은 최대 10글자 입니다",
        comment: "Abundance team name alert message")
    
    
    static let alertMessageOfEditTeamImage = NSLocalizedString(
        "변경된 이미지를 적용하려면 Done을 누르세요",
        comment: "Edit Team Image Alert Message")
    
    
    static let alertMessageOfEditTeamInfo = NSLocalizedString(
        "팀 정보를 수정하시겠습니까?",
        comment: "Edit Team Info Alert Message")
    
    static let startMessage = NSLocalizedString(
        "HomeBase를 시작하시겠습니까?",
        comment: "Start Message")
    static let alertMessageOfDeleteSchedule = NSLocalizedString(
        "일정을 삭제하시겠습니까?",
        comment: "Delete Schedule Alert Maessage")
    static let alertMessageOfEnterOpponentTeamName = NSLocalizedString(
        "상대 팀명을 입력하세요",
        comment: "Enter Opponent Team Name Alert Message")
    static let alertMessageOfEnterPlaceToMatch = NSLocalizedString(
        "경기 장소를 입력하세요",
        comment: "Enter Place to Match Alert Message")
    static let alertMessageOfEditMatchSchedule = NSLocalizedString(
        "경기를 수정하시겠습니까?",
        comment: "Edit Match Schedule Alert Message")
    static let alertMessageOfAddSchedule = NSLocalizedString(
        "경기를 추가하시겠습니까?",
        comment: "Add Schedule Alert Message")
    static let alertMessageOfEditPlayer = NSLocalizedString(
        "선수 정보를 수정하시겠습니까?",
        comment: "Edit Player Alert Message")
    static let alertMessageOfAddPlayer = NSLocalizedString(
        "선수 정보를 추가하시겠습니까?",
        comment: "Add Player Alert Message")
    static let alertMessageOfDeletePlayer = NSLocalizedString(
        "선수 정보를 삭제하시겠습니까?",
        comment: "Delete Player Alert Message")
    static let alertMessageOfEnterPlayerName = NSLocalizedString(
        "선수 이름을 입력하세요",
        comment: "Enter Player Name Alert Message")
    static let alertMessageOfEnterPlayerBackNumber = NSLocalizedString(
        "선수 번호를 입력하세요",
        comment: "Enter Player Back Number Alert Message")
    static let alertMessageOfDuplicatePlayerBackNumber = NSLocalizedString(
        "팀에 중복되는 번호가 있습니다",
        comment: "Duplicate Player Back Number Alert Message")
    static let alertMessageOfMaxPlayerBackNumber = NSLocalizedString(
        "선수 번호는 최대 99 입니다",
        comment: "Max Player Back Number Alert Message")
    
    
    
    
    
    static let alertMessageOfEnterHomeTeamScore = NSLocalizedString(
        "홈 팀 점수를 입력하세요",
        comment: "Enter Home Team Score Alert Message")
    static let alertMessageOfEnterOpponetTeamScore = NSLocalizedString(
        "원정 팀 점수를 입력하세요",
        comment: "Enter Opponent Team Score Alert Message")
    static let alertMessageOfEnterMatchResultFirst = NSLocalizedString(
        "경기 결과를 먼저 입력하세요",
        comment: "Enter Match Result First Alert Message")
    static let alertMessageOfInitializeBatterRecord = NSLocalizedString(
        "타자 기록이 초기화 되어야 합니다",
        comment: "Initialize The Batter Record Alert Message")
    static let alertMessageOfInitializePitcherRecord = NSLocalizedString(
        "투수 기록이 초기화 되어야 합니다",
        comment: "Initialize The Pitcher Record Alert Message")
    
    
    
    // placeholder
    static let nameTextFieldPlaceholder = NSLocalizedString(
        "팀 이름을 등록하세요 (2 - 10자)",
        comment: "Team name textfield placeholder")
    static let resultTextField =  NSLocalizedString(
        "%d승 %d무 %d패",
        comment: "Result TextField")

    static let matchAlarmDay = NSLocalizedString(
        "경기 시작 %d 일 전입니다",
        comment: "Match Alarm Before Day")
    static let matchAlarmHour = NSLocalizedString(
        "경기 시작 %d 시간 전입니다",
        comment: "Match Alarm Before Hour")
    static let matchAlarmMinute = NSLocalizedString(
        "경기 시작 %d 분 전입니다",
        comment: "Match Alarm Before Minute")
    static let atBatAndHit = NSLocalizedString(
        "%d타수 %d안타",
        comment: "At Bat And Hit")
    static let inningAndER = NSLocalizedString(
        "%d이닝 %d자책",
        comment: "Inning And ER")
    static let threeInningAndER = NSLocalizedString(
        "%d %d/3이닝 %d자책",
        comment: "/3Inning And ER")
    
    // Section
    
    static let firstSectionTitle = NSLocalizedString(
        "최근 경기",
        comment: "Current Sechedule Section Title")
    
    static let secondSectionTitle = NSLocalizedString(
        "타율 Top 3",
        comment: "Top 3 Batting Average")
    
    
    static let thirdSectionTitle = NSLocalizedString(
        "방어율 Top 3",
        comment: "Top 3 ERA Section Title")

    // label
    static let appearance = NSLocalizedString(
        "경기 수", comment: "Appearance")
    static let battingAVG = NSLocalizedString(
        "타율", comment: "Batting AVG")
    static let batterBox = NSLocalizedString(
        "타석", comment: "Batter Box")
    static let atBat = NSLocalizedString(
        "타수", comment: "AtBat")
    static let run = NSLocalizedString(
        "득점", comment: "Run")
    static let single = NSLocalizedString(
        "1루타", comment: "1B")
    static let double = NSLocalizedString(
        "2루타", comment: "2B")
    static let triple = NSLocalizedString(
        "3루타", comment: "3B")
    static let homerun = NSLocalizedString(
        "홈런", comment: "Home Run")
    static let baseOnBalls = NSLocalizedString(
        "볼넷", comment: "BB")
    static let hitByPitch = NSLocalizedString(
        "사구", comment: "HBP")
    static let strikeOut = NSLocalizedString(
        "삼진", comment: "SO")
    static let groundBall = NSLocalizedString(
        "땅볼", comment: "GroundBall")
    static let flyBall = NSLocalizedString(
        "뜬공", comment: "FlyBall")

    
    
    static let sacrificeHit = NSLocalizedString(
        "희생타", comment: "SacrificeHit")
    static let stolenBase = NSLocalizedString(
        "도루", comment: "SB")
    static let sluggingAVG = NSLocalizedString(
        "장타율", comment: "SLG")
    static let onBasePercentage = NSLocalizedString(
        "출루율", comment: "OBP")
    
    static let era = NSLocalizedString(
        "방어율", comment: "ERA")
    static let inning = NSLocalizedString(
        "이닝", comment: "Inning")
    static let er = NSLocalizedString(
        "자책점", comment: "ER")
    static let win = NSLocalizedString(
        "승리", comment: "Win")
    static let lose = NSLocalizedString(
        "패배", comment: "Lose")
    
    static let hold = NSLocalizedString(
        "홀드", comment: "Hold")
    static let save = NSLocalizedString(
        "세이브", comment: "Save")
    static let hits = NSLocalizedString(
        "피안타", comment: "Hits")
    static let rbi = NSLocalizedString(
        "타점", comment: "RBI")


}
