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
  int start; int stop;
  if (point1[0] == point2[0]) {
    start = std::min(point1[1],  point2[1]);
    stop = std::max(point1[1], point2[1]);
    for (int i = start; i <= stop; i++) {
      if (canvas[point1[0]][i] == 0) {
        canvas[point1[0]][i] = 1;
      } else if (canvas[point1[0]][i] == 1) {
        numberOfIntersects++;
        canvas[point1[0]][i]++;
      } else {
        canvas[point1[0]][i]++;
      }
    }
  } else if (point1[1] == point2[1]) {
    start = std::min(point1[0],  point2[0]);
    stop = std::max(point1[0], point2[0]);
    for (int i = start; i <= stop; i++) {
      if (canvas[i][point1[1]] == 0) {
        canvas[i][point1[1]] = 1;
      } else if (canvas[i][point1[1]] == 1) {
        numberOfIntersects++;
        canvas[i][point1[1]]++;
      } else {
        canvas[i][point1[i]]++;
      }
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

