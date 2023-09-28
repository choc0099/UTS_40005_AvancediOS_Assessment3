//
//  PropertyResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

enum ResultsViewType: String, Identifiable, CaseIterable {
    case list
    case map
    
    var id: Self {self}
}

import MapKit
struct PropertyResultsView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var region: NeighborhoodSearchResult
    // the @app storage is a quick way to save this setting to user defaults.
    @AppStorage("view_type") var viewType: ResultsViewType = .list
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                Picker("View type", selection: $viewType) {
                    ForEach(ResultsViewType.allCases) {
                        view in Text(view.rawValue.capitalized)
                    }
                }.pickerStyle(.segmented)
                Group {
                    if viewType == .list {
                        HotelRoomsResultsListView(roomSearchVM: roomSearchVM, region: region)
                    }
                    else if viewType == .map {
                        //this will take you to the map view.
                        //due to issues earlier with bindings, I had to pass these MKCoordinates code in this view insiead of the class object.
                                              
                        HotelPropertyResultsMapView(roomSearchVM: roomSearchVM, currentCoordinates: MKCoordinateRegion(center: .init(latitude: region.coordinates.latitude, longitude: region.coordinates.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                    }
                }.frame(maxHeight: .infinity)
                
            }
           
        }
    }
}

struct PropertyResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyResultsView(roomSearchVM: HotelPropertySearchViewModel(), region: NeighborhoodSearchResult(gaiaId: ""))
    }
}

