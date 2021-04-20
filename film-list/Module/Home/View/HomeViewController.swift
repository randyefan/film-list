//
//  ViewController.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 17/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var selectedYear: String?
    var viewModel: FilmListViewModel = FilmListViewModel()
    let disposeBag = DisposeBag()
    var filmViewModel: [FilmViewModel] = []
    
    private var releaseDateRow: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextField()
        createPickerView()
        dismissPickerView()
        registerObserver()
    }
    
    private func registerObserver() {
        viewModel.releaseDate.drive(onNext: { (releaseDate) in
            self.releaseDateRow = releaseDate
        }).disposed(by: disposeBag)
        viewModel.filmList.drive(onNext: { (film) in
            self.filmViewModel = film
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        viewModel.isFetching.drive(onNext: { (isFetching) in
            if isFetching {
                self.tableView.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
                self.tableView.alpha = 1
            }
        }).disposed(by: disposeBag)

    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "filmCell")
    }
    
    private func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
    }
    
    private func setupTextField() {
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
    }
    
    private func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return releaseDateRow.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(releaseDateRow[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = String(releaseDateRow[row])
        textField.text = selectedYear
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as? FilmTableViewCell {
            cell.viewModel = filmViewModel[indexPath.row]
            return cell
        }
        fatalError()
    }
    
    
}

