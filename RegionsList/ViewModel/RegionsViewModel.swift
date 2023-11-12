class RegionsViewModel {
    let regions = ["Afghanistan", "Albania",
                   "Algeria", "Andorra","Angola","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Botswana","Brazil","Bulgaria","Burundi","Cambodia","Cameroon","Canada","Chad","Chile","China","Colombia","Comoros","Congo","Croatia","Cuba","Cyprus","Denmark","Djibouti","Dominica"]
    
    var filteredRegions: [String] = []

    init() {
        filteredRegions = regions.sorted()
    }

    func filterRegions(for searchText: String) {
        if searchText.isEmpty {
            filteredRegions = regions.sorted()
        } else {
            filteredRegions = regions.filter { $0.localizedCaseInsensitiveContains(searchText) }.sorted()
        }
    }
}

