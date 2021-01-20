//
//  StoreData.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/2/20.
//

import Foundation

//Data Example 1
var exampleProductsOne = [
    ("Kayak",
     "A boat for one person",
     "Watersports",
     275.0,
     10
    ),
    
    ("Lifejacket",
     "Protective and fashionable",
     "Watersports",
     48.95,
     14
    ),
    
    ("Soccer Ball",
     "FIFA-approved size and weight",
     "Soccer",
     19.5,
     32
    ),
    
    ("Corner Flags",
     "Give your playing field a professional touch",
     "Soccer",
     34.95,
     1
    ),
    
    ("Stadium",
     "Flat-packed 35,000-seat stadium",
     "Soccer",
     79500.0,
     4
    ),
    
    ("Thinking Cap",
     "Improve your brain efficiency by 75%",
     "Chess",
     16.0,
     8
    ),
    
    ("Unsteady Chair",
     "Secretly give your opponent a disadvantage",
     "Chess",
     29.95,
     3
    ),
    
    ("Human Chess Board",
     "A fun game for the family",
     "Chess",
     75.0,
     2
    ),
    
    ("Bling-Bling King",
     "Gold-plated, diamond-studded King",
     "Chess",
     1200.0,
     4
    )
]

//Data Example 2
var exampleProducts = [
    
    ProductModel(
        productName: "Kayak",
        productDescription: "A boat for one person",
        productPrice: 275.0,
        productStock: 10,
        productCategory: "Watersports"
    ),
    
    ProductModel(
        productName: "Lifejacket",
        productDescription: "Protective and fashionable",
        productPrice: 48.95,
        productStock: 14,
        productCategory: "Watersports"
    ),
    
    ProductModel(
        productName: "Soccer Ball",
        productDescription: "FIFA-approved size and weight",
        productPrice: 19.5,
        productStock: 32,
        productCategory: "Soccer"
    ),
    ProductModel(
        productName: "Corner Flags",
        productDescription: "Give your playing field a professional touch",
        productPrice: 34.95,
        productStock: 1,
        productCategory: "Soccer"
    ),
    ProductModel(
        productName: "Stadium",
        productDescription:  "Flat-packed 35,000-seat stadium",
        productPrice: 79500.0,
        productStock: 4,
        productCategory: "Soccer"
    ),
    ProductModel(
        productName: "Thinking Cap",
        productDescription: "Improve your brain efficiency by 75%",
        productPrice: 16.0,
        productStock: 8,
        productCategory: "Chess"
    ),
    ProductModel(
        productName: "Unsteady Chair",
        productDescription: "Secretly give your opponent a disadvantage",
        productPrice: 29.95,
        productStock: 3,
        productCategory: "Chess"
    ),
    ProductModel(
        productName: "Human Chess Board",
        productDescription: "A fun game for the family",
        productPrice: 75.0,
        productStock: 2,
        productCategory: "Chess"
    ),
    ProductModel(
        productName: "Bling-Bling King",
        productDescription: "Gold-plated, diamond-studded King",
        productPrice: 1200.0,
        productStock: 4,
        productCategory: "Chess"
    ),
]


//Data Example 3
var exampleDecoupledProductModel = [
    
    DecoupledProductModel(
        productName: "Kayak",
        productPrice: 275.0,
        productStock: 10
    ),
    
    DecoupledProductModel(
        productName: "Lifejacket",
        productPrice: 48.95,
        productStock: 14
    ),
    
    DecoupledProductModel(
        productName: "Soccer Ball",
        productPrice: 19.5,
        productStock: 32
    ),
]


//Data Example 4
var exampleEncapsulatedProducts = [
    
    EncapsulatedProductModel(
        productName: "Kayak",
        productDescription: "A boat for one person",
        productPrice: 275.0,
        productStock: 10,
        productCategory: "Watersports"
    ),
    
    EncapsulatedProductModel(
        productName: "Lifejacket",
        productDescription: "Protective and fashionable",
        productPrice: 48.95,
        productStock: 14,
        productCategory: "Watersports"
    ),
    
    EncapsulatedProductModel(
        productName: "Soccer Ball",
        productDescription: "FIFA-approved size and weight",
        productPrice: 19.5,
        productStock: 32,
        productCategory: "Soccer"
    ),
]


//Data Example 5
var exampleCalculatedProducts = [
    
    CalculatedProductModel(
        productName: "Kayak",
        productPrice: 275.0,
        productStock: 10
    ),
    
    CalculatedProductModel(
        productName: "Lifejacket",
        productPrice: 48.95,
        productStock: 14
    ),
    
    CalculatedProductModel(
        productName: "Soccer Ball",
        productPrice: 19.5,
        productStock: 32
    ),
]


//Official Products

var exampleOfficialProducts = [
    OfficialProductModel(
        productName: "Kayak",
        productDescription: "A boat for one person",
        productCategory: "Watersports",
        productPrice: 275.0,
        productStockLevel: 10
    ),
    OfficialProductModel(
        productName: "Lifejacket",
        productDescription: "Protective and fashionable",
        productCategory: "Watersports",
        productPrice: 48.95,
        productStockLevel: 14
    ),
    OfficialProductModel(
        productName: "Soccer Ball",
        productDescription: "FIFA-approved size and weight",
        productCategory: "Soccer",
        productPrice: 19.5,
        productStockLevel: 32
    ),
    OfficialProductModel(
        productName: "Corner Flags",
        productDescription: "Give your playing field a professional touch",
        productCategory: "Soccer",
        productPrice: 34.95,
        productStockLevel: 1
    ),
    OfficialProductModel(
        productName: "Stadium",
        productDescription:  "Flat-packed 35,000-seat stadium",
        productCategory: "Soccer",
        productPrice: 79500.0,
        productStockLevel: 4
    ),
    OfficialProductModel(
        productName: "Thinking Cap",
        productDescription: "Improve your brain efficiency by 75%",
        productCategory: "Chess",
        productPrice: 16.0,
        productStockLevel: 8
    ),
    OfficialProductModel(
        productName: "Unsteady Chair",
        productDescription: "Secretly give your opponent a disadvantage",
        productCategory: "Chess",
        productPrice: 29.95,
        productStockLevel: 3
    ),
    OfficialProductModel(
        productName: "Human Chess Board",
        productDescription: "A fun game for the family",
        productCategory: "Chess",
        productPrice: 75.0,
        productStockLevel: 2
    ),
    OfficialProductModel(
        productName: "Bling-Bling King",
        productDescription: "Gold-plated, diamond-studded King",
        productCategory: "Chess",
        productPrice: 1200.0,
        productStockLevel: 4
    ),
]
