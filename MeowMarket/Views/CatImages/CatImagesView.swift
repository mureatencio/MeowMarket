//
//  CatImagesView.swift
//  MeowMarket
//

import SwiftUI
import SwiftData

// A view that displays a list of cat images, allowing the user to see a variety of cat pictures.
struct CatImagesView: View {

    // Defining bindable variable to hold the view model for the CatImagesView.
    @Bindable var viewModel = CatImagesViewModel()
    
    var body: some View {
        catImageList
            .navigationTitle(NSLocalizedString("Cats", comment: "Cats list title"))
            .task {
                viewModel.loadMoreContentIfNeeded(currentItem: nil)
            }
            .alert(NSLocalizedString("SomethingWentWrong", comment: "Error message title"), isPresented: $viewModel.state.errorFetching) {
                Button(NSLocalizedString("Ok", comment: "Ok button to close alert dialog"), role: .cancel) {
                    viewModel.state.errorFetching = false
                }
            } message: {
                Text(NSLocalizedString("ErrorFetchingCatsDetails", comment: "Error message trying to retrieve cats information"))
            }
    }
    
    
    // Indicates that the data is being fetched on initial load.
    private var loadingStatus: some View {
        HStack {
            Spacer()
            ProgressView()
                .padding(.trailing, 8)
            Text(NSLocalizedString("LoadingCatImages", comment: "Status message while information loads"))
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
    
    // The list of cat images to display.
    //
    private var catImageList: some View {
        List {
            if viewModel.state.fetchingData {
                loadingStatus
            }
            ForEach(viewModel.cats, id: \.id) { cat in
                NavigationLink(value: cat) {
                    CatImageCard(cat: cat)
                        .onAppear {
                            viewModel.loadMoreContentIfNeeded(currentItem: cat)
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .navigationDestination(for: Cat.self, destination: { cat in
            CatDetailsView(viewModel: CatDetailsViewModel(cat: cat))
        })
        .listStyle(InsetListStyle())
    }
    
}

