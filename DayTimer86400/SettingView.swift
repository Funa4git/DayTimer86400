//
//  SettingView.swift
//  DayTimer86400
//  
//  Created by Funa on 2022/04/16
//  
//

import SwiftUI

extension Color {
    static let twitterColor = Color("TwitterColor")
    static let youtubeColor = Color("YouTubeColor")
}

struct SettingView: View {
    @Environment(\.openURL) var openURL
    @Binding var isCenterText: Bool
    @Binding var isChangeFontSize: Bool
    @Binding var fontSizeVal: Double
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("書式設定")) {
                    Toggle(isOn: $isCenterText) {
                        Text("中央揃え")
                    }
                    Toggle(isOn: $isChangeFontSize) {
                        Text("文字サイズを変更")
                    }
                    if isChangeFontSize {
                        VStack {
                            Text("※表示が乱れる可能性があります。")
                                .multilineTextAlignment(.center)
                            Text("\(fontSizeVal, specifier: "%.0f")")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Slider(value: $fontSizeVal, in: 10...100, step: 5)
                                .padding(.horizontal)
                        }
                    }
                }
                
                Section(header: Text("Credit")) {
                    Text("原案・開発協力・Android版開発\n：IJK単位系")
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.white)
                            .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .background(Color.youtubeColor)
                            .cornerRadius(6)
                        Button("YouTube") {
                            openURL(URL(string:
                                            "https://www.youtube.com/channel/UC4RFIGaswZilD6n3YLAkTmA")!)
                        }
                    }
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.white)
                            .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .background(Color.twitterColor)
                            .cornerRadius(6)
                        Button("Twitter") {
                            openURL(URL(string:
                                            "https://twitter.com/ijk_tanikei")!)
                        }
                    }
                }
                
                Section(footer: VStack {
                    HStack {
                        Text("Version \(version)  Build \(build)")
                        Spacer()
                    }
                    HStack {
                        Text("©︎ 2022- IJK単位系 All Right Reserved.")
                        Spacer()
                    }
                    HStack {
                    }
                }) {
                    Text("iOS版開発・要望・問い合わせ\n：Funa")
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.white)
                            .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .background(Color.twitterColor)
                            .cornerRadius(6)
                        Button("Twitter") {
                            openURL(URL(string:
                                            "https://twitter.com/Fun4Channel")!)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
        .navigationTitle("設定")
    }
}

