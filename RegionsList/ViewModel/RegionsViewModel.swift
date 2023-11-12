class RegionsViewModel {

    // Array holding the list of regions/countries that have to be listed in the TableView
    let regions = [
        "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Argentina",
        "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas",
        "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize",
        "Benin", "Bermuda", "Bhutan", "Bolivia", "Botswana", "Brazil",
        "Bulgaria", "Burundi", "Cambodia", "Cameroon", "Canada", "Chad",
        "Chile", "China", "Colombia", "Comoros", "Congo", "Croatia", "Cuba",
        "Cyprus", "Denmark", "Djibouti", "Dominica"
    ]

    // Array that will be holding Regions that are sorted alphabetically and possibly filtered based on user input.
    var filteredAndSortedRegions: [String] = []

    // Initial value in the filteredAndSortedRegions array are the alphabetically sorted values from 'regions' array
    init() {
        filteredAndSortedRegions = regions.sorted()
    }

    // Function that is called when text in the search bar changes.
    func filterRegions(for searchText: String) {
        if searchText.isEmpty {
            // if no text exists in searchbar the original list is put up after sorting it alphabetically.
            filteredAndSortedRegions = regions.sorted()
        } else {
            // if text exits in searchbar, a list is put out for every region name that holds all letters in the searchbar.
            filteredAndSortedRegions = regions.filter { $0.localizedCaseInsensitiveContains(searchText) }.sorted()
        }
    }
}


