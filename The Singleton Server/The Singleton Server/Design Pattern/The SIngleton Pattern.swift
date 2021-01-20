//
//  The SIngleton Pattern.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/7/20.
//

import Foundation

/*
What is it?
The singleton pattern ensures that only one object of a given type exists in the application.

What are the benefits?
The singleton pattern can be used to manage objects that represent real-world resources or to encapsulate a shared resource.

When should you use this pattern?
The singleton pattern should be used when creating further objects doesn’t increase the number of real-world resources available or when you want to consolidate an activity such as logging.

When should you avoid this pattern?
The singleton pattern isn’t useful if there are not multiple components that require access to a shared resource or if there are no objects that represent real-world resources in the application.

How do you know when you have implemented the pattern correctly?
The pattern has been correctly implemented when there is only one instance of a given type and when that instance cannot be copied and cloned and when further instances cannot be created.

Are there any common pitfalls?
The main pitfalls are using reference types (which can be copied) or classes that implement the NSCopying protocol (which can be cloned). The singleton pattern usually requires some protections against concurrent use, which is a common source of problems.

Are there any related patterns?
The object pool pattern, which I describe in Chapter 7, manages a fixed number of objects rather than the single object handled by the singleton pattern.
 
 
 The singleton pattern ensures that only one object of a given type exists and that all components that depend on that object use the same instance. This is different from the prototype pattern I described in Chapter 5, which makes it easy to make copies of objects. By contrast, the singleton pattern permits the existence of just one object and prevents it from being copied.
 
 The problem addressed by the singleton pattern arises when you have an object that you don’t want duplicated throughout an application, either because it represents a real-world resource (such as a printer or server) or because you want to consolidate a set of related activities in one place. When it comes to real-world resources, the ability to create new objects that represent printers or servers is nonsensical because creating an object doesn’t magically put new hardware into place.
 
 Even for more abstract representations, being able to create multiple objects can be a problem.
 
 The server and otherServer variables in the listing refer to the singleton, which means that all the
 DataItem objects are sent to the same server.
*/

//## see exampleSingletonOne



/*
Understanding the Shared Resource Encapsulation Problem
Not all of the objects that can benefit from the singleton pattern represent real-world objects. There will be occasions where you want to create an object that can be used by all of the components in an application in a simple and consistent way.
*/

/*
Understanding the Singleton Pattern
The singleton pattern solves both the real-world object and shared resource encapsulation problems by ensuring that there is only ever one instance of a class in an application. This object—known
as the singleton, is shared between all of the components that require its functionality.
 
 
 Implementing the Singleton Pattern
 When implementing the singleton pattern, there are some important rules to follow:
 #1 The singleton must be the only instance of its type that exists.
 #2 The singleton cannot be replaced by another object, even of the same type.
 #3 The singleton must be locatable by the components that need to use it.
 
 There can never be more than one instance of the singleton, either because the object represents real-world resources or because you want to funnel all activity, such as logging, through the same object.
 
 ## Note The singleton pattern works only with reference types, which means that only classes are supported. Structs and other values types don’t work because they are copied when they are assigned to a new variable. The only way to copy a reference type is to create a new instance via its initializer or to rely on it implementing the NSCopying protocol.
 
 The Quick Singleton Implementation
 The quickest way to implement the singleton is to use a Swift global constant. Global constants have some useful behaviors that set the foundation for following the rules I listed in the previous section.
 
 //## See logger.swift
 
 
 
 Creating a Conventional Singleton Implementation
 Using a global variable works perfectly well, but you will be used to the convention of accessing a singleton via its class if you have come to Swift from C# or Java. The problem is that Swift doesn’t support type stored properties, and some ingenuity is required to apply the singleton pattern in the conventional way. Next we will use a struct with a static property to solve the problem.
 
 
 Note The choice between a global constant and a nested struct is a personal one. I like the simplicity of the global variable, but years of Java and C# development mean that I am more comfortable with the nested struct. If you do use global constants, then make sure you use a naming convention that is unambiguous and consistent throughout your application.
 
 Within the computed type property server, I have defined a struct called SingletonWrapper that has a static stored property called singleton. I create the singleton BackupServer object and assign it to the singleton property. Finally, I return the value of the singleton property as the value of the server property.
 
  Do not worry if the last sentence doesn’t make immediate sense. This technique relies on the way that Swift processes struct definitions and static stored properties to ensure that only one instance of the BackupServer class is created, even though the code is a little mind-bending.
 
 ## see BackupServer - Nested Singleton
 
 To access the singleton, we read the value of the BackupServer.server property
 
 ## See viewController - exampleSingletonThree
 
 
 Dealing with Concurrency ## Check out GCD Project for help!
 
 If you are using a singleton in a multithreaded application, then you need to think through the consequences of different components performing simultaneous operations on the singleton and make sure you guard against any potential problems.
 
 Caution Effective concurrent programming requires careful thought and experience. It is easy to set out with the best of intentions but end up with an app that is substantially slower or freezes up. Take the time to learn the concepts that underpin concurrency before you embark on a multithreaded project, and give yourself enough development time to get the code right and to test thoroughly.
 
 
 Potential concurrency problems are common, and even our simple Logger and BackupServer classes have them because
 
 ##Swift arrays are not thread-safe. This means two more threads can call the append method on an array at the same time and corrupt the data structure.
 */




//-------------Tips -------------
/*You can apply the decorator pattern if you don’t have control over the class definition of the object
 that you need as a singleton in order to prevent an object from being treated like a prototype. See Chapter 14 for details.*/


/*Understanding the Shared Code File Pitfall
 The Swift access protection keywords operate at the file level, which means that applying the private keyword to an initializer affects only code outside of the file that contains the singleton. You should always define the singleton and the global constant if you are using one—in their own file so that no other component is able to create its own instances of the singleton class, which breaks the first singleton rule.
 
 
 Understanding the Concurrency Pitfalls
 The most intractable problems with the singleton pattern are related to concurrency, which can be a difficult topic even for experience programmers. In the sections that follow, I describe the most common problems.
 
 
 Not Applying Concurrency Protections
 The first problem is not applying concurrency protections when they are needed.
 
 Not every singleton faces concurrency problems, but it is something that you should give serious consideration to.
 
 If you are relying on shared data structures, such as arrays, or on global functions, such as print(), then you need to ensure that your singleton’s code cannot be accessed by multiple threads concurrently.
 
 If in doubt, assume that there will be a problem because the overhead of serializing access to shared resources is less of an issue than an app that crashed once it has been deployed to customers.
 
 
 Applying Concurrency Protections Consistently
 Concurrency protections must be applied throughout a singleton so that all of the code that operates on a common resource, such as an array, is serialized in the same way.
 
 If you leave just one method or block of code that accesses the array without serialization, then you run the risk of two threads conflicting and corrupting the data.
 
 If you are finding it hard to track down all of the code that modifies a shared resource,
 then you should reconsider the design of your code and extract the resource and the code that
 manipulates it into its own class so that you can apply concurrency protections
 in a more focused way.
 
 
 Bad Optimization
 There is a common belief that concurrency mechanisms like GCD offer poor performance and that concurrent protections should be low-level and applied minimally.
 
 I think this is nonsense.
 
 There are some applications where every CPU cycle counts, but these are few and far between,
 and the actual overhead of applying any concurrency even higher level abstractions
 like GCD—is minimal on modern operating systems.
 
 The perception of performance problems usually arises because concurrency protections expose poor code design.
 
 If you have 200 threads queuing up to access the same array,
 then you should consider whether the number of threads and the ratio of threads to arrays makes sense,
 rather than decide to start messing around with low level operating system locks.
 (One pattern that can help redress this kind of ratio is the object pool pattern,
 which I describe in Chapters 7 and 8.)*/

/*My advice is to use GCD because it is relatively simple to understand and easy to work with and makes good use of Swift closures. If you do have performance problems, then you should consider why this is the case and whether applying the patterns described in this book would allow you to minimize the points of contention in the application.*/
