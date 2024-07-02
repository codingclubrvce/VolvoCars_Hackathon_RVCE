#Harsh Gupta XII-E Morning 07-0554
#Student Library Management System

#Creating text Files Used in the project
ADM_Fin = open("F:\\Project\\Admin.txt", "a") #File containing Admin Login details
STD_Fin = open("F:\\Project\\Student.txt", "a") #File containing Student Login details
LIB_Fin = open("F:\\Project\\Library.txt", "a") #File containing details of books available in the Library
BOOK_Fin = open("F:\\Project\\Books.txt", "a") #File containing details of book issued to students
#Txt Files ar created now
#Closing files for now, to be able to open them in appropriate modes later on in the function
ADM_Fin.close()
STD_Fin.close()
LIB_Fin.close()
BOOK_Fin.close()
#Fucntions

#Access to be provided, ADMIN or STUDENT for their repective powers
Access = 'NIL'
def Admin_login():
    global Access
    print("Please login into your admin account")
    option = input("Enter \'c\' for creating new account and \"l\" for logging into existing one: ")
    if option == 'c' or option == 'C':
        USN = input("Choose new Username: ")
        PWD = input("Choose new Password: ")
        ADM_Fin = open("F:\\Project\\Admin.txt", "a") #Append Mode
        ADM_Fin.write(USN + ',' + PWD + '\n')
        ADM_Fin.close()
        print("Account created succesfully. Admin logged in")
        Access = "ADMIN" #ADMIN ACCESS to be required for admin to be able to perform admin tasks
    elif option == 'l' or option == 'L':
        USN = input("Enter your Username: ")
        PWD = input("Enter Password: ")      
        ADM_Fin = open("F:\\Project\\Admin.txt", "r") #Read Mode
        Line = " " #Blank space, NOT a null string
        while Line:
            Line = ADM_Fin.readline()
            L = Line.split(',')
            if L[0] == USN and L[1] == (PWD + '\n'): #Added '\n' to Pssword to maintain its equality after spiltting
                print("Login Succesful")
                Access = "ADMIN" #ADMIN ACCESS to be required for admin to be able to perform admin tasks
                break
        else: #LOOP-Else
            print("Invalid Credentials")
        ADM_Fin.close()
    else: print("Invalid option") #option for admin login

def Add_Books(): #Adding books to the library
    global Access
    if Access != "ADMIN": #Only Admin can add books to the Library
        print("You must be admin to perform this task")
    else:
        print("Enter details of book to be added....")
        book = input("Enter name of the book: ")
        author = input("Enter name of author: ")
        Book_ID = input("Enter the unique 6-digit alphanumeric code: ")
        copies = input("Enter number of copies of book: ")
        LIB_Fin = open("F:\\Project\\Library.txt", "a") #Append Mode
        LIB_Fin.write(book + ',' + author + ',' + Book_ID + ',' + copies + '\n')
        LIB_Fin.close()

def View_Books():
    #No Access required as both students and admin can view details of books avaialble in library
    LIB_Fin = open("F:\\Project\\Library.txt", "r")
    print("Printing the details of the books available in the llibrary in a tabular form")
    print("Book\tAuthor\tBook ID\tCopies\n") #tab escape sequence between book, author, copies
    s = " " #Blank space, NOT a null string
    while s:
        s = LIB_Fin.readline()
        if s == '': break
        L = s.split(",")
        Record = "\t".join(L) #Joining the book, author and copies with a tab character for better printing
        #Please note here that the string "Record" will end with a "/n" character
        print(Record, end = '') #end = '' is used so that there isn't 2 Line's gaps between every book's details
    LIB_Fin.close()

def Modify_Books(): #Modify number of copies of a book
    global Access
    if Access != "ADMIN": #Only Admin can add books to the Library
        print("You must be admin to perform this task")
    else:
        Book_ID = input("Enter the unique 6-digit alphanumeric code of the book you want to edit: ")
        LIB_Fin = open("F:\\Project\\Library.txt", "r")
        Temp = open("F:\\Project\\Temp.txt", "w")
        s = " " #Blank space, NOT a null string
        while True:                        
            s = LIB_Fin.readline()
            if s == '': break
            L = s.split(",")
            if L[2] == Book_ID:                
                CPs = input("Enter the new number of copies left of that book: ")
                copies = CPs + '\n'
                L[3] = copies
                Record = ','.join(L)
                Temp.write(Record)
            else:                
                Temp.write(s)
        Temp.flush()
        Temp.close()
        LIB_Fin.close()
        os.remove("F:\\Project\\Library.txt")
        os.rename("F:\\Project\\Temp.txt", "F:\\Project\\Library.txt")

def Student_login():
    global Access
    option = input("Enter \'c\' for creating new account (registering) and \"l\" for logging into existing one: ")
    if option == 'c' or option == 'C':
        Name = input("Enter name: ")
        Class = input("Enter class: ")
        USN = input("Choose new Username: ")
        PWD = input("Choose new Password: ")
        STD_Fin = open("F:\\Project\\Student.txt", "a") #Append Mode
        STD_Fin.write(Name + ',' + Class + ',' + USN + ',' + PWD + '\n')
        STD_Fin.close()
        print("Account created succesfully. Student logged in")
        Access = "STUDENT"
    elif option == 'l' or option == 'L':
        USN = input("Enter your Username: ")
        PWD = input("Enter Password: ")
        STD_Fin = open("F:\\Project\\Student.txt", "r") #Read Mode
        Records = STD_Fin.readlines() #Readlines
        for Line in Records:
            L = Line.split(',')
            if L[2] == USN and L[3] == (PWD + '\n'): #Added '\n' to Pssword to maintain its equality after spiltting
                print("Login Succesful")
                Access = "STUDENT"
                break
        else:
            print("Invalid Credentials")
        ADM_Fin.close()
    else: print("Invalid option") #option for student login
    
def Logout(): #Function for letting the current person to log out
    global Access
    if Access == 'NIL':
        print("You are already logged out....")
    else:
        Access = 'NIL'
        print("Logged out succesfully")

def Book_Search():
    global Access
    person = input("Enter \'A\' if you are a Admin and \'S\' if you are a student: ")
    if person == 'A'or person == 'a':
        if Access != "ADMIN":
            print("You must be admin to perform this task")
        else:
            Book = input("Enter the name of the book you want to search: ")
            LIB_Fin = open("F:\\Project\\Library.txt", "r")
            Records = LIB_Fin.readlines() #Readlines
            for s in Records:
                L = s.split(",")
                if L[0] == Book:
                    print("Book name:", L[0])
                    print("Author name:", L[1])
                    print("Number of copies left:", L[3][:-1]) #Removing the "\n" from the number of copies
                    print("Unique book ID:", L[2])
                    break
            else:
                print("No results found for that book")
            LIB_Fin.close()
    elif person == 'S' or person == 's':
        if Access != "STUDENT":
            print("You must be student to perform this task")
        else:
            Book = input("Enter the name of the book you want to search: ")
            LIB_Fin = open("F:\\Project\\Library.txt", "r")
            Records = LIB_Fin.readlines() #Readlines
            for s in Records:
                L = s.split(",")
                if L[0] == Book:
                    print("Book name:", L[0])
                    print("Author name:", L[1])
                    if int(L[3]) > 0: #Not telling the students the number of copies available
                        print("Copies Available")
                    else:
                        print("Sorry, no copies of", Book, "are available right now")
                    break
            else:
                print("No results found for that book")
            LIB_Fin.close()
    else: print("Invalid option")

def Issue_Book():
    global Access
    if Access != "STUDENT":
        print("You must be student to perform this task")
    else:
        BN = input("Enter the name of the book: ")
        AN = input("Enter the name of the author: ")
        LIB_Fin = open("F:\\Project\\Library.txt", "r")
        s = " " #Blank space, NOT a null string
        while s:
            s = LIB_Fin.readline()
            L = s.split(",")
            if L[0] == BN:
                N = int(L[3][:-1])
                ID = L[2]
                break
        LIB_Fin.close()
        if N == 0:
            print("Book not available")
        else:
            print("Book available!")
            NM = input("Enter your name to issue the book: ")
            print("Enter the date of issue of the book in the format DD/MM/YY (eg. 31/12/2021)")
            DOI = input()
            print("Enter the date of return of the book in the format DD/MM/YY (eg. 31/12/2021)")
            DOR = input()
            BOOK_Fin = open("F:\\Project\\Books.txt", "a") #Append mode
            BOOK_Fin.write(BN + ',' + AN + ',' + ID + ',' + NM + ',' + DOI + ',' + DOR + '\n')
            BOOK_Fin.close()
             #Now decreasing the number of books in the Library by 1
            LIB_Fin = open("F:\\Project\\Library.txt", "r")
            Temp = open("F:\\Project\\Temp.txt", "w")
            s = " " #Blank space, NOT a null string
            while True:            
                s = LIB_Fin.readline()
                if s == '': break
                L = s.split(",")
                if L[2] == ID:                
                    copies = str(N - 1) + '\n' #Decreased by 1
                    L[3] = copies
                    Record = ','.join(L)
                    Temp.write(Record)
                else:                
                    Temp.write(s)               
            Temp.flush()
            Temp.close()
            LIB_Fin.close()
            os.remove("F:\\Project\\Library.txt")
            os.rename("F:\\Project\\Temp.txt", "F:\\Project\\Library.txt")

def View_Issued_Books():
    global Access
    if Access != "ADMIN": #Only Admin can add books to the Library
        print("You must be admin to perform this task")
    else:
        BOOK_Fin = open("F:\\Project\\Books.txt", "r")
        print("Printing the details of the issued books in a tabular form")
        print("Book\tAuthor\tBook ID\tStudent\tIssue Date\tReturn Date\n")
        #tab escape sequence between book, author, copies
        s = " " #Blank space, NOT a null string
        while s:
            s = BOOK_Fin.readline()
            if s == '': break
            L = s.split(",")
            Record = "\t".join(L)
            print(Record, end = '')
        BOOK_Fin.close()

def Get_Fine():
    global Access
    if Access != "STUDENT":
        print("You must be student to perform this task")
    else:
        BOOK_Fin = open("F:\\Project\\Books.txt", "r")
        B_Name = input("Enter book name: ")
        S_Name = input("Enter student name: ")
        s = " " #Blank space, NOT a null string
        while s:
            s = BOOK_Fin.readline()
            if s == '': break
            L = s.split(",")
            if L[0] == B_Name and L[3] == S_Name:
                break
        BOOK_Fin.close()
        print("The Date of issue of the book is", L[4])
        print("The Date of actual return of the book is", L[5][:-1])

        #Now calculate the fine
        Days = int(input("Enter the number of days of the book return's delay: "))
        Rate = int(input("Enter the Rate of late fine (in rupees) per day: "))
        Fine = Days*Rate
        print("Your fine is Rs.", Fine)

def Return_Issued_Book():
    global Access
    if Access != "STUDENT":
        print("You must be student to perform this task")
    else:
        NM = input("Enter your name: ")
        B_NM = input("Emter the name of the book you have to return: ")
        Validity = 'No'
        BOOK_Fin = open("F:\\Project\\Books.txt", "r")
        Temp = open("F:\\Project\\Temp.txt", "w")
        Records = BOOK_Fin.readlines() #Readlines
        for s in Records:
            L = s.split(",")
            if L[0] == B_NM and L[3] == NM:
                Validity = 'Yes'
                continue
            else:                
                Temp.write(s)
        Temp.flush()
        Temp.close()
        BOOK_Fin.close()
        os.remove("F:\\Project\\Books.txt")
        os.rename("F:\\Project\\Temp.txt", "F:\\Project\\Books.txt")
        if Validity == 'No': print("No such book", B_NM, "is issued for", NM)
        elif Validity == 'Yes': print("Book Returned Succesfully. Thankyou....")
    
#Functions Done
#MAIN CODE Now

#Menu of options
#Using Pretty Printing of dictionary
import json
import os
Menu = {}
Menu['1'] = 'Login'
Menu['2'] = 'Add Books in Library'
Menu['3'] = 'View Books in Library'
Menu['4'] = 'Modify Books in Library'
Menu['5'] = 'Searching Book'
Menu['6'] = 'Issue Book'
Menu['7'] = 'View Issued Book'
Menu['8'] = 'Get Fine'
Menu['9'] = 'Return Issued Book'
Menu['10'] = 'Print Menu'
Menu['11'] = 'Logout'

def print_Menu():
    print(json.dumps(Menu, indent = 3))

print("Welcome to the Student Library")
print("Here is the menu for choosing your library options... ")
print_Menu()

while True:
    Y = int(input("\nEnter your choice (1 to 11) from the menu (0 to exit and 10 to print menu): "))
    if Y == 0: break
    
    if Y == 1:
        if Access!= 'NIL': print("Logout from previous account first, to login....")
        else:
            j = int(input("Enter \'1\' for Admin Login and \'2\' for Student Login: "))
            if j == 1: Admin_login()
            elif j == 2: Student_login()

    elif Y == 2: Add_Books()
    elif Y == 3: View_Books()
    elif Y == 4: Modify_Books()
    elif Y == 5: Book_Search()
    elif Y == 6: Issue_Book()
    elif Y == 7: View_Issued_Books()
    elif Y == 8: Get_Fine()
    elif Y == 9: Return_Issued_Book()
    elif Y == 10: print_Menu()
    elif Y == 11: Logout()
    else: print("Please choose correct option....")

print("Thank you for using the Library")
