//
//  ViewController.swift
//  rxSwiftMVVM
//
//  Created by Şahin Şanlı on 8.09.2025.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    var cryptolist = [Crypto]()
    let disposeBag = DisposeBag()
    let cryptoVM = viewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBindings()
        cryptoVM.requestData()
        
 
    }
    
    func setupBindings(){
        
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptolist = cryptos
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
           print("error")
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptolist[indexPath.row].currency
        content.secondaryText = cryptolist[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }


}

