//
//  GlobalData.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import CoreLocation

struct UonLocation {
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let description: String
    let videoName: String
    let imageName: String
    let mediaIndex: Int
}

struct GlobalData {
    static let uonLocations: [UonLocation] = [
        UonLocation(name: "Portland Building", latitude: 52.9378, longitude: -1.1862, description: "The main administrative building with cafes and student services.", videoName: "Tour1_stop_1", imageName: "Tour1_image_1", mediaIndex: 0),
        UonLocation(name: "Trent Building", latitude: 52.9389, longitude: -1.1865, description: "A landmark building housing the Schools of Geography and Politics.", videoName: "Tour1_stop_2", imageName: "Tour1_image_2", mediaIndex: 1),
        UonLocation(name: "George Green Library", latitude: 52.9381, longitude: -1.1840, description: "The primary library for science and engineering students.", videoName: "Tour1_stop_3", imageName: "Tour1_image_3", mediaIndex: 2),
        UonLocation(name: "David Ross Sports Village", latitude: 52.9381, longitude: -1.1803, description: "A state-of-the-art sports complex offering a variety of activities.", videoName: "Tour1_stop_4", imageName: "Tour1_image_4", mediaIndex: 3),
        UonLocation(name: "Jubilee Campus", latitude: 52.9516, longitude: -1.1812, description: "An award-winning campus known for its modern architecture and green space.", videoName: "Tour1_stop_5", imageName: "Tour1_image_5", mediaIndex: 4),
        UonLocation(name: "King's Meadow Campus", latitude: 52.9471, longitude: -1.1653, description: "A campus focused on research and home to the university's archives.", videoName: "Tour1_stop_6", imageName: "Tour1_image_6", mediaIndex: 5)
    ]
    
    static let quizData: [(question: String, options: [String], correctAnswerIndex: Int, imageName: String, userSelectedAnswerIndex: Int?)] = [
        ("What is 2 + 2?", ["4", "5", "6", "3"], 0, "img_tour1", nil),
        ("Who is the president of USA?", ["Donald Trump", "Joe Biden", "Barack Obama", "George Bush"], 1, "img_tour2", nil),
        ("What is the capital of France?", ["Paris", "London", "Berlin", "Rome"], 0, "img_tour3", nil),
        // Add more questions similarly
    ]
    
    static let aboutYou = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    static let universityInfo = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

