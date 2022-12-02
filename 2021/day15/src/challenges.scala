import scala.collection.immutable.HashMap
import scala.collection.mutable
import scala.io.Source
import adventOfCode.Node
import adventOfCode.ShortestPath
// Step 1: Create a 2d array as a graph representation (called graph) where each entry contains a lightweight "Node"
// object with a "weight" (or cost of entry) a distance (from the start or source node) and a pointer to the previous
// node along the shortest path to the source node
// Step 2: Create or leverage a min priority queue that maintains Nodes by their current distance
// Step 3: Implement Dijkstra's algorithm to find the shortest path

@main def challenges = {
  val inputFile = "resources/input.txt"
  val inputSize1 = getNumberOfRowsAndColumns(inputFile)
  val inputGraph1 = buildGraph(inputFile, inputSize1)
  val startNode1 = inputGraph1(0)(0)
  val endNode1 = inputGraph1(inputSize1("Rows")-1)(inputSize1("Columns")-1)
  val resultNode1 = ShortestPath().findShortestPath(inputGraph1, startNode1, endNode1)

  val inputGraph2 = expandGraph(inputGraph1, 5)
  val startNode2 = inputGraph2(0)(0)
  val endNode2 = inputGraph2(inputGraph2.size-1)(inputGraph2.head.size-1)
  val resultNode2 = ShortestPath().findShortestPath(inputGraph2, startNode2, endNode2)

  println("Challenge 1 Result: " + resultNode1.distance)
  println("Challenge 2 Result: " + resultNode2.distance)
}

def expandGraph(startingGraph: Array[Array[Node]], multiplier: Int): Array[Array[Node]] = {
  val rowCount = startingGraph.size
  val colCount = startingGraph.head.size
  val newRowCount = rowCount * multiplier
  val newColCount = colCount * multiplier
  val newGraph = Array.ofDim[Node](newColCount, newRowCount)

  for ((row, rowIndex) <- startingGraph.zipWithIndex) {
    for ((value, colIndex) <- row.zipWithIndex) {
      // for each value simultaneously populate the mult x mult (i.e. 25) panels with related values
      for ((colMult) <- 0 to (multiplier - 1)) {
        for ((rowMult) <- 0 to (multiplier - 1)) {
          val newColIndex = (colMult * colCount) + colIndex
          val newRowIndex = (rowMult * rowCount) + rowIndex
          var newWeight = value.weight + rowMult + colMult
          if (newWeight > 9) {
            newWeight %= 9
            if (newWeight == 0) {
              newWeight = 1
            }
          }
          newGraph(newRowIndex)(newColIndex) = new Node(newWeight, newRowIndex, newColIndex, Int.MaxValue, null)
        }
      }
    }
  }
  newGraph
}

def buildGraph(graphFilePath: String, counts: HashMap[String, Int]): Array[Array[Node]] = {
  val graph = Array.ofDim[Node](counts("Columns"), counts("Rows"))
  for ((line, rowIndex) <- Source.fromFile(graphFilePath).getLines.zipWithIndex) {
    for ((c, colIndex) <- line.zipWithIndex) {
      graph(rowIndex)(colIndex) = new Node( c.asDigit, rowIndex, colIndex, Int.MaxValue, null)
    }
  }
  graph
}

def getNumberOfRowsAndColumns(graphFilePath: String): HashMap[String, Int] = {
    val inputFile = Source.fromFile(graphFilePath)
    val numberOfColumns = inputFile.getLines.next.size
    val numberOfRows = inputFile.getLines.size + 1
    inputFile.close
    HashMap("Rows" -> numberOfRows, "Columns" -> numberOfColumns)
}

def printGraph(graph: Array[Array[Node]]) = {
  print(graph.map(_.mkString(" ")).mkString("\n"))
}

