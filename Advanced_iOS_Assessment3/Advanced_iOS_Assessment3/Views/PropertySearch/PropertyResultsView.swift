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

struct PropertyResultsView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var region: NeighborhoodSearchResult!
    // the @app storage is a quick way to save this setting to user defaults.
    @AppStorage("view_type") var viewType: ResultsViewType = .list
    var body: some View {
        NavigationStack {
            VStack {
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
                        HotelPropertyResultsMapView(roomSearchVM: roomSearchVM, region: region)
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

