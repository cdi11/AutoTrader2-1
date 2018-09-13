import UIKit

class CarsModel {
    var vehicles = [Vehicle]()
    var selections: [Selection] = [
        Selection(option: .lowestToHighestInPrice, isChecked: false),
        Selection(option: .aToZForMake, isChecked: false),
        Selection(option: .aToZForModel, isChecked: false),
        Selection(option: .oldestToNewest, isChecked: false)
    ]
    var selectedIndex = 0
    
    init() {
        let generator = VehiclesGenerator()
        self.vehicles = generator.vehicles
    }
    
    func newSelection(at index: Int) {
        selections[index].isChecked = !selections[index].isChecked
        // sort the vehicles array!
           // print(selections)
        
        
        for selection in selections {
            if selection.isChecked == true {
                if selection.option == .lowestToHighestInPrice {
                    print ("sorted by price")
                    vehicles = vehicles.sorted(by: {$0.price > $1.price})
                }
            
        
       
            if selection.isChecked == true {
                if selection.option == .aToZForMake {
                    print ("sorted by make")
                    vehicles = vehicles.sorted(by: {$0.make < $1.make})
                }
            
        
            if selection.isChecked == true {
                if selection.option == .aToZForModel {
                    print ("sorted by model")
                    vehicles = vehicles.sorted(by: {$0.model < $1.model})
                }
            
        
            if selection.isChecked == true {
                if selection.option == .oldestToNewest {
                    print ("sorted by year")
                    vehicles = vehicles.sorted(by: {$0.year < $1.year})
                }
            }
            }
            }
            }
        }
        
    
    }
    
}
            


class CarsCell: UITableViewCell {
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
}

class VehicleListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: CarsModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model = CarsModel()
    }
    
    deinit {
        print("vehicle list was deallocated")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vehicleViewController = segue.destination as? VehicleDetailViewController  {
            vehicleViewController.vehicle = model.vehicles[model.selectedIndex]
        } else if let optionsViewController = segue.destination as? SortOptionsViewController {
            optionsViewController.delegate = self
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
}

extension VehicleListViewController: SortOptionsViewControllerDelegate {
    var selections: [Selection] {
        return model.selections
    }
    
    func newSelection(at index: Int) {
        model.newSelection(at: index)
    }
    
}

extension VehicleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("🤠 User Selected row at \(indexPath.row)")
        model.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension VehicleListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: "carsCell", for: indexPath) as? CarsCell else {
            return UITableViewCell()
        }
        let vehicle = model.vehicles[indexPath.row]
        vehicleCell.makeLabel.text = "Make: " + vehicle.make
        vehicleCell.modelLabel.text = "Model: " + vehicle.model
        vehicleCell.yearLabel.text = "Year \(vehicle.year)"
        
        
        return vehicleCell
    }
    
    
    

}

