//
//  CardData.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//

import Foundation

class CardData: ObservableObject {
    
    let cards_url = URL(string: "https://ios-project-f4371-default-rtdb.europe-west1.firebasedatabase.app/Cards.json")!
    
    @Published var cards: [Card] = []
    
    @Published var presentedCard : Card = Card(name: "nis", category: "nis", description: "nis", imageUrl: URL(string: "https://upload.wikimedia.org/wikipedia/en/2/2b/Yugioh_Card_Back.jpg")!, type: "egrgt", archetype: "fefeg", attribute: "fefe", rank: "0", attack: "0", defense: "0")
    
    @Published var yugiMutoDeck = ["593fkdkkdsllr","dnms9494fkfllf","vndr558fjjffkdkd","dmsiaa4m4m4mm","fmvrkoo5llflf","cndnvbferorklt5","fnoieforehohodekl4","f5954ksslslsff","fsni5u5kfdkfkfkfk","4fmreroo5imddd","45904kfdssldldf","dotni54ferrnar","coemiefirn5i00f","nvroeiro5ii5jfj","tetnausnu343igir4","h54moi5fejldfe","hfmereodoekowfrjie","hahhahah4h4fiejir","nfemormeiss44445","adrfriejfjerfrf445","djsi3j43fiuj4","nemofm4pof5mo454","cnir55foerkld","605i0edjd3kd3l","vmrvoi455foeiddkkd","am43i4fjo4fg","vmro545m4klgfmk","o595jgirjkdl","5454kfkkfksmkdsl","lb5k5grfeiofoe","vr5fmoemveifss","emvomo454ivmf","nivneivireino5","cmei4n4ifmkefe","feomroi5m4mvfonrd","wfiuen4n4u94vnkd","43fnreiuncisis","dmew48f8m5mfkdss","3fi4fn5fiuejs","fdmwivn4nifeuns","vonoe5ijrfinof","958ejfej04fgr"]

    @Published var setoKaibaDeck = ["lslwloo44lo5ogl","j59094jgkkgkgkgk","vner54l5gllglglgl","30203lflflflfl","j93jg54g5kglgllglglg","loololwolrf4k54","amammmvvnn44495k","mvmvmkro5o55lflfl","439043jfrfjj9ffkfk","43ji54j4kggllg50","90243fjifkrlf","dj98343fjkkgkkkgk","nsnuebub8i9094454g","vniuh549854gklwr","mvfiu545h4985jg4ki","059t685gj9ktg5","masm3i3j84jf8jf8","pto6o6lglglgo","akwod5k9gu8hg76","323o4ofkkfo55g","nedm4i455gl5lg5lo","5no4i595kgglll6","5koketgkl5ggl","vi55j95flfllfl","vm55fllfffoo","akk445oo5ll5lg","vm0505flflflflfl","vn5ifflllelrfr","v55mtlflsldlrlrg","5mfit4ot5igjkgf","vmj505gllttggllg","nvnr99jgijtigikt","i50ggltlgltgtg","pusigijfeorkofr4", "dni584g9kgklg","bkk35o5flfrg","gwok405k4lrelgg","mrpj549fk4gtllgt","msocj30043dfl","1304092kdwefkdwf5","vmron55940gkrllds","5493fj30d9jkss","D3354AFA-33CE-4F80-8712-9CF6DE2682FA","f4509jggklgglggl"]


    
    /*func getCards(id: String) -> [Card]{
        return cards.filter { card in
            if ( card.id == id )
                return card
        }
    }*/
    
    func getCards(inds: [String]) -> [Card]{
        return cards.filter { card in
            return inds.contains(card.id)
        }
    }
    
    func sendCard(card: Card) async
    {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(card)
            
            
            var request = URLRequest(url: cards_url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let (_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    
    func fetchCards() async
    {
        do {
            let (data, _) = try await URLSession.shared.data(from: cards_url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decoded_cards = try decoder.decode([String: Card].self, from: data)
            cards = [Card](decoded_cards.values)
        } catch let error {
            print(error)
        }
    }
}
