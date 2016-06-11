//: Playground - noun: a place where people can play

import UIKit


//🍺🍺🍺🍺/* calss and struc*/🍺🍺🍺🍺
print("\n-----/*calss and struc*/-----\n")
struct Members {
    var name: String?
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

/*struct A not subclass*/
// struct A:Member {
// 
// }


class Teams {
    var member: Members?
    var area: String?
    
    init(menber: Members, area: String) {
        self.member = menber
        self.area = area
    }
}

/*class B is subclass*/
// class B:Teams {
// 
// }

var myMember1 = Members(name: "Tony")
var myMember2 = myMember1
myMember2.name = "Leo"
myMember1.name = "NGhia"

print(myMember1.name) //Copy
print(myMember2.name)

/*Kêt luận Struct không phải là một kiểu tham chiếu , mà là tham trị . Hiểu một cách đơn giản là struct khi thực hiện phép gán thì <=> copy chính nó */

/**
 Các kiểu dữ Enum , String , Array , Dictionary trong swift đều là struct.
 
 */

let myTeam1 = Teams(menber: myMember1, area: "iOS")
let myTeam2 = myTeam1
myTeam2.area = "Android"

print(myTeam1.area) //Reference
print(myTeam2.area)

/*Class là kiểu tham chiếu*/

/*Đây chính là sự khác biệt lơn nhất của struct với class*/
print("\n-----/*End*/-----")

print("\n🍺🍺🍺🍺/Init - Designated vs convenience/🍺🍺🍺🍺\n")
struct MemberiOSC {
    var name: String
    var age: Int?
    // Trong struc mat dinh luon luon co mot ham dung mat dinh voi cac property cua struc do
    
    //khi chung ta muon viet lai ham dung khac thi chung ta phai bao dam rang cac property do phai duoc khoi tao
    // neu khong khoi tao gia tri cho no bat buoi property do phai la kieu optinoal (? !)
    
    //Designated
    init() {
        self.name = ""
        print("init kieu 1")
    }
    //Designated
    init(name: String) {
        self.name = name
        print("init kieu 2")
    }
}


let myMemberiOSC2 = MemberiOSC()
let myMemberiOSC3 = MemberiOSC(name: "Tony")

class TeamiOSC {
    var name: String
    var age: Int?
    var address: String?
    
    //Designated
    init(name: String) {
        self.name = name
    }
    
    //convenience
    convenience init(age: Int) {
        self.init(name: "Tony")
        self.age = age
    }
    //convenience
    convenience init(age: Int, address: String) {
        self.init(name: "Tony")
        self.age = age
        self.address = address
    }
    
    convenience init(name: String, age: Int, address: String) {
        self.init(age: age, address: address)
    }
}
[#Image(imageLiteral: "initializerDelegation02_2x.png")#]
print("\n🍺🍺🍺/*-----------------End--------------*/🍺🍺🍺🍺\n")

//🍺🍺🍺🍺/*store - computed - lazy - observer : Property*/🍺🍺🍺🍺
print("\n-----*store - computed - lazy - observer : Property*-----")
struct MembersiOS {
    var lastName: String // store property
    var fristName: String// store property
    var age: Int = 0
    var fullName: String { //computed property
        return "\(lastName) \(fristName)"
    }
    
    var address: String { //computed property set/get
        set (newAddress) {
            self.fullInfo = "My info: \n Address:\(newAddress) \n FristName:\(fristName) \n LastName:\(lastName) \n FullName:\(fullName) \n Age:\(age)"
        }
        get {
            return self.fullInfo ?? ""
        }
    }
    
    var fullInfo: String?

    var brithDay: String {
        set {
            let calendar = NSCalendar.currentCalendar()
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            let brithDate = dateFormater.dateFromString(newValue)
            let ageComponents = calendar.components(NSCalendarUnit.Year, fromDate: brithDate!, toDate: NSDate(), options: [])
            age = ageComponents.year
        }
        get {
            return "\(age)"
        }
    }
    
    init(lastName: String, fristName: String) {
        self.lastName = lastName
        self.fristName = fristName
        print("\nXin chao \(fristName)")
    }
    
}

var myMember = MembersiOS(lastName: "Tony", fristName: "Tuong")
print(myMember.brithDay)
myMember.brithDay = "08/07/1989"
print(myMember.brithDay)

print("----------")

myMember.address = "69 Ngo Thi Nham"
print(myMember.address)
print(myMember.fullInfo!)

print("\n-----*/Observer property*-----\n")

class TeamsiOS {
    
    lazy var member: MembersiOS? = MembersiOS(lastName: "Tony", fristName: "Tuong") //lazy property
    
    var area: String?
    
    //Observer property
    var notificationA: [String] = ["Cuoi buoi sang moi nguoi o lai hop","Chiu nay cong ty chung ta se di nhau"] {
        willSet {
            print("Chuan bi thong bao toi moi nguoi")
        }
        didSet {
            for member in listMembers! {
                print("Da thong bao toi :\(member.fullName)")
            }
            print("Tat ca da duoc thong bao")
        }
    }
    
    private var endTime: Bool = false
    
    var notificationB: [String] = ["Cuoi buoi sang moi nguoi o lai hop","Chiu nay cong ty chung ta se di nhau"] {
        willSet {
            print("\nChuan bi thong bao toi moi nguoi.\n")
            if self.endTime == true {
                print("Thong bao nay co van de , can xem lai......! :( \n")
                self.listMembers?.removeAll()
            }
        }
        didSet {
            print("oldValue \(oldValue)")
            print(self.notificationB)
            if self.notificationB.last != oldValue.last && self.listMembers?.isEmpty == false {
                for member in listMembers! {
                    print("Da thong bao toi :\(member.fullName)")
                }
                print("Tat ca da duoc thong bao.")
            } else {
                print("Thong bao nay da duoc thong bao lan truoc.")
            }
        }
    }
    
    private var listMembers: [MembersiOS]? = [
        MembersiOS(lastName: "Tony", fristName: "Tuong"),
        MembersiOS(lastName: "Marc", fristName: "Nghia"),
        MembersiOS(lastName: "Eric", fristName: "Dung"),
        MembersiOS(lastName: "Jeam", fristName: "Quy"),
        MembersiOS(lastName: "Leo", fristName: "Tuan Lon"),
        MembersiOS(lastName: "Vincent", fristName: "Tuan Nho")
    ]
    
    init(area: String) {
        self.area = area
    }
}

var myTeam = TeamsiOS(area: "iOS")

//Property Lazy : chi khoi tao mot lan duy nhat khi nao duoc try xuat toi.
myTeam.member
myTeam.member
myTeam.member

print(myTeam.member!.fristName)

myTeam.member = nil
//print(myTeam.member!.fristName)

//Property Observer
myTeam.notificationA = ["Cuoi tuan nay anh em se da bong"]

print("-------")

myTeam.endTime = true
myTeam.notificationB = ["Cuoi buoi sang moi nguoi o lai hop","Chiu nay cong ty chung ta se di nhau","Cuoi tuan nay anh em se da bong"]


myTeam.notificationB = []


print("\n🍺🍺🍺🍺/*-----------------End--------------*/🍺🍺🍺🍺\n")


print("\n🍺🍺🍺🍺/*weak , Strong  reference, Retain cycle*/🍺🍺🍺🍺\n")

class TeamiOSA {
    
    var area: String?
    init(area: String) {
        self.area = area
    }
    
    deinit {
        //hàm này sẽ được thực thi trước khi nó bị giải phóng vùng nhớ
        print("Hết giờ ,Team giai tan, nghi kheo 😬")
    }
}
/* Mặt định các property trong swift đều là strong nếu ta ko đinh nghĩa kiểu tham chiếu nó là weak*/

var myTeamiOSA:TeamiOSA? = TeamiOSA(area: "iOS") // retain count 1
var otherTeamiOS = myTeamiOSA //retain count 2

otherTeamiOS = nil
myTeamiOSA = nil
// retian count khong tang len - no chi anh xa toi object do
weak var weakTeam = myTeamiOSA // retian count vẫn là 2
weakTeam = nil
// weak la kieu tham chiu yeu khong tang retain count cho nen no hoan toan co the bi nil , vi vay chung bat buot phai khai bao no la var , not let

/*Cả 2 đều là kiểu reference*/
/*Hiểu đơn giản weak sẽ không làm tăng vùng nhớ , còn strong sẽ làm tăng vùng nhớ lên*/

print("\n🍺🍺🍺🍺/*Retain cycle*/🍺🍺🍺🍺\n")

class MemberiOSB {
   weak var team: TeamiOSB?
    
    deinit {
        print("Hết giờ ,Member giai tan, nghi kheo 😬")
    }
}

class TeamiOSB {
    var member: MemberiOSB?
    
    deinit {
        print("Hết giờ ,Team giai tan, nghi kheo 😬")
    }
}

var myTeamiOSB: TeamiOSB? = TeamiOSB()
myTeamiOSB?.member = MemberiOSB()
myTeamiOSB?.member?.team = myTeamiOSB

myTeamiOSB = nil // Retain cycle

/* myTeamiOSB?.member = nil

myTeamiOSB?.member?.team = nil */


// http://rypress.com/tutorials/objective-c/properties
/*Objective-C*/
/* 
 Atomic : It is the default behaviour. If an object is declared as atomic then it becomes thread-safe. Thread-safe means, at a time only one thread of a particular instance of that class can have the control over that object.
 
 Nonatomic
    nonatomic is used for multi threading purposes. If we  have set the nonatomic attribute at the time of declaration, then any  other thread wanting access to that object can access it and give  results in respect to multi-threading.
Copy
    copy is required when the object is mutable. Use this if  you need the value of the object as it is at this moment, and you don't  want that value to reflect any changes made by other owners of the  object. You will need to release the object when you are finished with  it because you are retaining the copy.
 
Assign
    Assign is somewhat the opposite to copy. When calling the getter of an assign  property, it returns a reference to the actual data. Typically you use  this attribute when you have a property of primitive type (float, int,  BOOL...)
 
Retain
    retain is required when the attribute is a pointer to an object. The setter generated by @synthesize  will retain (aka add a retain count to) the object. You will need to  release the object when you are finished with it. By using retain it  will increase the retain count and occupy memory in autorelease pool.
 
Strong
    strong is a replacement for the retain attribute, as  part of Objective-C Automated Reference Counting (ARC). In non-ARC code  it's just a synonym for retain.
    This is a good website to learn about strong and weak for iOS 5.
 
Weak
    weak is similar to strong except that it  won't increase the reference count by 1. It does not become an owner of  that object but just holds a reference to it. If the object's reference  count drops to 0, even though you may still be pointing to it here, it  will be deallocated from memory.
    The above link contain both Good information regarding Weak and Strong.
*/

print("\n🍺🍺🍺/*-----------------End--------------*/🍺🍺🍺🍺\n")


//🍺🍺🍺🍺/*optinoal ? , ! ,let , var/🍺🍺🍺🍺
print("\n🍺🍺🍺/*optinoal ? , ! ,let , var/🍺🍺🍺🍺\n")
class TestOptinoal {
    let address: String? = "" // nil ...v...v
    /*property là let thì phải có giá trị default bất kể là gì, nil ,null , int , string ....vvvvv*/
    var fristName: String!
    var lastName: String?
    // ? & ! deu co the = nil , khi dung ca 2 thi deu the tra ve nil , khi dung ? cho cac truong hop bat buoc phai co gia tri thi ta phai unwarp no ra,
    // con ! thi khong can unwarp no ra, nhung nó vẫn có thể trả về nil
    //unwarp property optional - ta co những cách thông thường như:
    func unwarp() {
        if let _ = fristName {
            print(address!)
        }
        if let myFristName = fristName {
            print(myFristName)
        }
        guard let myFristName = fristName else {
            print("property is nil")
            return
        }
        print(myFristName)
    }
}
print("\n🍺🍺🍺/*-----------------End--------------*/🍺🍺🍺🍺\n")

print("\n🍺🍺🍺/*-----------------Enum--------------*/🍺🍺🍺🍺\n")
enum Direction {
    case North, South, East, West
}

// We can easily switch between simple enum values
extension Direction: CustomStringConvertible {
    var description: String {
        switch self {
        case North: return "⬆️"
        case South: return "⬇️"
        case East: return "➡️"
        case West: return "⬅️"
        }
    }
}

let direction2 = Direction.North
print(direction2.description)

enum DirectionNew: String {
    case North, South, East, West
}

extension DirectionNew: CustomStringConvertible {
    var description: String {
        switch self {
        case North: return "⬆️"
        case South: return "⬇️"
        case East: return "➡️"
        case West: return "⬅️"
            
        }
    }
}

let direction1 = DirectionNew(rawValue: "South")
print(direction1!.description)

let directionNew = DirectionNew.South
print(directionNew.rawValue)
print(directionNew.hashValue)



enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(url: NSURL, title: String)
}

extension Media {
    var mediaTitle: String {
        switch self {
        case .Book(title: let aTitle, author: _, year: _):
            return aTitle
        case .Movie(title: let aTitle, director: _, year: _):
            return aTitle
        case .WebSite(url: _, title: let aTitle):
            return aTitle
        }
    }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "", year: 1870)
print(book.mediaTitle)

extension Media {
    var isFromJulesVerne: Bool {
        switch self {
        case .Book(title: _, author: let author, year: _) where author.isEmpty == false : return true // khong thoa dieu kien se return default value
        case .Movie(title: _, director: "Jules Verne", year: let year) where year > 1800 : return true
        default: return false
        }
    }
}
print(book.isFromJulesVerne)

let movie = Media.Movie(title: "", director: "", year: 1900)

print(movie.isFromJulesVerne)

