import UIKit

class RegionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // UI Elements
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let backResetButtonGreen = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    
    // View Model and Selected Row Index
    var viewModel = RegionsViewModel()
    var selectedRowIndex: IndexPath?
    var selectedIndexRegion: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupCustomNavigationBar()
        setUpTableViewAndConstraints()
        viewModel.filteredAndSortedRegions = viewModel.regions.sorted()
        tableView.register(RegionCell.self, forCellReuseIdentifier: "RegionCell")
    }
    
    // MARK: - Navigation Bar Setup

    func setupCustomNavigationBar() {
        setUpBarButtonsAndTitle()
        setUpSearchBarAndConstraints()
    }
    
    private func setUpBarButtonsAndTitle() {
        // Customize navigation bar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Select region"
        
        // Add BarButtons
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backResetButtonGreen, style: .plain, target: self, action: #selector(backBarResetButtonAction))
        setupBoldDoneButton()
    }
    
    // Function called to make 'Done' label bold
    func setupBoldDoneButton() {
        let label = UILabel()
        label.text = "Done"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGreen
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doneBarButtonAction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)

        let barButtonItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // Function to implement 'Reset' procedure for backBarResetButton
    @objc func backBarResetButtonAction() {
        // Reset search bar and table view
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filteredAndSortedRegions = viewModel.regions
        selectedRowIndex = nil
        tableView.reloadData()
        presentAlert(title: "Reset", message: "Regions List Reset")
    }

    // Function to display Dialog box indicating Region selected by user
    @objc func doneBarButtonAction() {
        
        if let selectedRowIndex = selectedRowIndex {
            let selectedRegion = viewModel.filteredAndSortedRegions[selectedRowIndex.row]
            presentAlert(title: "Selected Region", message: selectedRegion)
        } else {
            presentAlert(title: "No Selection", message: "Please select a region first.")
        }
    }
    
    // Function to add SearchBar into CustomNavigation Bar
    private func setUpSearchBarAndConstraints() {
        // Setup Search Bar UI
        let customView = UIView()
        customView.backgroundColor = .systemGray6
        view.addSubview(customView)

        // Constraints for custom view
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Add search bar to custom view with constraints
        customView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.systemGray6
        searchBar.searchTextField.backgroundColor = UIColor.systemGray5
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: customView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
    }
    
    // MARK: - TableView Setup
    
    private func setUpTableViewAndConstraints() {
        // Setup TableView UI
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Hide default cell separators to accomodate for custom one
        tableView.separatorStyle = .none
        
        // Constraints for TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // Present Alert Function
    private func presentAlert(title: String, message: String) {
        // Display Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SearchBar Delegate

extension RegionsViewController {
    
    // Handle search bar updates
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            selectedRowIndex = nil
            viewModel.filterRegions(for: searchText)
            tableView.reloadData()
        }


    // Handle search bar cancel button click
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filteredAndSortedRegions = viewModel.regions
        tableView.reloadData()
    }
    
    func indexOfRegion(in filteredAndSortedRegions: [String], region: String) -> Int? {
        return filteredAndSortedRegions.firstIndex(of: region)
    }
    
}

// MARK: - TableView DataSource & Delegate

extension RegionsViewController {
    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredAndSortedRegions.count
    }
    
    // Configure TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath) as! RegionCell
        let region = viewModel.filteredAndSortedRegions[indexPath.row]
        let isSelected = indexPath == selectedRowIndex
        let cellViewModel = RegionCellViewModel(regionName: region, isSelected: isSelected)
        cell.configure(with: cellViewModel)
        return cell
    }

    // Handle TableView Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Update selected cell view
        let isNewSelection = indexPath != selectedRowIndex
        if let previousSelectedRowIndex = selectedRowIndex, let previousCell = tableView.cellForRow(at: previousSelectedRowIndex) as? RegionCell {
            previousCell.configureCell(isSelected: false)
        }
        
        // Index of newly selected cell is saved into 'selectedRowIndex' variable
        selectedRowIndex = isNewSelection ? indexPath : nil

        if isNewSelection, let cell = tableView.cellForRow(at: indexPath) as? RegionCell {
            cell.configureCell(isSelected: true)
        }

        if !isNewSelection {
            if let cell = tableView.cellForRow(at: indexPath) as? RegionCell {
                cell.configureCell(isSelected: false)
            }
        }
    }

    // Configure cell display
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let RegionCell = cell as? RegionCell {
            let isSelected = indexPath == selectedRowIndex
            RegionCell.configureCell(isSelected: isSelected)
        }
    }
}
