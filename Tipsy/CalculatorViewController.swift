import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var tip = 0.0
    var countPerson = 1
    var sumOfBill = 0.0
    var result = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        guard let buttonTitle = sender.currentTitle else { return }
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        guard let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign) else { return }
        tip = buttonTitleAsANumber / 100
    }

    @IBAction func steppedValueChanged(_ sender: UIStepper) {
        countPerson = Int(sender.value)
        splitNumberLabel.text = String(countPerson)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField?.text
        let billToDouble = Double(bill!)!
        let calculation = (billToDouble + (billToDouble * tip)) / Double(countPerson)
        result = Double(String(format: "%2f", calculation)) ?? 0.0
        openVC()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        openVC()
    }

    func openVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        vc.result = String(result)
        vc.tip = Int(tip * 100)
        vc.person = countPerson
        show(vc, sender: self)
    }

    @objc func dismissKeyboard() {
       view.endEditing(true)
      }
}
