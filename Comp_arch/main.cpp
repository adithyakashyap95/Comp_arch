//
//  main.cpp
//  Comp_arch
//
//  Created by Adithya Kashyap Rajagopal on 5/15/23.
//

#include <iostream>
#include <fstream>
#include <string>
// Adding multiple files here
#include "result_display2.hpp"

using namespace std;

// Note all the sub routine should be above the MAIN program

int result_disp1 ()
{
  // declaring variables:
  int a, b;
  decltype(a) result;  // the same as: int a,b;

  // process:
  a = 5;
  b = 2;
  a = a + 1;
  result = a - b;
  
    result_disp (result);

  // terminate the program:
  return 0;
}

// MAIN program for using subroutine should be at last
// Explore on how to take file as input and

int main(int argc, const char * argv[]) {
    // insert code here...
    int result;
    std::cout << "Nice...!!!!\n";
    result_disp1();
    std::cout << "Enter a number...!!!\n";
    std::cin >> result;
    result_disp(result);
    string mystring;
    
    ifstream myfile("d");
    std::cout << "file open ??\n";
// FIXME: Below line something is wrong
    std::cout << myfile.is_open();
    
    if ( myfile.is_open() ) {
        while ( getline (myfile,mystring) ) {
            std::cout << mystring;
        }
        
        std::cout << "Printing the file\n";
        std::cout << mystring;
        
    }
    else {
        std::cout << "File not found...!!\n";
    }

    return 0;
}
