//
//  main.cpp
//  Comp_arch
//
//  Created by Adithya Kashyap Rajagopal on 5/15/23.
//

#include <iostream>
using namespace std;

int result_disp ()
{
  // declaring variables:
  int a, b;
  decltype(a) result;  // the same as: int a,b;

  // process:
  a = 5;
  b = 2;
  a = a + 1;
  result = a - b;

  // print out the result:
    cout << "result = ";
    cout << result;
    cout << "\n";

  // terminate the program:
  return 0;
}

// MAIN program for using subroutine

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Nice...!!!!\n";
    result_disp();
    return 0;
}


// Next task to create a program which takes argument and runs interatively
