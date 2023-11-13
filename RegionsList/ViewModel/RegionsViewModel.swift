class RegionsViewModel {

    // List of regions
    let regions = [
        "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Argentina",
        "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas",
        "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize",
        "Benin", "Bermuda", "Bhutan", "Bolivia", "Botswana", "Brazil",
        "Bulgaria", "Burundi", "Cambodia", "Cameroon", "Canada", "Chad",
        "Chile", "China", "Colombia", "Comoros", "Congo", "Croatia", "Cuba",
        "Cyprus", "Denmark", "Djibouti", "Dominica"
    ]

    // Array holding sorted and possibly filtered regions
    var filteredAndSortedRegions: [String] = []

    // Initial setup of the filteredAndSortedRegions array with sorted regions
    init() {
        filteredAndSortedRegions = regions.sorted()
    }

    // Function to filter and sort regions based on search text
    func filterRegions(for searchText: String) {
        if searchText.isEmpty {
            // If no text in search bar, use the original sorted list
            filteredAndSortedRegions = regions.sorted()
        } else {
            // If there's text in search bar, filter and sort regions that contain the search text
            filteredAndSortedRegions = regions.filter { $0.localizedCaseInsensitiveContains(searchText) }.sorted()
        }
    }
}

