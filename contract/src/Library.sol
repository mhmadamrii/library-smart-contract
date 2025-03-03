// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Library {
    // represent book model
    struct Book {
        uint id;
        string title;
        bool isAvailable;
    }

    mapping(uint => Book) public books;
    uint public bookCount;
    address public owner;

    event BookAdded(uint indexed _id, string title, bool isAvailable);
    event BookBorrowed(uint indexed _id, string title, address indexed borrower);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier otherThanOwner() {
        require(msg.sender != owner,"Owner cannot borrow his own book");
        _;
    }

    function addBook(string memory _title) public onlyOwner {
        bookCount++;
        books[bookCount] = Book(bookCount, _title, true);

        emit BookAdded(bookCount, _title, true);
    }

    function borrowBook(uint _bookId) public otherThanOwner() {
        require(_bookId > 0 && _bookId <= bookCount, "Book does not exit");
        Book storage book = books[_bookId];
        require(book.isAvailable, "Book is not available");
        book.isAvailable = false;

        emit BookBorrowed(_bookId, book.title, msg.sender);
    }

    function returnBook(uint _bookId) public {
        require(_bookId > 0 && _bookId <= bookCount, "Book does not exit");
        Book storage book = books[_bookId];
        require(!book.isAvailable, "Book is already available");
        book.isAvailable = true;
    }

    function getAllBooks() public view returns (Book[] memory) {
        Book[] memory allBooks = new Book[](bookCount);
        for (uint i = 1; i <= bookCount; i++) {
            allBooks[i - 1] = books[i];
        }

        return allBooks;
    }
}