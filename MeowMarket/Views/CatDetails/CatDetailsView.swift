//
//  CatDetailsView.swift
//  MeowMarket
//

import SwiftUI
import NukeUI

struct CatDetailsView: View {
    @Bindable var viewModel: CatDetailsViewModel
    
    var body: some View {
        ScrollView{
            VStack {
                LazyImage(url: viewModel.imageUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Image("outcoding-full")
                            .resizable()
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 300, height: 300)
                .padding(.bottom)
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.cat.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(5)
                                    .background(Color.accentColor)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                    }
                }
                .font(.system(size: 15))
                .padding(.bottom)
                
                HStack{
                    Text("\(NSLocalizedString("MessageTitle", comment: "Message input title")):")
                        .frame(alignment: .leading)
                    TextField(NSLocalizedString("MessagePlaceholder", comment: "Message placeholder text"), text: $viewModel.text)
                        .textFieldStyle(.roundedBorder)
                }
                Toggle(NSLocalizedString("MonochromeMode", comment: "Monochrome mode toggle title"), isOn: $viewModel.isMonochrome)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("\(NSLocalizedString("FontSize", comment: "Font size slider title")): \(Int(viewModel.fontSize))")
                    Slider(value: $viewModel.fontSize, in: 50...150, step: 1) {
                        Text(NSLocalizedString("FontSize", comment: "Font size slider title"))
                    } minimumValueLabel: {
                        Text("50")
                    } maximumValueLabel: {
                        Text("150")
                    }
                }
                
                Button(NSLocalizedString("Generate", comment: "Generate button title")) {
                    viewModel.generateUrl()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .frame(alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    CatDetailsView(viewModel: CatDetailsViewModel(cat:
                                                    Cat(data: CatImageData(id: "123",
                                                                           mimetype: "image/jpeg",
                                                                           size: 123,
                                                                           tags: ["Cute",
                                                                                  "Orange"]))))
}
