//
//  ReadyStatusService.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/15/24.
//

import Foundation

protocol ReadyStatusServiceType {
    func getMyPromiseStatus(with promiseID: Int) -> MyReadyStatusModel?
    func patchMyReadyStatus(with myInfo: MyPromiseReadyInfoModel)
    func getParticipantList(with promiseID: Int) -> PromiseParticipantListModel?
}

final class MockReadyStatusService: CreateMeetingServiceType {
    func getMyPromiseStatus(with promiseID: Int) -> MyReadyStatusModel? {
        let mockData = MyReadyStatusModel(
            preparationTime: 300,
            travelTime: 230,
            preparationStartAt: "AM 11:00",
            departureAt: "PM 1:30",
            arrivalAt: "PM 2:00"
        )
        
        return mockData
    }
    
    func patchMyReadyStatus(with myInfo: MyPromiseReadyInfoModel) {
        
    }
    
    func getParticipantList(with promiseID: Int) -> PromiseParticipantListModel? {
        let mockData = PromiseParticipantListModel(
            participantCount: 3,
            participants: [
                Participant(
                    participantId: 1,
                    memberId: 3,
                    name: "안꾸물이",
                    profileImg: "imageUrl",
                    state: "도착"
                ),
                Participant(
                    participantId: 2,
                    memberId: 4,
                    name: "꾸우우우웅물이",
                    profileImg: "imageUrl",
                    state: "도착"
                ),
                Participant(
                    participantId: 3,
                    memberId: 5,
                    name: "꾸물이",
                    profileImg: "imageUrl",
                    state: "이동중"
                )
            ]
        )
        
        return mockData
    }
}
