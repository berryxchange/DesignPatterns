//
//  Template Pattern .swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/2/20.
//

import Foundation
//The object template pattern uses a class or struct to define a template from which objects are created. When an application component requires an object, it calls on the Swift runtime to create it by specifying the name of the template and any runtime initialization data values that are required to configure the object.

//There are three operations that make up the object template pattern
//#1 The first operation is the "Calling Component", asking the Swift Runtime to create an object,
    //  -providing the name of the template to use any runtime data values that are    reuired to customize the object that will be createed.
    
//#2 The Swift runtime allocated the memory required to store the object and uses the template to create it. Templates contain initializer methods that are used to prepare the object for use by setting its initial state, through either the runtime values supplied by the calling component or the values defined in the template, (or both) and

//#3 The Swift runtime calls the initializer to prepare the object for use.

//This three-step process can be repeated over and over again so that a single template can be used to create multiple objects.

//Classes and structs are both templates, which are the recipes that Swift follows for the object template pattern. Swift follows the instructions in the template to create new objects. The same template can be reused to create multiple objects. Each object is different, but it is created using the same instructions, just like a recipe can be used to create multiple cakes (add one Int, a method to change its value, and so on).

//The word instance has the same meaning as object, but it is used to refer to the name of the pattern used to create that object so that a Product object can also be called an instance of the Product class.

//The important point is that classes and structs are the instructions you write for the development of objects. When you change the value stored by an object, for example, it doesn’t change the pattern used to create it.

//** Check out your ProductModelTwo with Data Model of exampleProductsTwo


//-------------------The Benefit of Decoupling-------------------

//It doesn’t take advantage of the features that classes and structs provide, but it does allow us to demonstrate that even the simplest template reduces the impact of changes

//if data is changed in the model, the data will not affect the assciations which are cnnected to the modelObject

//** Check out your DecoupledProductModel with Data Model of exampleDecoupledProductModel


//-------------------The Benefit of Encapsulation-------------------

//The most important benefit from using classes or structs as templates for data objects is the support for encapsulation. Encapsulation is one of the core ideas behind object-oriented programming, and there are two aspects of this idea

//#1 The first aspect is that encapsulation allows data values and the logic that operates on those values to be combined in a single component. Combining the data and logic makes it easier to read the code because everything related to the data type is defined in the same place.

//The public presentation is the API that other components can use. Any component can get or set the values of the name, price, and stock properties and use them in any way they need. The public presentation also includes the stockValue property and the calculateTax method, but—and this is the important part—not their implementations.

//** Check out your EncapsulatedProductModel with Data Model of exampleEncapsulatedProducts


//---------------The Benefit of an Evolving Public Presentation---------------

//A nice feature of Swift is the way that you can evolve the public presentation of a class over time as the application changes. As matters stand, the stock property is a standard stored property that can be set to any Int value, but it doesn’t make sense to have a negative number of items in stock, and doing so will affect the result returned by the stockValue calculated property.

//Swift allows me to seamlessly replace the stock-stored property with a calculated property whose implementation can enforce a validation policy to ensure that the stock level is never less than zero.

//We define a backing variable that will hold the value of the stock property and have replaced the stored stock property with a calculated property that has a getter and setter. The getter simply returns the value of the backing property, which we have named stockBackingValue, but the setter uses the max function from the standard library to set the backing value to zero when a negative value is used to set the property. The effect of this change is that the public and private parts of the Product class have changed, but in a way that does not impact the code that uses the class


//** Check out your CalculatedProductModel with Data Model of exampleCalculatedProducts


//## Access Control

/*
 Swift takes an unusual approach to access control, which can catch out the unwary. There are three levels of access control, which are applied using the public, private, and internal keywords. The private keyword is the most restrictive; it restricts access to the classes, structs methods, and properties to code defined in the same file. Restricting access on a per-file basis is a different approach from most languages and means that private has no effect in Xcode playgrounds.
 
 The internal keyword denotes that access is allowed within the current module. This is the default level of access control that is used if no keyword is applied. For most iOS developers, internal protection will have the effect of allowing a class, struct, method, function, or property to be used throughout a project.
 
 The public keyword applies the least restrictive level of control and allows access from anywhere, including outside the current module. This is of most use to developers who are creating frameworks and who will need to use the public keyword to define the API that the framework presents to other developers.
 
 If you have moved to Swift from a language such as C# or Java, then you can most closely re-create the access controls you are used to by defining each class or struct in its own .swift file and using the private and internal access levels.
 */
