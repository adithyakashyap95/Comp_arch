//
//  result display.cpp
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
  int result;

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
