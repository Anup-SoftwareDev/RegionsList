import UIKit

class RegionCellViewModel {
    let regionName: String
    var isSelected: Bool

    init(regionName: String, isSelected: Bool = false) {
        self.regionName = regionName
        self.isSelected = isSelected
    }

    var globeImage: UIImage? {
        return isSelected ? UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
                          : UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.systemGray6, renderingMode: .alwaysOriginal)
    }

    var checkmarkImage: UIImage? {
        return UIImage(systemName: "checkmark")?.withTintColor(.green, renderingMode: .alwaysOriginal)
    }

    var nameLabelFont: UIFont {
        return isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
    }

    var checkmarkImageIsHidden: Bool {
        return !isSelected
    }
}
