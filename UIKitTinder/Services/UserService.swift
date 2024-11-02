import Foundation

class UserService {
    
    // MARK: - Public Properties
    
    static let instance = UserService()
    let users: [User] = [
        User(
            id: 101,
            name: "Maria Silva",
            age: 19,
            match: true,
            description: R.string.localizable.mariaSilva(),
            image: R.image.pessoa1()
        ),
        User(
            id: 102,
            name: "Debora Lima",
            age: 25,
            match: false,
            description: R.string.localizable.deboraLima(),
            image: R.image.pessoa2()
        ),
        User(
            id: 103,
            name: "Sandra Souza",
            age: 24,
            match: false,
            description: R.string.localizable.sandraSouza(),
            image: R.image.pessoa3()
        ),
        User(
            id: 104,
            name: "Anna Beatriz",
            age: 22,
            match: true,
            description: R.string.localizable.annaBeatriz(),
            image: R.image.pessoa4()
        ),
        User(
            id: 105,
            name: "Laura Oliveira",
            age: 26,
            match: true,
            description: R.string.localizable.lauraOliveira(),
            image: R.image.pessoa5()
        ),
        User(
            id: 106,
            name: "Silva Paz",
            age: 19,
            match: false,
            description: R.string.localizable.silvaPaz(),
            image: R.image.pessoa6()
        ),
        User(
            id: 107,
            name: "Debora Lima",
            age: 25,
            match: false,
            description: R.string.localizable.deboraLima1(),
            image: R.image.pessoa7()
        ),
        User(
            id: 108,
            name: "Sandra Souza",
            age: 24,
            match: true,
            description: R.string.localizable.sandraSouza1(),
            image: R.image.pessoa8()
        ),
        User(
            id: 109,
            name: "Tah Beatriz",
            age: 22,
            match: false,
            description: R.string.localizable.tahBeatriz(),
            image: R.image.pessoa9()
        ),
        User(
            id: 110,
            name: "Laura Oliveira",
            age: 26,
            match: true,
            description: R.string.localizable.lauraOliveira1(),
            image: R.image.pessoa10()
        ),
        User(
            id: 111,
            name: "Sabrina Santos",
            age: 21,
            match: false,
            description: R.string.localizable.sabrinaSantos(),
            image: R.image.pessoa11()
        ),
        User(
            id: 112,
            name: "Amelia Margaret",
            age: 30,
            match: false,
            description: R.string.localizable.ameliaMargaret(),
            image: R.image.pessoa12()
        ),
        User(
            id: 113,
            name: "Laura Komako",
            age: 26,
            match: true,
            description: R.string.localizable.lauraKomako(),
            image: R.image.pessoa13()
        ),
        User(
            id: 114,
            name: "Rosa Oliveira",
            age: 25,
            match: false,
            description: R.string.localizable.rosaOliveira(),
            image: R.image.pessoa14()
        ),
        User(
            id: 115,
            name: "Nadia Joana",
            age: 20,
            match: false,
            description: R.string.localizable.nadiaJoana(),
            image: R.image.pessoa15()
        ),
        User(
            id: 116,
            name: "Mary Dandara",
            age: 20,
            match: false,
            description: R.string.localizable.maryDandara(),
            image: R.image.pessoa16()
        ),
        User(
            id: 117,
            name: "Anita Eleanor",
            age: 23,
            match: false,
            description: R.string.localizable.anitaEleanor(),
            image: R.image.pessoa17()
        ),
        User(
            id: 118,
            name: "Helen Aung San",
            age: 24,
            match: true,
            description: R.string.localizable.helenAungSan(),
            image: R.image.pessoa18()
        ),
        User(
            id: 119,
            name: "Laura Nelle",
            age: 18,
            match: false,
            description: R.string.localizable.lauraNelle(),
            image: R.image.pessoa19()
        ),
        User(
            id: 120,
            name: "Maria Virginia",
            age: 18,
            match: false,
            description: R.string.localizable.mariaVirginia(),
            image: R.image.pessoa20()
        )
    ]
    
    // MARK: - Public Methods
    
    func findUsers(completion: @escaping ([User]?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            DispatchQueue.main.async {
                completion(self.users, nil)
            }
        }
    }
}
