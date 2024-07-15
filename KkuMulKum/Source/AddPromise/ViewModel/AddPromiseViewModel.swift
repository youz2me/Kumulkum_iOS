//
//  AddPromiseViewModel.swift
//  KkuMulKum
//
//  Created by 김진웅 on 7/14/24.
//

import Foundation

import RxCocoa
import RxSwift

enum TextFieldVailidationResult {
    case basic, onWriting, error
}

final class AddPromiseViewModel {
    let meetingID: Int
    
    var combinedDataTime: String { combinedDateTimeRelay.value }
    
    private let service: AddPromiseServiceType
    private let combinedDateTimeRelay = BehaviorRelay(value: "")
    
    init(meetingID: Int, service: AddPromiseServiceType) {
        self.meetingID = meetingID
        self.service = service
    }
}

extension AddPromiseViewModel: ViewModelType {
    struct Input {
        let promiseNameText: Observable<String>
        let promiseTextFieldEndEditing: Observable<Void>
        let date: Observable<Date>
        let time: Observable<Date>
    }
    
    struct Output {
        let validationPromiseNameResult: Observable<TextFieldVailidationResult>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let isValid = input.promiseNameText
            .map { [weak self] text in
                self?.isValid(text: text) ?? false
            }
        
        let validationResultWhileEditing = input.promiseNameText
            .map { text -> TextFieldVailidationResult in
                if text.isEmpty {
                    return .basic
                }
                
                if self.isValid(text: text) {
                    return .onWriting
                }
                
                return .error
            }
        
        let validationResultAfterEditing = input.promiseTextFieldEndEditing
            .withLatestFrom(isValid)
            .map { flag -> TextFieldVailidationResult in
                return flag ? .basic : .error
            }
        
        let validationPromiseNameResult = Observable.merge(
            validationResultWhileEditing, validationResultAfterEditing
        )
        
        Observable.combineLatest(input.date, input.time)
            .map { (date, time) -> String in
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
                
                var combinedComponents = DateComponents()
                combinedComponents.year = dateComponents.year
                combinedComponents.month = dateComponents.month
                combinedComponents.day = dateComponents.day
                combinedComponents.hour = timeComponents.hour
                combinedComponents.minute = timeComponents.minute
                combinedComponents.second = timeComponents.second
                
                let combinedDate = calendar.date(from: combinedComponents)!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                return dateFormatter.string(from: combinedDate)
            }
            .bind(to: combinedDateTimeRelay)
            .disposed(by: disposeBag)
        
        return Output(
            validationPromiseNameResult: validationPromiseNameResult
        )
    }
}

private extension AddPromiseViewModel {
    func isValid(text: String) -> Bool {
        if text.isEmpty { return true }
        
        let regex = "^[가-힣a-zA-Z0-9 ]{1,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: text)
    }
}
