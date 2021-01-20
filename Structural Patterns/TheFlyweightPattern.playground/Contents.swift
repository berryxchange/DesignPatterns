import UIKit


//A Shopping list using the flyweight Pattern
// we'll need to identify the object that will be reused over and over in our flyweight pattern - Ingredient

struct Ingredient: CustomDebugStringConvertible{
    let name: String
    var debugDescription: String{
        return name
    }
}


//we will need an object that will manage the creation of those ingredient objects. As we are leveraging the flyweight pattern, we want to reduce the number of instancesof the Ingredient object:

struct IngredientManager{
    //The knownIngredients dictionary, will act a our object cache:
    
    private var knownIngredients = [String: Ingredient]()
    
    mutating func get(withName name: String) -> Ingredient{
        //check if we have already an instance
        guard let ingredient = knownIngredients[name] else{
            //register a new instance
            knownIngredients[name] = Ingredient(name: name)
            //Attempt to get again
            return get(withName: name)
        }
        return ingredient
    }
    
    var count: Int {
        return knownIngredients.count
    }
}


// the ingredients manager will act as our central store, it will contain all the instances of ingredients we'll ever need, and we'll be able to use it in our shopping list as follows:

struct ShoppingList: CustomDebugStringConvertible{
    private var list = [(Ingredient, Int)]()
    private var manager = IngredientManager()
    
    mutating func add(item: String, amount: Int = 1){
        let ingredient = manager.get(withName: item)
        list.append((ingredient, amount))
    }
    
    
    var debugDescription: String{
        return "\(manager.count) items: \n\n" + list.map{ (ingredient, value) in
            return "\(ingredient) (x\(value))"
        }.joined(separator: "\n")
    }
}


let items = ["Kale","Carots","Carots","Mushrooms","Bananas","Peanuts","Bread","Noodles","Onions","Lettuce","Salad Dressing"]
items.count
var shopping = ShoppingList()
items.forEach {
    shopping.add(item: $0)
}

print(shopping.debugDescription)




struct ShoppingItem{
    var name: String
    var price: Double
    var quantity: Int
}

struct ShoppingItemManager{
    private var knownItems = [ShoppingItem]()
    
    mutating func get(withItem item: ShoppingItem) -> ShoppingItem{
        //check if we have already an instance
        var shoppingItem = ShoppingItem(name: "", price: 0.0, quantity: 0)
        
        for i in knownItems{
            if item.name == i.name{
                shoppingItem = item
                print(item)
            }else{
                knownItems.append(item)
                shoppingItem = item
                print(item)
                return get(withItem: item)
            }
        }
        return shoppingItem
    }
    
    var count: Int {
        return knownItems.count
    }
}


struct NewShoppingList{
    private var list = [(ShoppingItem, Int)]()
    private var manager = ShoppingItemManager()
    
    mutating func add(item: ShoppingItem){
        let item = manager.get(withItem: item)
        list.append((item, item.quantity))
    }
    
    
    var debugDescription: String{
        return "\(manager.count) items: \n\n" + list.map{ (item, value) in
            return "\(item) (x\(value))"
        }.joined(separator: "\n")
    }
}

let sList: [ShoppingItem] = [
    ShoppingItem(name: "Kale", price: 2.45, quantity: 1),
    ShoppingItem(name: "Carrots", price: 3.55, quantity: 4),
    ShoppingItem(name: "Mushrooms", price: 1.99, quantity: 2)
    ]

sList.count
var SIShopping = NewShoppingList()

sList.forEach {
    SIShopping.add(item: $0)
    print($0)
}

print(SIShopping.debugDescription)
