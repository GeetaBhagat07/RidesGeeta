//
//  VehicleDetailsVC.swift
//  Rides
//
//  Created by ShanuGeet on 2023-01-29.
//

import UIKit

class VehicleDetailsVC: UIViewController {

    // MARK: - IB-OUTLET(S) -
    @IBOutlet weak var lblvin: UILabel!
    @IBOutlet weak var lblMakeModel: UILabel!
    
    @IBOutlet weak var lblCarType: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    
    @IBOutlet weak var cmCollectionVW: UICollectionView!
    
    //MARK:- Variables
    var selectedVehicle:VehicleListBase?
    var estimatedCarbonEmissions : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        // Do any additional setup after loading the view.
    }

    
    // MARK: -   Button Action(S) -
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Class Methods
    func setUpView(){
        
        if selectedVehicle != nil{
            estimatedCarbonEmissions = calculateEstimatedCarbonEmissions()
            print(estimatedCarbonEmissions!)
            lblvin.text =  "Vin: \(selectedVehicle?.vin ?? "N/A")"
            lblMakeModel.text = "Make and Model: \(selectedVehicle?.make_and_model ?? "N/A")"
            lblCarType.text = "Car type: \(selectedVehicle?.car_type ?? "N/A")"
            lblColor.text = "Color: \(selectedVehicle?.color ?? "N/A")"
            cmCollectionVW.reloadData()
          
          
        }
  
    }
    
    func calculateEstimatedCarbonEmissions() -> Double{
        
        //• for the first 5000km travelled, 1 unit of carbon is emitted per kilometre
        // • after the first 5000km travelled, 1.5 units is emitted per kilometre
        //• add unit test(s) for this calculation
        //1 to 5000 km – 1 unit
       // 5000 km to 10,000 km – 1.5 unit
       
        
    
        if selectedVehicle != nil {
            
            guard let kilometers = selectedVehicle?.kilometrage else { return 0 }
            if (kilometers <= 5000) {
                return  Double(kilometers) * 1.0;
                
            }
                   else if (kilometers > 5000) {
                       return (5000 * 1)
                       + Double((kilometers - 5000)) * 1.5;
                  
            }
                  
            return 0.0;
        }
        
        return 0.0
    }
    
  
    
}

extension VehicleDetailsVC :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarbonEmissionsCollectionViewCell", for: indexPath) as! CarbonEmissionsCollectionViewCell
    
        if indexPath.row == 0 {
        
            cell.lblCarbon?.text = "Swipe to See estimated carbon emissions"
        }else{
            cell.lblCarbon?.text = "\(String(format: "%.1f", estimatedCarbonEmissions!)) Units"

        }
        return cell
    }
    
    
    
    
    
    
}

extension VehicleDetailsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension VehicleDetailsVC : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("scroll end")
    }
}
