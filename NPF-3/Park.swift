//
//  Park.swift
//  NPF-3
//
//  Created by Payal Kothari(pak4180) on 2/9/17.
//  Copyright © 2017 Payal Kothari. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Park: NSObject, MKAnnotation{
    var name  = ""     // location name
    var state = ""   // state
    private var parkName : String = ""
    private var parkLocation : String = ""
    private var dateFormed : String = ""
    private var area : String = ""
    private var link : String = ""
    private var location : CLLocation?
    private var imageLink : String = ""
    private var parkDescription : String = ""
    private var imageName : String = ""
    private var imageSize : String = ""
    private var imageType : String = ""
    private var latitude : String = ""
    private var longitude : String = ""

    
    //needed for the MKAnnotation protocol // computed property
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    //optional - required with set callout true
    @objc var title : String? {
        get {
            return name
        }
    }
    
    @objc var subtitle : String? {
        get {
            return state
        }
    }

    convenience override init () {
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "Unknown", location: nil, imageLink: "Unknown", parkDescription: "Unknown", imageName: "Unknown", imageSize: "Unknown", imageType: "Unknown")
    }
    
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation!, imageLink: String, parkDescription: String, imageName: String, imageSize: String, imageType: String) {
        super.init()
        self.name = parkName
        self.state = parkLocation
        self.location = location
        set(name: parkName)
        set(location: parkLocation)
        set(date: dateFormed)
        set(parkArea: area)
        set(parkLink: link)
        set(loc: location)
        set(imgLink: imageLink)
        set(descr: parkDescription)
        set(imageN: imageName)
        set(imageS: imageSize)
        set(imageT: imageType)
    }

    
    override var description: String {
        return "\n\tparkName: \(parkName) \n\tparkLocation: \(parkLocation) \n\tdateFormed: \(dateFormed) \n\tarea: \(area) \n\tlink: \(link) \n\tlocation: \(location) \n\timageLink: \(imageLink) \n\tparkDescription: \(parkDescription) \n\timageSize: \(imageSize) \n\timageType: \(imageType) \n\timageName: \(imageName)"
    }
    
    func getLocation() -> CLLocation {
        return location!
    }
    func set(loc: CLLocation!) {
        location = loc
    }
    func getImageLink() -> String {
        return imageLink
    }
    func set(imgLink: String) {
        imageLink = imgLink
    }
    func getParkDescription() -> String {
        return parkDescription
    }
    func set(descr: String) {
        parkDescription = descr
    }
    
    func getParkName() -> String {
        return parkName
    }
    func set(name: String) {
        let trimmedName = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) //trimming leading and ending white spaces 
        
        if(trimmedName.characters.count>3 && trimmedName.characters.count<75 && trimmedName.characters.count != 0 ) {
            parkName = name

        }else {
            parkName = "TBD"
            print("Bad value of \(name) in setParkName: setting to TBD")
        }
    }
    
    func getParkLocation() -> String {
        return parkLocation
    }
    func set(location: String) {
        let trimmedLocation = location.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) //trimming leading and ending white spaces

        if(trimmedLocation.characters.count>3 && trimmedLocation.characters.count<75  && trimmedLocation.characters.count != 0 ) {
            parkLocation = location
            
        }else {
            parkLocation = "TBD"
            print("Bad value of \(location) in setParkLocation: setting to TBD")
        }
    }
    
    func getDateFormed() -> String {
        return dateFormed
    }
    func set(date: String) {
        dateFormed = date
    }
    
    func getArea() -> String {
        return area
    }
    func set(parkArea: String) {
        area = parkArea
    }
    
    func getLink() -> String {
        return link
    }
    func set(parkLink: String) {
        link = parkLink
    }
    
    func set(imageT: String) {
        imageType = imageT
    }
    
    func set(imageS: String) {
        imageSize = imageS
    }
    
    func set(imageN: String) {
        imageName = imageN
    }
    
    func getImageSize() -> String {
        return imageSize
    }
    func getImageType() -> String {
        return imageType
    }
    func getImageName() -> String {
        return imageName
    }
    
}
