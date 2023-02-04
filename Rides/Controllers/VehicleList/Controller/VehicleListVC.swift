//
//  VehicleListVC.swift
//  Rides
//
//  Created by ShanuGeet on 2023-01-29.
//

import UIKit
import ProgressHUD

class VehicleListVC: BaseViewController {

    
    
    // MARK: - IB-OUTLET(S) -
    
    @IBOutlet weak var tableVehicleList: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tfNumber: UITextField!
    
    //MARK:- Variables
    lazy var viewModel: VehicleListVM = {
        let obj = VehicleListVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
    
    let textInputLimit = 3
    
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
      

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         
        
    }
    
    // MARK: - Class Methods
    func setUpView(){
        // Added View with the sort button
        ProgressHUD.animationType = .circleStrokeSpin
        self.tableVehicleList.registerNIB(VehicleListCell.className)
        tableVehicleList.tableHeaderView = headerView
        tableVehicleList.estimatedSectionHeaderHeight = 40
        
        tfNumber.textAlignment = .center
        tfNumber.layer.borderWidth = 1
        tfNumber.layer.cornerRadius = 4.0
        tfNumber.delegate = self;
      }
    
    
   
    
    
    // MARK: -   Button Action(S) -
    
    @IBAction func sortTableListbyCarType(_ sender: Any) {
        // Sort table data using car type
        self.viewModel.myVehicleList = self.viewModel.myVehicleList.sorted(by: { list1, list2 in
            return list1.car_type?.lowercased() ?? "" < list2.car_type?.lowercased() ?? ""
        })
        self.tableVehicleList.reloadData()
    }
    

    @IBAction func submitButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        if tfNumber.text?.count == 0 { // when the value is in range, proceed with the API call
            
            HelpingVC.shared.showAlert(message: "Please enter the number first to proceed with the api data")
            //when the value is not in range, do not make an API call and notify the user to make a correction
        }
        else {
            let sizeValue = Int(tfNumber.text ?? "0") //  value must be an integer in the range 1 to 100
            if (sizeValue! >= 1 && sizeValue! <= 100 ){
                
                ProgressHUD.show()
                self.viewModel.getMyVehicleList(size: tfNumber.text) {
                    DispatchQueue.main.async {
                        self.tableVehicleList.reloadData()
                        ProgressHUD.dismiss()
                    }
                }
            }
        }
      
    
    }
    
}

// MARK: - Table View Delegate & DataSource(S) -


extension VehicleListVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myVehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleListCell.className, for: indexPath) as? VehicleListCell else { return UITableViewCell() }
        
        cell.setVehiclesData = viewModel.myVehicleList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (viewModel.myVehicleList.count > 0) ?  40.0 : 0.0
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as? VehicleDetailsVC
        vc?.selectedVehicle =  viewModel.myVehicleList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}




extension VehicleListVC : UITextFieldDelegate{
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text {

            let newStr = (text as NSString).replacingCharacters(in: range, with: string)
            if newStr.isEmpty {
                return true
            }
            let intvalue = Int(newStr)
            //Only allow numbers. No Copy-Paste text values.
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
              
            // The text range should be in the 1 to 1oo
            return (string.rangeOfCharacter(from: invalidCharacters) == nil) && (intvalue! >= 1 && intvalue! <= 100)
        }
        return true
    }

    
}
