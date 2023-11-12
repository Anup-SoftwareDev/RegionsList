import UIKit

class RegionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let backResetButtonGreen = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    var viewModel = RegionsViewModel()
    var selectedRowIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupCustomNavigationBar()
        setUpTableViewAndConstraints()
        viewModel.filteredRegions = viewModel.regions.sorted()
        tableView.register(RegionCell.self, forCellReuseIdentifier: "RegionCell")
    }
    
    // MARK: - setupCustomNavigationBar() Functions
    
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
    @objc func backBarResetButtonAction() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filteredRegions = viewModel.regions
        selectedRowIndex = nil
        tableView.reloadData()
        presentAlert(title: "Regions Reset", message: "List set to Full List and No Regions on Select")
        
    }

    @objc func doneBarButtonAction() {
        if let selectedRowIndex = selectedRowIndex {
            let selectedRegion = viewModel.filteredRegions[selectedRowIndex.row]
            presentAlert(title: "Selected Region", message: selectedRegion)
        } else {
            presentAlert(title: "No Selection", message: "Please select a region first.")
        }
    }

    private func setUpSearchBarAndConstraints() {
        // Add custom view for second row
        let customView = UIView()
        customView.backgroundColor = .systemGray6
        view.addSubview(customView)

        // Add constraints for custom view
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Add search bar to custom view
        customView.addSubview(searchBar)
        
        // Add constraints for search bar
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
    
    // MARK: - setUpTableViewAndConstraints
    
    private func setUpTableViewAndConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Hide default cell separators
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SearchBar Delegate

extension RegionsViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectedRowIndex = nil
        viewModel.filterRegions(for: searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filteredRegions = viewModel.regions
        tableView.reloadData()
    }
}

// MARK: - TableView DataSource & Delegate

extension RegionsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRegions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath) as! RegionCell
        let region = viewModel.filteredRegions[indexPath.row]
        let isSelected = indexPath == selectedRowIndex
        let cellViewModel = RegionCellViewModel(regionName: region, isSelected: isSelected)
        cell.configure(with: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let isNewSelection = indexPath != selectedRowIndex
        if let previousSelectedRowIndex = selectedRowIndex, let previousCell = tableView.cellForRow(at: previousSelectedRowIndex) as? RegionCell {
            previousCell.configureCell(isSelected: false)
        }

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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let RegionCell = cell as? RegionCell {
            let isSelected = indexPath == selectedRowIndex
            RegionCell.configureCell(isSelected: isSelected)
        }
    }
}
