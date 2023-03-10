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
    
    //MARK:- Variables
    lazy var viewModel: VehicleListVM = {
        let obj = VehicleListVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
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
