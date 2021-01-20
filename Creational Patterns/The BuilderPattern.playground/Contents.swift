import UIKit

protocol Article{
    var id: String { get set }
    var title: String { get set }
    var contents: String { get set }
    var author: String { get set }
    var date: Date  { get set }
    var views: Int { get set }
}


struct OldArticle: Article{
    var id: String
    
    var title: String
    
    var contents: String
    
    var author: String
    
    var date: Date
    
    var views: Int
}

extension OldArticle{
    
    class NewArticle{
        
        private var id: String?
        private var title: String?
        private var contents: String?
        private var author: String?
        private var date: Date = Date()
        private var views: Int = 0
        
        func set(id: String) -> NewArticle{
            self.id = id
            return self
        }
        func set(title: String) -> NewArticle{
            self.title = title
            return self
        }
        func set(contents: String) -> NewArticle{
            self.contents = contents
            return self
        }
        func set(author: String) -> NewArticle{
            self.author = author
            return self
        }
        func set(date: Date) -> NewArticle{
            self.date = date
            return self
        }
        func set(views: Int) -> NewArticle{
            self.views = views
            return self
        }
        
        // the important part of all..
        func build() -> OldArticle{
            let thisArticle = OldArticle(id: id!,
                                      title: title!,
                                      contents: contents!,
                                      author: author!,
                                      date: date,
                                      views: views)
            print(thisArticle)
            
            return thisArticle
            
            
        }
    }
}

// to chain data, use a class, not a struct
//declare all values as private optionals


// you can write this code globaly
//let builder = NewArticle.Builder()

// and these functions in every place you want to collect data to a single article: form, list, onboarding ...

let builder = OldArticle.NewArticle()

        builder.set(id: "648732UUID")

        builder.set(title: "The Little Engine That Could")

        builder.set(contents: "something about a lil train that shows his friends that he can do anything he puts his mind to!")

        builder.set(author: "Quinton Quaye")

        builder.set(date: Date())

        builder.set(views: 3)

        builder.build()

