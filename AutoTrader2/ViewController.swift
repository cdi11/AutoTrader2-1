import UIKit

// Show later
//let data = try! JSONEncoder().encode(vehicles)
//let dataAsString = String(data: data, encoding: String.Encoding.utf8)!
//print(dataAsString)
protocol SortOption { }

enum PriceSortOption: SortOption {
    case lowestToHighest
    case highestToLowest
}
enum ModelSortOption: SortOption {
    case model_aToZ
    case model_zToA
}
enum YearSortOption: SortOption {
    case newestToOldest
    case oldestToNewest
}
struct YearFilterOption: FilterOption {
    let minimumYear: Int
    let maximumYear: Int
}
struct PriceFilterOption: FilterOption {
    let minimumPrice: Double
    let maximumPrice: Double
}

class CarsModel {
    var choseFilterOptions = [FilterOption]() // Initialize to empty array
    var chosenSortOptions = [SortOption]() // Initialize to empty array
    var vehicles = [Vehicle]()
    var selectedIndex = 0
    
    init() {
//        let sortByVehicleOption = VehicleType.fourDoor as! SortOption
//        let sortByMakeOption = Make.audi as! SortOption
//        let sortByModelOption = ModelSortOption.model_aToZ
//        let sortByYearOption = YearSortOption.newestToOldest
//        self.chosenSortOptions = [sortByVehicleOption, sortByMakeOption, sortByModelOption, sortByYearOption]
        
        //        let filterByVehicleOption = VehicleType.fourDoor as! FilterOption
        
        let generator = VehiclesGenerator()
        self.vehicles = generator.vehicles
    }
}

class CarsCell: UITableViewCell {
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: CarsModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model = CarsModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vehicleViewController = segue.destination as? VehicleDetailViewController else {
            return
        }
        vehicleViewController.vehicle = model.vehicles[model.selectedIndex]
        super.prepare(for: segue, sender: sender)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("🤠 User Selected row at \(indexPath.row)")
        model.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension ViewController: UITableViewDataSource {
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

