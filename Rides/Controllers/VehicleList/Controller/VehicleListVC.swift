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
        ProgressHUD.animationType = .circleStrokeSpin
        self.tableVehicleList.registerNIB(VehicleListCell.className)
        tableVehicleList.tableHeaderView = headerView
        tableVehicleList.estimatedSectionHeaderHeight = 40
        
        tfNumber.textAlignment = .center
        tfNumber.layer.borderWidth = 1
        tfNumber.layer.cornerRadius = 4.0
        tfNumber.delegate = self;
  
        self.tableVehicleList.reloadData()
    }
    
    
   
    
    
    // MARK: -   Button Action(S) -
    
    @IBAction func sortTableListbyCarType(_ sender: Any) {
        self.viewModel.myVehicleList = self.viewModel.myVehicleList.sorted(by: { list1, list2 in
            return list1.car_type?.lowercased() ?? "" < list2.car_type?.lowercased() ?? ""
        })
    }
    

    @IBAction func submitButtonPressed(_ sender: Any) {
        //ProgressHUD.show()
        self.viewModel.getMyVehicleList {
            DispatchQueue.main.async {
                self.tableVehicleList.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
    
}

// MARK: - Table View Delegate & DataSource(S) -

/*
extension VehicleListVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myVehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleListCell.className, for: indexPath) as? VehicleListCell else { return UITableViewCell() }
        
        cell.lblVin?.text = "jhdjhd"
        cell.lblMakeAndModel?.text = "sadshd"
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
    
    
}
*/


extension VehicleListVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleListCell.className, for: indexPath) as? VehicleListCell else { return UITableViewCell() }
        
        cell.lblVin?.text = "J89ZTPP10VJU97000"
        cell.lblMakeAndModel?.text = "Audi A8"
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as? VehicleDetailsVC
      
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension VehicleListVC : UITextFieldDelegate{
    

   /* func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        //Prevent "0" characters as the first characters. (i.e.: There should not be values like "003" "01" "000012" etc.)
        if textField.text?.count == 0 && string == "0" {
            
            return false
        }
        
        /// will check the text input only numbers and limit is between 1 and 100
        if ((textField.text!) + string).count > 100 {
            
            return false
        }
        
//        if let textvalue = Int(string), textvalue <= textInputLimit{
//            return true
//        }

        //Only allow numbers. No Copy-Paste text values.
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
          
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
        &&  (textField.text?.count ?? 0) + string.count - range.length <= textInputLimit
        
    }*/
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            let text = textField.text ?? ""
            
            
            let updatedText = text.replacingCharacters(in: Range(range, in: text)!, with: string)
            if let intValue = Int(updatedText), 1 <= intValue && intValue <= 100 {
                return true
            } else {
                
                //Prevent "0" characters as the first characters. (i.e.: There should not be values like "003" "01" "000012" etc.)
                if textField.text?.count == 0 && string == "0" {
                    
                    return false
                }
                
                /// will check the text input only numbers and limit is between 1 and 100
                if ((textField.text!) + string).count > 100 {
                    
                    return false
                }

                
                //Only allow numbers. No Copy-Paste text values.
                let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
                  
                return (string.rangeOfCharacter(from: invalidCharacters) == nil)
                &&  (textField.text?.count ?? 0) + string.count - range.length <= textInputLimit 
            }

        }
    
}
