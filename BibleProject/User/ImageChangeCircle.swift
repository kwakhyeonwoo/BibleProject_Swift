//
//  ImageChangeCircle.swift
//  BibleProject
//
//  Created by 곽현우 on 8/7/24.
//

//import SwiftUI
//
//struct ImageChangeCircle: View {
//    //변경될 배경색
//    @State private var selectedColor: Color = .blue
//    //원의 지름
//    let circleSize: CGFloat = 40
//    //곡선 원의 개수
//    let numberOfCircles = 5
//    
//    var body: some View {
//        VStack {
//            GeometryReader { geometry in
//                let width = geometry.size.width
//                // 곡선을 위로 올리기 위해 높이의 절반을 사용
//                let height = geometry.size.height / 2
//                
//                // 직선, 곡선시 Path구조체 사용
//                Path { path in
//                    //경로 시작점
//                    path.move(to: CGPoint(x: 0, y: 0))
//                    //시작점에서 곡선을 그려 width로 이동, 제어는 control로 하며 control을 기준으로 곡선을 만듦
//                    path.addQuadCurve(to: CGPoint(x: width, y: 0),
//                                      control: CGPoint(x: width / 2, y: height))
//                }
//                // 곡선을 보이지 않게 설정
//                .stroke(Color.clear)
//                
//                // 곡선을 따라 버튼을 배치합니다.
//                ForEach(0..<numberOfCircles, id: \.self) { i in
//                    let t = CGFloat(i) / CGFloat(numberOfCircles - 1)
//                    let x = width * t
//                    let y = height * (1 - t) * t * 4 // 곡선에 따라 y 위치를 계산
//                    
//                    Button(action: {
//                        // 버튼 클릭 시 배경색을 변경
//                        selectedColor = Color(
//                            hue: Double(i) / Double(numberOfCircles),
//                            saturation: 0.8,
//                            brightness: 0.8
//                        )
//                    }) {
//                        Circle()
//                            .frame(width: circleSize, height: circleSize)
//                            .foregroundColor(.blue)
//                    }
//                    .position(x: x, y: height - y) // 곡선이 위쪽으로 보이게 반전
//                }
//            }
//            .frame(height: 200)
//            
//            // 선택된 색상에 따라 배경색을 변경
//            Rectangle()
//                .fill(selectedColor)
//                .frame(height: 100)
//                .cornerRadius(10)
//                .padding()
//        }
//    }
//}
//
//#Preview {
//    ImageChangeCircle()
//}
