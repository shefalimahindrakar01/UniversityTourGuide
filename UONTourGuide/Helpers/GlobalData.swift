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
        UonLocation(name: "Entrance", latitude: 52.947489, longitude: -1.184603, description: "This is the entrance of Jubilee Campus of University of Nottingham.", videoName: "Tour1_stop_1", imageName: "Tour1_image_1", mediaIndex: 0),
        UonLocation(name: "Exchange Building", latitude: 52.9539, longitude: -1.1878, description: "The building offers a range of services and facilities, including a café, entrance to a SPAR shop, teaching rooms, lecture theatres, a student services centre, and a student study area.", videoName: "Tour1_stop_2", imageName: "Tour1_image_2", mediaIndex: 1),
        UonLocation(name: "Computer Science Building", latitude: 52.9532, longitude: -1.1871, description: "The building's services and facilities include a reception area, computer lab, atrium, and seminar and teaching rooms.", videoName: "Tour1_stop_3", imageName: "Tour1_image_3", mediaIndex: 2),
        UonLocation(name: "Dearing Building", latitude: 52.9527, longitude: -1.1867, description: "It is a modern facility housing the Nottingham University Business School, featuring state-of-the-art lecture theatres and seminar rooms", videoName: "Tour1_stop_4", imageName: "Tour1_image_4", mediaIndex: 3),
        UonLocation(name: "Djanogly Learning Resource Centre", latitude: 52.9536, longitude: -1.1885, description: "The Sir Harry and Lady Djanogly Learning Resource Centre is a library on the Jubilee Campus", videoName: "Tour1_stop_5", imageName: "Tour1_image_5", mediaIndex: 4),
        UonLocation(name: "Business School South", latitude: 52.9516, longitude: -1.1863, description: "t is a business school of the University of Nottingham, United Kingdom", videoName: "Tour1_stop_6", imageName: "Tour1_image_6", mediaIndex: 5),
        UonLocation(name: "Café Aspire", latitude: 52.9517, longitude: -1.1848, description: "Cafe Aspire offers a relaxing space for students and staff with a variety of food and drink options.", videoName: "Tour1_stop_7", imageName: "Tour1_image_7", mediaIndex: 6),
        UonLocation(name: "The Jubilee Hotel and Conferences", latitude:  52.9500, longitude: -1.1861, description: "Situated within a sprawling 65-acre lakeside landscape, and close to Nottingham city centre, The Jubilee Hotel & Conferences serves as an innovative Nottingham Conference venue. ", videoName: "Tour1_stop_8", imageName: "Tour1_image_8", mediaIndex: 7),
        UonLocation(name: "Si Yuan Centre", latitude: 52.9500, longitude: -1.18677, description: "The new, low-carbon, £4m facility is on Jubilee Campus and provides a peaceful and creative environment for teaching and the study of Chinese language and culture.", videoName: "Tour1_stop_9", imageName: "Tour1_image_9", mediaIndex: 8),
        UonLocation(name: "Xu Yafen Building", latitude: 52.9517, longitude: -1.18494, description: "Services / Facilities within the building include; Aspire Café, Faith Centre, Graduate Centre and seminar rooms.", videoName: "Tour1_stop_10", imageName: "Tour1_image_10", mediaIndex: 9),
        UonLocation(name: "Jubilee Campus Car Park", latitude: 52.9510,longitude: -1.1856, description: "The Jubilee Campus Car Park at the University of Nottingham provides ample parking space for students, staff, and visitors, ensuring convenient access to all campus facilities.", videoName: "Tour1_stop_11", imageName: "Tour1_image_11", mediaIndex: 10),
        UonLocation(name: "UoN Muslim Prayer Room & Mosque", latitude: 52.9516, longitude: -1.1854, description: "It offers a dedicated space for worship and community activities, catering to the spiritual needs of Muslim students, staff, and visitors.", videoName: "Tour1_stop_12", imageName: "Tour1_image_12", mediaIndex: 11),
        UonLocation(name: "Business School North Building", latitude: 52.9544,longitude: -1.1889, description: "Services / Facilities within the building include; teaching/seminar rooms, International Centre for Corporate Social Responsibility, MSc computer rooms, quiet zone, postgraduate careers, education and student experience.", videoName: "Tour1_stop_13", imageName: "Tour1_image_13", mediaIndex: 12),
        UonLocation(name: "Department of Engineering", latitude: 52.9544,longitude: -1.1831, description: "This is the place where you get the space, support, skills and connections to get ready to shape the real world. Explore engineering, architecture and design.", videoName: "Tour1_stop_14", imageName: "Tour1_image_14", mediaIndex: 13),
        UonLocation(name: "Institute of Mental Health", latitude: 52.9527,longitude: -1.1841, description: "Cafe Aspire offers a relaxing space for students and staff with a variety of food and drink options.", videoName: "Tour1_stop_15", imageName: "Tour1_image_15", mediaIndex: 14),
        UonLocation(name: "Energy Technologies Building", latitude: 52.9523,longitude: -1.1837, description: "Energy Technologies Building is an exemplar low carbon building dedicated specifically designed for continuing and developing its market leading low carbon energy research activities and demonstrations. The building includes many novel research facilities, including a smart grid, a prototyping hall and the UK’s first green hydrogen refueling facility.", videoName: "Tour1_stop_16", imageName: "Tour1_image_16", mediaIndex: 15),
        UonLocation(name: "Newark Hall", latitude:52.9527,longitude: -1.1856, description: "It provides comfortable student accommodation with modern amenities, common areas for socializing, and convenient access to campus facilities.", videoName: "Tour1_stop_17", imageName: "Tour1_image_17", mediaIndex: 16),
        UonLocation(name: "Southwell Hall", latitude: 52.9533, longitude: -1.1858, description: "It provides comfortable student accommodation with modern amenities, common areas for socializing, and convenient access to campus facilities.", videoName: "Tour1_stop_18", imageName: "Tour1_image_18", mediaIndex: 17),
        UonLocation(name: "Melton Hall", latitude: 52.9548, longitude: -1.1904, description: "It provides comfortable student accommodation with modern amenities, common areas for socializing, and convenient access to campus facilities.", videoName: "Tour1_stop_19", imageName: "Tour1_image_19", mediaIndex: 18)
    ]
    
    static let quizData: [(question: String, options: [String], correctAnswerIndex: Int, imageName: String, userSelectedAnswerIndex: Int?)] = [
        ("In which year was the Jubilee Campus officially opened?", ["1999", "2005", "1995", "2010"], 0, "img_tour1", nil),
        ("Who officially opened the Jubilee Campus?", ["Queen Elizabeth II", "Joe Biden", "Barack Obama", "George Bush"], 0, "img_tour2", nil),
        ("What was the site of the Jubilee Campus before its construction?", ["Farm", "Hotel", "Industrial site", "Garden"], 2, "img_tour3", nil),
        ("What is the name of the 60-meter tall sculpture on the campus?", ["Dearing", "Atrium", "George Green", "Aspire"], 3, "img_tour2", nil),
        ("Which famous bicycle company used to have its factory on this site?", ["Queen Elizabeth II", "Raleigh Bicycle Company", "Barack Obama", "George Bush"], 1, "img_tour2", nil),
        ("What is the name of the distinctively shaped building named after a former Chancellor?", ["Queen Elizabeth II", "Prof Shin Chen", " Sir Colin Campbell Building", "George Bush"], 2, "img_tour2", nil),
        ("Which school, known for its business programs, is located on this campus?", ["Data Science", "Computer Science", "The Business School", "Home Science"], 2, "img_tour2", nil),
        ("What type of bus connects Jubilee Campus to the main University Park campus?", ["Hopper Bus", "Indigo Bus", "36", "44"], 0, "img_tour2", nil),
        ("What is the name of the innovation hub that supports technology entrepreneurs?", ["Queen Elizabeth II", "The Ingenuity Centre", "Atrium", "Tech Centre"], 1, "img_tour2", nil),
        ("What historic building is located near the Jubilee Campus?", ["Londo Eye", "Joe Biden", "London Bridge", " Wollaton Hall"], 3, "img_tour2", nil),
        
    ]
    
    static let aboutYou = """
<p style="font-size: 18px; font-weight: normal;">Welcome to Jubilee campus cutting-edge Audio Tour Guide App! Designed to elevate your campus exploration experience, our app offers:</p>
<ul>
<li style="font-size: 18px; font-weight: normal;">Personalised, self-guided audio tours tailored to your preferences, allowing you to explore at your own pace.</li>
<li style="font-size: 18px; font-weight: normal;">Interactive maps with real-time GPS integration for seamless navigation across the campus.</li>
<li style="font-size: 18px; font-weight: normal;">Detailed information about key campus landmarks, history, and facilities to deepen your understanding.</li>
<li style="font-size: 18px; font-weight: normal;">Engaging quizzes and trivia to make your tour more interactive and enjoyable.</li>
<li style="font-size: 18px; font-weight: normal;">Accessibility features to accommodate diverse user needs, ensuring an inclusive experience for everyone.</li>
</ul>
<p style="font-size: 18px; font-weight: normal;">Whether you're a prospective student, a visitor, or part of the university community, our app offers an immersive, informative experience that highlights the best of our campus. Explore the stories behind our landmarks, learn about our academic programs, and discover what makes our campus life so unique—all through an intuitive and engaging platform.</p>
<p style="font-size: 18px; font-weight: normal;">Our Audio Tour Guide App reflects University of Nottingham’s dedication to innovation, inclusivity, and providing an outstanding experience to everyone who visits. Download now and start your personal journey through our campus today!</p>
<p style="font-size: 18px; font-weight: normal;">The images and logos used in this application, including university campus photographs and the official university logo, have been sourced from publicly available internet resources. These materials are used solely for educational and non-commercial purposes, specifically in the context of enhancing the user experience within this university tour guide app.</p>
<p style="font-size: 18px; font-weight: normal;">All rights to the original images and logos belong to their respective copyright holders. If any copyright holder would like an image or logo to be removed or appropriately attributed, please contact us, and we will address the matter promptly.</p>
"""
    
    static let universityInfo = "The University of Nottingham is a public research university in Nottingham, England. It was founded as University College Nottingham in 1881, and was granted a royal charter in 1948. Nottingham's main campus (University Park) with Jubilee Campus and teaching hospital (Queen's Medical Centre) are located within the City of Nottingham, with a number of smaller campuses and sites elsewhere in Nottinghamshire and Derbyshire. Outside the UK, the university has campuses in Semenyih, Malaysia, and Ningbo, China. Nottingham is organised into five constituent faculties, within which there are more than 50 schools, departments, institutes and research centres. Nottingham has more than 46,000 students and 7,000 staff across the UK, China and Malaysia and had an income of £811.2 million in 2022–23, of which £129.5 million was from research grants and contracts."
}

