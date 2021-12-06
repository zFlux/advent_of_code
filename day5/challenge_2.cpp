#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <map>

using namespace std;

void buildPoint(std::istringstream& s, int* point) {
    string p1; string p2;
    getline(s, p1, ','); 
    getline(s, p2, ' ');
    point[0] = std::stoi(p1);
    point[1] = std::stoi(p2);
}

void drawLine(int* point1, int* point2, map<int, map<int, int>> &canvas, int &numberOfIntersects) {
  int incrX = 0; int incrY = 0;
  
  if (point1[0] != point2[0]) incrX = point1[0] < point2[0] ? 1 : -1;
  if (point1[1] != point2[1]) incrY = point1[1] < point2[1] ? 1 : -1;

  for (int x = point1[0], y = point1[1]; (incrX == 0 || x != (point2[0] + incrX)) && (incrY == 0 || y != (point2[1] + incrY)); x+=incrX, y+=incrY) {
      if (canvas[x][y] == 0) {
        canvas[x][y] = 1;
      } else if (canvas[x][y] == 1) {
        numberOfIntersects++;
        canvas[x][y]++;
      } else {
        canvas[x][y]++;
      }
  }
}

int main () {
  string line;
  ifstream myfile ("input.txt");
  map<int, map<int, int>> canvas;
  int numberOfIntersects = 0;

  if (myfile.is_open())
  {
    while ( getline (myfile, line) )
    {
        istringstream ss(line);
        int point1[2], point2[2];
    
        buildPoint(ss, point1);
        string ptr; getline(ss, ptr, ' ');
        buildPoint(ss, point2);
        drawLine(point1, point2, canvas, numberOfIntersects);     
    }
    myfile.close();
    cout << numberOfIntersects;
  }

  else cout << "Unable to open file"; 

  return 0;
}

