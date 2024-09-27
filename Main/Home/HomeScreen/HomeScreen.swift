//
//  ContentView.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import SwiftUI

struct HomeScreenConstants {
    static let rectangleHeight: CGFloat = 300
    static let rectangleCornerRadius: CGFloat = 10
    static let borderLineWidth: CGFloat = 4
    static let textBorderLineWidth: CGFloat = 2
}

struct HomeScreen: View {
    
    @StateObject var viewModel = HomeScreenViewModel(networkService: NetworkCallRequest())
    
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    
    var body: some View {
        NavigationView{
            VStack {
                headerView
                
                ScrollView {
                    contentGrid
                }
            }
            .onAppear {
                viewModel.getData()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.black.opacity(0.9).ignoresSafeArea())
        }
    }
    
    var headerView: some View {
        Text("Movie Fy")
            .foregroundStyle(.indigo)
            .bold()
            .font(.largeTitle)
    }
    
    var contentGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(viewModel.movies, id: \.self) { item in
                contentCell(movie: item)
            }
            
            .padding(4)
        }
    }
    
    func contentCell(movie: Result) -> some View {
        VStack {
            rectangleView(movie: movie)
            textView(title: movie.title)
            Spacer()
        }
        .padding(.bottom, 10)
    }
    
    func rectangleView(movie: Result) -> some View {
        NavigationLink(destination: DetailScreen()) {
            Group {
                if let imageUrl = viewModel.getPoster(for: movie) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .padding(-10)
                            .frame(height: HomeScreenConstants.rectangleHeight)
                            .cornerRadius(HomeScreenConstants.rectangleCornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: HomeScreenConstants.rectangleCornerRadius)
                                    .stroke(Color.gray, lineWidth: HomeScreenConstants.borderLineWidth)
                            )
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: HomeScreenConstants.rectangleHeight)
                            .cornerRadius(HomeScreenConstants.rectangleCornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: HomeScreenConstants.rectangleCornerRadius)
                                    .stroke(Color.gray, lineWidth: HomeScreenConstants.borderLineWidth)
                            )
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: HomeScreenConstants.rectangleHeight)
                        .cornerRadius(HomeScreenConstants.rectangleCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: HomeScreenConstants.rectangleCornerRadius)
                                .stroke(Color.gray, lineWidth: HomeScreenConstants.borderLineWidth)
                        )
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    func textView(title: String) -> some View {
        Text(title)
            .bold()
            .font(.title3)
            .underline()
            .foregroundStyle(
                .linearGradient(
                    colors: [.red, .yellow],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .padding()
            .background(Color.clear)
            .cornerRadius(HomeScreenConstants.rectangleCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: HomeScreenConstants.rectangleCornerRadius)
                    .stroke(Color.indigo, lineWidth: HomeScreenConstants.textBorderLineWidth)
            )
    }
}

#Preview {
    HomeScreen()
}
