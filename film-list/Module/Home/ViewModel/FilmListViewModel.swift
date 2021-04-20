//
//  FilmListViewModel.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 20/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

struct FilmListViewModel {
    private let networkService: NetworkService?
    
    private let _filmList = BehaviorRelay<[FilmViewModel]>(value: [])
    private let _filmListFilter = BehaviorRelay<[FilmViewModel]>(value: [])
    private let _releaseDate = BehaviorRelay<[Int]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: true)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        fetchFilm()
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var releaseDate: Driver<[Int]> {
        return _releaseDate.asDriver()
    }
    
    var filmList: Driver<[FilmViewModel]> {
        return _filmList.asDriver()
    }
    
    var filmListFilter: Driver<[FilmViewModel]> {
        return _filmListFilter.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    private func fetchFilm() {
        networkService?.getFilm(completion: { data, error in
            self._isFetching.accept(true)
            
            if error != nil {
                self._error.accept(error.map {$0.rawValue})
                self._isFetching.accept(false)
            }
            
            guard let data = data else { return }
            var filmList: [FilmViewModel] = []
            var releaseDate: [Int] = []
            for i in data.arrayValue {
                if !releaseDate.contains(i["release_date"].intValue) {
                    releaseDate.append(i["release_date"].intValue)
                }
                filmList.append(FilmViewModel(film: Film(json: i)))
            }
            releaseDate.sort()
            self._filmList.accept(filmList)
            self._releaseDate.accept(releaseDate)
            self._isFetching.accept(false)
        })
    }
    
    func filmByYear(year: String) {
        self._isFetching.accept(true)
        
        let filmList = _filmList.value
        let filmListFilter = filmList.filter { (film) -> Bool in
            film.releaseDate == Int(year)
        }
        
        self._filmListFilter.accept(filmListFilter)
        self._isFetching.accept(false)
    }
    
    
    
}
