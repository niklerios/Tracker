//
//  TrackerEditViewController.swift
//  Tracker
//
//  Created by Nikler on 8/12/26.
//

import UIKit

final class TrackerEditViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новая привычка"
    }
    
    override func loadView() {
        view = TrackerEditView(delegate: self)
    }
}

extension TrackerEditViewController: TrackerEditViewDelegate {
    func didTapSaveButton() {
        dismiss(animated: true)
    }
    
    func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    func didTapSelectCategory() {
        // todo - обработка в другом спринте
        print("Select Category")
    }
    
    func didTapSetupSchedule() {
        print("Setup Schedule")
    }
    
    func titleEditingChanged(_ text: String?) {
        print(text ?? "")
    }
}
