//
//  ProductInfoTable.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import SwiftUI

struct ProductInfoTable: View {
    var title: String
    var info: [[String]]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleLabel
                .padding(.top, 5)
            
            table
                .padding(.bottom, 5)
        }
    }
}

private extension ProductInfoTable {
    
    var titleLabel: some View {
        Text(title)
            .font(.workSans(14, .bold))
            .foregroundColor(.black)
    }
    
    var table: some View {
        VStack(spacing: 0) {
            ForEach(0..<info.count) { index in
                HStack(spacing: 0) {
                    Text(info[index][0])
                        .font(.workSans(14, .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                       
                    
                    Text(info[index][1])
                        .font(.workSans(14, .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                }
                .padding(.vertical, 10)
                .background(index % 2 == 0 ? Color.gray241 : .white)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ProductInfoTable_Previews: PreviewProvider {
    static var previews: some View {
        let info = Product.test.info.first!
        ProductInfoTable(title: info.title, info: info.info)
    }
}
