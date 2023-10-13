//
//  WordDecks.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 13.10.2023.
//

import UIKit

struct WordDecks  {
    let imageName : String
    let label : String
    
    var image : UIImage? {
        return UIImage(named: imageName)
    }
}
