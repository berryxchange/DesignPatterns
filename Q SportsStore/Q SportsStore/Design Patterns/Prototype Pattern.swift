//
//  PrototypePattern.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/5/20.
//

import Foundation

//The Prototype Pattern
//The prototype pattern creates new objects by copying an existing object, known as the prototype.

//Benefit
//The main benefit is to hide the code that creates objects from the components that use them;
//this means that components don’t need to know which class or struct is required to create a new object,
//don’t need to know the details of initializers,
//and don’t need to change when subclasses are created and instantiated.

//This pattern can also be used to avoid repeating expensive initialization each time a new object of a specific type is created.


//How should you use this pattern?
//This pattern is useful when you are writing a component that needs to create new instances of objects without creating a dependency on the class initializer.


//Are there any common pitfalls?
//The main pitfall is selecting the wrong style of copying when cloning the prototype object. There are two kinds of copying available—shallow and deep—and it is important to select the correct kind for your application. See the “Understanding Shallow and Deep Copying” section for details.

//Are there any related patterns?
//The most closely related pattern is the object template pattern, which I describe in Chapter 4. Also see the singleton pattern, which provides a means by which a single object can be shared to avoid needing to create additional instances.


//--------- Understanding The Prototype Pattern --------

//The prototype pattern uses an existing object—rather than a class or struct—to create new objects. This is often referred to as cloning, since the new object is an identical copy of the existing one, including any changes made to the object’s stored properties that have been made since it was created.

//There are three operations in the prototype pattern.

//#1 First, the component that needs an object calls on the original object (known as the prototype) to copy itself.

//#2 The second operation is the copying process in which a new object (known as the clone) is created.

//#3 In the final operation, the prototype gives the calling component the clone, completing the copying process.
