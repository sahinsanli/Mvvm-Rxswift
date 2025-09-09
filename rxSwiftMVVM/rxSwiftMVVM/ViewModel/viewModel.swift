//
//  viewModel.swift
//  rxSwiftMVVM
//
//  Created by Şahin Şanlı on 8.09.2025.
//

import Foundation
import RxSwift
import RxCocoa

class viewModel {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
       let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        Service().downloadCurrecncies(url: url!) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(.invalidData):
                self.error.onNext("Invalid Data")
            default:
                print("")
            }
        }
        
        
    }
    
    
}
