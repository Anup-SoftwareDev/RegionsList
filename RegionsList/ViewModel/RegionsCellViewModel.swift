import UIKit

// ViewModel for the RegionCell, handling the logic for UI changes based on selection state
class RegionCellViewModel {
    // Properties
    let regionName: String // Name of the region
    var isSelected: Bool // Selection state

    // Initializer with default isSelected value as false
    init(regionName: String, isSelected: Bool = false) {
        self.regionName = regionName
        self.isSelected = isSelected
    }

    // Computed property for the globe image
    // Changes the image's color based on the selection state
    var globeImage: UIImage? {
        return isSelected ? UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
                          : UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.systemGray6, renderingMode: .alwaysOriginal)
    }

    // Computed property for the checkmark image
    var checkmarkImage: UIImage? {
        return UIImage(systemName: "checkmark")?.withTintColor(.green, renderingMode: .alwaysOriginal)
    }

    // Computed property for the name label font
    // Changes the font weight based on the selection state
    var nameLabelFont: UIFont {
        return isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
    }

    // Computed property to determine if the checkmark image should be hidden
    var checkmarkImageIsHidden: Bool {
        return !isSelected
    }
}
