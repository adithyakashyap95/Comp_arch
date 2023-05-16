//
//  main.cpp
//  Comp_arch
//
//  Created by Adithya Kashyap Rajagopal on 5/15/23.
//

#include <iostream>
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

// MAIN program for using subroutine
// Explore on how to take file as input and

int main(int argc, const char * argv[]) {
    // insert code here...
    int result;
    std::cout << "Nice...!!!!\n";
    result_disp1();
    std::cout << "Enter a number...!!!\n";
    std::cin >> result;
    result_disp(result);
    return 0;
}
