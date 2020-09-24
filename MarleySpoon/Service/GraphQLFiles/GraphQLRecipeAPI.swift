// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AllRecipesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllRecipes {
      recipeCollection {
        __typename
        items {
          __typename
          title
          description
          chef {
            __typename
            name
          }
          tagsCollection {
            __typename
            items {
              __typename
              name
            }
          }
          photo {
            __typename
            title
            description
            contentType
            fileName
            size
            url
            width
            height
          }
        }
      }
    }
    """

  public let operationName: String = "AllRecipes"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("recipeCollection", type: .object(RecipeCollection.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(recipeCollection: RecipeCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "recipeCollection": recipeCollection.flatMap { (value: RecipeCollection) -> ResultMap in value.resultMap }])
    }

    public var recipeCollection: RecipeCollection? {
      get {
        return (resultMap["recipeCollection"] as? ResultMap).flatMap { RecipeCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "recipeCollection")
      }
    }

    public struct RecipeCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RecipeCollection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]) {
        self.init(unsafeResultMap: ["__typename": "RecipeCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Recipe"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("chef", type: .object(Chef.selections)),
            GraphQLField("tagsCollection", type: .object(TagsCollection.selections)),
            GraphQLField("photo", type: .object(Photo.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, description: String? = nil, chef: Chef? = nil, tagsCollection: TagsCollection? = nil, photo: Photo? = nil) {
          self.init(unsafeResultMap: ["__typename": "Recipe", "title": title, "description": description, "chef": chef.flatMap { (value: Chef) -> ResultMap in value.resultMap }, "tagsCollection": tagsCollection.flatMap { (value: TagsCollection) -> ResultMap in value.resultMap }, "photo": photo.flatMap { (value: Photo) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var chef: Chef? {
          get {
            return (resultMap["chef"] as? ResultMap).flatMap { Chef(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "chef")
          }
        }

        public var tagsCollection: TagsCollection? {
          get {
            return (resultMap["tagsCollection"] as? ResultMap).flatMap { TagsCollection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "tagsCollection")
          }
        }

        public var photo: Photo? {
          get {
            return (resultMap["photo"] as? ResultMap).flatMap { Photo(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "photo")
          }
        }

        public struct Chef: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Chef"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Chef", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct TagsCollection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["RecipeTagsCollection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(items: [Item?]) {
            self.init(unsafeResultMap: ["__typename": "RecipeTagsCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var items: [Item?] {
            get {
              return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
            }
          }

          public struct Item: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Tag"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Tag", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }

        public struct Photo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Asset"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("contentType", type: .scalar(String.self)),
              GraphQLField("fileName", type: .scalar(String.self)),
              GraphQLField("size", type: .scalar(Int.self)),
              GraphQLField("url", type: .scalar(String.self)),
              GraphQLField("width", type: .scalar(Int.self)),
              GraphQLField("height", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(title: String? = nil, description: String? = nil, contentType: String? = nil, fileName: String? = nil, size: Int? = nil, url: String? = nil, width: Int? = nil, height: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Asset", "title": title, "description": description, "contentType": contentType, "fileName": fileName, "size": size, "url": url, "width": width, "height": height])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          public var contentType: String? {
            get {
              return resultMap["contentType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "contentType")
            }
          }

          public var fileName: String? {
            get {
              return resultMap["fileName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fileName")
            }
          }

          public var size: Int? {
            get {
              return resultMap["size"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "size")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }

          public var width: Int? {
            get {
              return resultMap["width"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "width")
            }
          }

          public var height: Int? {
            get {
              return resultMap["height"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "height")
            }
          }
        }
      }
    }
  }
}
