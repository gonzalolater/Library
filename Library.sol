contract Library {

    struct Book {
        string title;
        string author;
        uint bookId;
        address registrant;
    }

    Book[] public books;

    function addBook(string memory _title, string memory _author) public {
        // whoever adds a book, that is the registrant on this book
        books.push(Book(_title, _author, books.length, msg.sender));
    }
    
    function get(uint _bookId) public view returns (string memory _title, string memory _author) {
        return(books[_bookId].title, books[_bookId].author);
    }
    
    function update(uint _bookId, string memory _newTitle, string memory _newAuthor) public {
        // protect our book record by only making
        // this function available to the original registrant
        require(msg.sender == books[_bookId].registrant, 'You must have been the one to add the book to change the record!');
        
        books[_bookId].title = _newTitle;
        books[_bookId].author = _newAuthor;
    }
}
