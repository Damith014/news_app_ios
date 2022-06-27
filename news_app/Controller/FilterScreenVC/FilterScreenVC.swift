//
//  FilterScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-27.
//

import UIKit

protocol FilterDelegate {
    func filter(county: String, language: String)
}

class FilterScreenVC: UIViewController {
    @IBOutlet weak var picker_country: UIPickerView!
    @IBOutlet weak var picker_language: UIPickerView!
    @IBOutlet weak var label_done: UILabel!

    var default_country: String = "us"
    var default_language: String = "en"

    var delegate: FilterDelegate?

    var countries: [String] = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]

    var languages: [String] = ["ar", "de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "sv", "ud", "zh"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FilterScreenVC.tapFilter))
        self.label_done.isUserInteractionEnabled = true
        self.label_done.addGestureRecognizer(tap)

        if let indexPosition = self.countries.firstIndex(of: self.default_country) {
            self.picker_country.selectRow(indexPosition, inComponent: 0, animated: true)
        }
        if let indexPosition = self.languages.firstIndex(of: self.default_language) {
            self.picker_language.selectRow(indexPosition, inComponent: 0, animated: true)
        }
    }

    @objc func tapFilter(sender: UITapGestureRecognizer) {
        self.delegate?.filter(county: self.default_country, language: self.default_language)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterScreenVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return self.languages.count
        }
        return self.countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return self.languages[row]
        }
        return self.countries[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            self.default_language = self.languages[row]
        } else if pickerView.tag == 1 {
            self.default_country = self.countries[row]
        }
    }
}
