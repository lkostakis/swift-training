//
//  ChangeLevelViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import UIKit

class ChangeLevelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var interactor: ChangeLevelInteractor!
    var levelList: [ChangeLevelPresenter.ChangeLevelViewModel]? {
        didSet {
            pickerView.reloadAllComponents()
        }
    }

    @IBOutlet weak var pickerView: UIPickerView!

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        levelList?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let levelList else {
            return ""
        }
        return levelList[row].difficultyName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = ChangeLevelPresenter(controller: self)
        interactor = ChangeLevelInteractor(presenter: presenter)
        interactor.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        interactor.viewWillDisappear(pickerView.selectedRow(inComponent: 0))
    }

    func displayPickerViewSelectedRow(_ index: Int) {
        pickerView.selectRow(index, inComponent: 0, animated: true)
    }
}
