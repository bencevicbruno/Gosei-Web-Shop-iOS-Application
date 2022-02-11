//
//  ChangeInfoViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation
import Combine

// TODO: implement verifying logic

final class ChangeInfoViewModel: ObservableObject {
    
    @Published var email: String
    @Published var adress: String
    @Published var phoneNumber: String
    @Published var birthDay = ""
    @Published var birthMonth = ""
    @Published var birthYear = ""
    
    @Published var isEmailValid = true
    @Published var isPhoneNumberValid = true
    @Published var isBirthdayDateValid = true
    
    var user: PersistenceData.User
    
    var onDismissed: EmptyCallback?
    
    private var subscribers = Set<AnyCancellable>()
    
    init(user: PersistenceData.User) {
        self.user = user
        
        self.email = user.email
        self.adress = user.address ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
        
        setupBirthday()
        setupSubscribers()
    }
    
    static var invalidLabels: ChangeInfoViewModel {
        let viewModel = ChangeInfoViewModel(user: .sample)
        viewModel.isEmailValid = false
        viewModel.isPhoneNumberValid = false
        viewModel.isBirthdayDateValid = false
        
        return viewModel
    }
}

// MARK: - Interaction
extension ChangeInfoViewModel {
    
    func saveTapped() {
        self.onDismissed?()
    }
}

// MARK: - Navigation
extension ChangeInfoViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
}

private extension ChangeInfoViewModel {
    
    func setupBirthday() {
        if let birthday = user.birthday {
            let components = Calendar.current.dateComponents([.day, .month, .year], from: birthday)
            
            if let day = components.day { self.birthDay = "\(day)" }
            if let month = components.day { self.birthMonth = "\(month)" }
            if let year = components.day { self.birthYear = "\(year)" }
        }
    }
    
    func setupSubscribers() {
        $email
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] email in
                self?.isEmailValid = email.isValidEmail
            }
            .store(in: &subscribers)
        
        $phoneNumber
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] phoneNumber in
                self?.isPhoneNumberValid = phoneNumber.isValidPhoneNumber
            }
            .store(in: &subscribers)
        
        $birthDay
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.validateBirthdayDate()
            }
            .store(in: &subscribers)
        
        $birthMonth
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.validateBirthdayDate()
            }
            .store(in: &subscribers)
        
        $birthYear
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.validateBirthdayDate()
            }
            .store(in: &subscribers)
    }
    
    func validateBirthdayDate() {
        if birthDay.isEmpty && birthMonth.isEmpty && birthYear.isValidEmail {
            self.isBirthdayDateValid = true
        }
        
        guard let day = Int(birthDay), let month = Int(birthMonth), let year = Int(birthYear) else {
            self.isBirthdayDateValid = false
            return
        }
        
        if let _ = Date(day: day, month: month, year: year) {
            self.isBirthdayDateValid = true
        } else {
            self.isBirthdayDateValid = false
        }
    }
}
