//
//  CatsDataSource.swift
//  MeowMarket
//

import SwiftData

final class CatsDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = CatsDataSource()

    @MainActor
    private init() {
        self.modelContainer = {
            let schema = Schema([
                Cat.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        self.modelContext = modelContainer.mainContext
    }

    @MainActor
    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.modelContext = modelContainer.mainContext
    }
    
    func appendItem(item: Cat) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [Cat] {
        do {
            return try modelContext.fetch(FetchDescriptor<Cat>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: Cat) {
        modelContext.delete(item)
    }
}
