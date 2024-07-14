//
//  GlobalData.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import CoreLocation

struct GlobalData {
    static let uonLocations: [(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, description: String, videoName: String, imageName: String)] = [
        ("Portland Building", 52.9378, -1.1862, "The main administrative building with cafes and student services.", "Tour1_stop_1", "Tour1_image_1"),
        ("Trent Building", 52.9389, -1.1865, "A landmark building housing the Schools of Geography and Politics.", "Tour1_stop_2", "Tour1_image_2"),
        ("George Green Library", 52.9381, -1.1840, "The primary library for science and engineering students.", "Tour1_stop_3", "Tour1_image_3"),
        ("David Ross Sports Village", 52.9381, -1.1803, "A state-of-the-art sports complex offering a variety of activities.", "Tour1_stop_4", "Tour1_image_4"),
        ("Jubilee Campus", 52.9516, -1.1812, "An award-winning campus known for its modern architecture and green space.", "Tour1_stop_5", "Tour1_image_5"),
        ("King's Meadow Campus", 52.9471, -1.1653, "A campus focused on research and home to the university's archives.", "Tour1_stop_6", "Tour1_image_6")
    ]
    
}

