//
//  product_page.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 21.01.2022.
//

import SwiftUI
import UIKit

struct Page : View{
    var images : Array<Image>
    var mainImg : UIImage
    var productName : String
    var description : String
    var price : Int
    var body: some View{
        GeometryReader{ geometry in
                ZStack{
            ScrollView{
                VStack{
                    Text(productName)
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width, height: nil, alignment: .leading)
                        .padding(Edge.Set.leading,geometry.size.width*0.02)
        TabView{
            ForEach(0..<images.count){ num in
                images[num]
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.6), radius: 20, x: 20, y: 10)
                    .padding(Edge.Set.top,geometry.size.height*0.02)
                    .tag(num)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: nil, height: geometry.size.height*0.4, alignment: .center)
        .ignoresSafeArea(edges: Edge.Set.top)
                    Text("\(price) RUB")
                        .bold()
                        .font(.system(size: 25))
                    ScrollView{
                Text(description)
                    .frame(width: geometry.size.width, height: nil, alignment: .leading)
                    .padding(Edge.Set.top,geometry.size.height*0.02)
                    .padding(.leading,geometry.size.width*0.02)
                    }
                }

        }
                    ZStack{
                Rectangle()
                    .fill(.black)
                    .cornerRadius(10)
                    .frame(width: geometry.size.width*0.95, height: geometry.size.height*0.08, alignment: .center)
                        Text("В корзину")
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 28))
                    }
                        .position(x: geometry.size.width*0.5, y: geometry.size.height*0.95)
                        .onTapGesture {
                            cart.append(createCard())
                            print("Added to cart")
                            print(cart.count)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                            NotificationCenter.default.post(name: NSNotification.Name("reloadPrice"), object: nil)
                            UserDefaults.standard.setValue(getAllNames(array:cart), forKey: "cart")
                        }
                }
        }
    }
    func createCard() -> ProductCard{
        var result = ProductCard(name: productName, image: mainImg, shortdescription: description, frame: .zero, destinationPage: UIHostingController(rootView: self), price: price)
        return result
    }
}
