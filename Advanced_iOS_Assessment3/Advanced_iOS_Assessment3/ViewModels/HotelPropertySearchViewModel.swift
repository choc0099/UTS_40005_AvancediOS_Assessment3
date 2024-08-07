//
//  HotelPropertySearchViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//
//this is an enum that is used to handle errors based on user input
//it also is used to handle errors in rare cases where the room or children are not found.
enum QueryError: Error {
    case roomNotFound
    case noChildrenFound
    case numbersOfRoomsNotEntered
    case numbersOfAdultsNotEntered(roomNumber: Int)
}

import Foundation
import MapKit

//this is an obserable class to handle hotel rooms search queries.
class HotelPropertySearchViewModel: ObservableObject {
    @Published var propertyResultStatus: HotelStatus = .loading
    @Published var rooms: [Room] = []
    @Published var childrens: [Children] = []
    @Published var checkInDate: Date = Date.now
    @Published var checkOutDate: Date = Date.now
    //determines the numbers of rooms, children and adults
    @Published var propertyResults = [Property]()
    @Published var hotelResultsAnnotations: [HotelAnnotation] = []
    //this is used to configure search settings such as sorting and filtering properties.
    @Published var sort: SortPropertyBy = .recommended
    @Published var minPrice: Int = 300
    @Published var maxPrice: Int = 2000
    @Published var numbersOfResults: Float = 200.0
    //this is a computed property that stores property search preferences.
    var searchPref: PropertyListPreference {
        let price = PriceRequest(maximunPrice: maxPrice, minimunPrice: minPrice)
        return PropertyListPreference(numbersOfResults: Int(numbersOfResults), sort: sort, filter: Filters(price: price, accessibility: nil, travellerType: nil, amenities: nil, star: nil))
    }
    
    //calculates the total numbers of nights searched
    var numberOfNights: Int {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day], from: checkInDate, to: checkOutDate)
        return comp.day ?? 0
    }
    
    //this will calculate total numbers of adults from all rooms.
    var totalAdults: Int {
        var total = 0
        for room in rooms {
            total += room.adults
        }
        return total
    }
    
    //this will calculate total children
    var totalChildren: Int {
        var total = 0
        for room in rooms {
            total += room.children.count
        }
        return total
    }
    
    //these functions will add or remove rooms from the array.
    func incrementRooms() {
        self.rooms.append(Room(adults: 0, children: []))
    }

    func decrementRooms() {
        //retricts the range so it will not display negative number.
        if !rooms.isEmpty {
            self.rooms.removeLast()
        }
    }
    
    //appends the array of children inside the selected room
    func incrementChildren(currentRoomId: UUID) {
        //gets the actual refernce of the room to add children.
        if let index = self.rooms.firstIndex(where: {$0.id == currentRoomId}) {
            self.rooms[index].children.append(Children(age: 0))
        }
        
    }
    
    //this function removes the children from the array in a selected room that the user is in.
    func decrmentChildren(currentRoomId: UUID) {
        if let index = self.rooms.firstIndex(where: {$0.id == currentRoomId}) {
            if !self.rooms[index].children.isEmpty {
                //removes a child when decreasing it.
                self.rooms[index].children.removeLast()
            }
        }
    }
    //this updates the children age on the VM side
    func setChildrenAge(age: Int, roomId: UUID, childId: UUID) {
        //gets the allocated room from the array
        if let roomIndex = self.rooms.firstIndex(where: {$0.id == roomId}) {
            //gets the allocated child object from the array
            if let childIndex = self.rooms[roomIndex].children.firstIndex(where: {$0.id == childId}) {
                self.rooms[roomIndex].children[childIndex].age = age
                print("Age update from VM side test \(self.rooms[roomIndex].children[childIndex].age)")
            }
        }
    }
    
    //this function sets the value of numbers of adults in the selected room the user is in.
    func setAdults(roomId: UUID, numberOfAdults: Int) {
        //gets the index that matches the id of the room
        if let index = self.rooms.firstIndex(where: {$0.id == roomId}) {
            //sets the numbers of adults onto the vm.
            self.rooms[index].adults = numberOfAdults
        }
    }
    
    //this will get that specific room based on the id
    func findRoomById(roomId: UUID) throws ->  Room {
        if let haveRoom = self.rooms.first(where: {$0.id == roomId}) {
            return haveRoom
        }
        else {
            throw QueryError.roomNotFound
        }
    }
    
    //this returns the children object based on their id.
    func findChildrenById(roomId: UUID, childrenId: UUID) throws -> Children {
        if let roomIndex = self.rooms.firstIndex(where: {$0.id == roomId}) {
            if let index = self.rooms[roomIndex].children.firstIndex(where: {$0.id == childrenId}) {
                return self.rooms[roomIndex].children[index]
            }
            throw QueryError.noChildrenFound
        }
        
        else {
            throw QueryError.roomNotFound
        }
    }
    
    //this function returns a property object to make it easier to encode it into JSON.
    func createPropertyObject(metaData: MetaDataResponse?, gaiaId: String)  -> PropertyListRequest {
        //retreives metaData from the mainVM
        let metaDataAus = metaData?.australia
        //these are date components to convert the date structure to integers as it is used on the JSON structure.
        let checkOutDateComp = retrieveDateComp(date: checkOutDate)
        let checkInDateComp = retrieveDateComp(date: checkInDate)
        //creates the checkout and check in dates object
        let checkin = CheckInDate(typename: nil, day: checkInDateComp.day!, month: checkInDateComp.month!, year: checkInDateComp.year!)
        let checkout = CheckOutDate(typename: nil, day: checkOutDateComp.day!, month: checkOutDateComp.month!, year: checkOutDateComp.year!)
        //destination object.
        let dest = Destination(regionId: gaiaId, coordinates: nil)
        //builds this response so it can be encoded to JSON.
        let propertyQuery = PropertyListRequest(currency: "AUD", eapid: metaDataAus?.eapId, locale: metaData?.australia.supportedLocales[0].hotelSiteLocaleIdentifier, siteId: metaDataAus?.siteId, destination: dest, checkInDate: checkin, checkOutDate: checkout, rooms: rooms, sortAndFilterSettings: searchPref)
        return propertyQuery
    }
    
    //it is a helper function that returns a URLRequestObject with the JSON stuffs.
    func handleRequest(metaData: MetaDataResponse?, gaiaId: String) throws -> URLRequest {
        //generates the URL path.
        var urlComp = URLComponents(string: HotelAPIManager.apiUrl)!
        urlComp.path = HotelAPIManager.endPoints["listProperty"]!
        var request = try HotelAPIManager.hotelApi(urlStuffs: urlComp)
        request.httpMethod = "POST"
        //decodes the query object into JSON
        request.httpBody = try JSONEncoder().encode(createPropertyObject(metaData: metaData, gaiaId: gaiaId))
        return request
    }
    
    //this will send a POST request with JSON data to the server to get results to view hotels.
    func fetchResults(metaData: MetaDataResponse?, gaiaId: String) async {
        do {
            //retrieves the modified request method that is used to post the JSON object.
            let request = try handleRequest(metaData: metaData, gaiaId: gaiaId)
            //processes the request
            let (data, _) = try await URLSession.shared.data(for: request)
            //decodes the property results from the JSON response.
            let response = try JSONDecoder().decode(PropertyResponse.self, from: data)
            DispatchQueue.main.async {
                do {
                    //allocates the response stuff to this VM so it can be dispalyed to the user.
                    self.propertyResults = response.data.propertySearch.properties
                    
                    //sets the view to display results to the user after it is loaded
                    self.propertyResultStatus = .active
                    if self.propertyResults.isEmpty {
                        throw APIErrors.noSearchResults
                    }
                    //tests via printing output if it works
                    for property in self.propertyResults {
                        print("Id: \(property.id) Name: \(property.name) ")
                    }
                   
                } catch {
                    self.propertyResultStatus = .noResults
                }
            }
        }//catches an error if there are no results
        catch(APIErrors.noSearchResults) {
            self.propertyResultStatus = .noResults
        }
        //catches an error if there is no internet connection
        catch URLError.timedOut {
            self.propertyResultStatus = .requestTimeOut
            print("request timed out")
        }
        catch URLError.notConnectedToInternet {
            self.propertyResultStatus = .offline
            print("You are offline.")
        }
        catch {
            propertyResultStatus = .unkown
            print(error.localizedDescription)
            print(error)
        }
    }
    
    //this will validate the numbers of rooms and adults are correctly entered
    func validate() throws {
        guard !rooms.isEmpty else {
            throw QueryError.numbersOfRoomsNotEntered
        }
        
        //this is a counter to identify what romm number it is
        var counter = 1
        //checks if there are numbers of adults entered in each room
        for room in rooms {
            if !(room.adults > 0) {
                //throws an error
                throw QueryError.numbersOfAdultsNotEntered(roomNumber: counter)
            }
            counter += 1
        }
    }
    
    //this will convert the date object to date components to get an integer from day, month and year as a part of the JSON structure.
    private func retrieveDateComp(date: Date) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.day, .month, .year], from: date)
    }
    
    //this will convert the date integer fields back to the Date object
    private func convertToDateObject(day: Int, month: Int, year: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = day
        dateComp.month = month
        dateComp.year = year
        
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComp)!
    }
    
    //this will convert the properties into map annotations which will be used for map markers.
    func convertToAnnotations() {
        //looops through each property in the search results
        for property in propertyResults {
            //converts it to hotelAnnotations
            let annotation = getAnnotation(property: property)
            //appends the annotation onto the annotations array
            hotelResultsAnnotations.append(annotation)
        }
    }
    //helper function to get the indivdiual annotation.
    private func getAnnotation(property: Property) -> HotelAnnotation {
        return HotelAnnotation(property:  property)
    }
    
    //this function will save search prefernces including sort and filter settings, numbers of rooms, numbers of adults and children in each room, check in dates and check out dates to user defaults.
    func saveToUserDefaults(regionId: String, metaData: MetaDataResponse?) {
        UserDefaultsManager.savePropertySearchPrefernces(propertySearchPreferences: createPropertyObject(metaData: metaData, gaiaId: regionId))
    }
    
    //this function will load from user defaults and allocated to the VM so the user can access their saved prferences after reopening the app.
    func loadFromUserDefaults() {
        if let propertyRequest =  UserDefaultsManager.loadPropertySearchData() {
            //assigns it to the vm properties
            //decodes the dates.
            let propertyCheckInDate = propertyRequest.checkInDate
            checkInDate = convertToDateObject(day: propertyCheckInDate.day, month: propertyCheckInDate.month, year: propertyCheckInDate.year)
            let propertyCheckOutDate = propertyRequest.checkOutDate
            checkOutDate = convertToDateObject(day: propertyCheckOutDate.day, month: propertyCheckOutDate.month, year: propertyCheckOutDate.year)
            rooms = propertyRequest.rooms
            if let havePrice = propertyRequest.filters?.price {
                minPrice = havePrice.minimunPrice
                maxPrice = havePrice.maximunPrice
            }
            sort = propertyRequest.sort
            numbersOfResults = Float(propertyRequest.numbersOfResults)
            print("Property Search Prefernces loaded from user defaults")
        }
        else {
            print("No data loaded from user defaults.")
        }
        
    }
}
