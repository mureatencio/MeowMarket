//
//  CatCard.swift
//  MeowMarket
//

import NukeUI
import SwiftUI

// A view that handles laying out the details of a Cat from the API.
struct CatImageCard: View {
    let cat: Cat

    var body: some View {
        HStack(spacing: 16) {
            // LazyImage imported from Nuke library
            LazyImage(url: URL(string: "\(CatsAPI.baseUrl)/cat/\(cat.id)")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if phase.error != nil {
                    Image("outcoding-full")
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(cat.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(5)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
                Text(cat.mimetype) 
                    .padding(5)
                    .background(Color.primary)
                    .foregroundColor(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .font(.system(size: 12))
            }
            .font(.system(size: 15))

            Spacer()
        }
    }
}



#Preview {
    CatImageCard(
        cat: Cat(
            data: CatImageData(
                id: "123",
                mimetype: "image/jpeg",
                size: 12345,
                tags: ["cute", "funny"]
            )
        )
    )
}
