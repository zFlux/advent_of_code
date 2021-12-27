import scala.collection.immutable.HashMap
import scala.collection.mutable
import scala.io.Source

// Step 1: Create a 2d array as a graph representation (called graph) where each entry contains a lightweight "Node"
// object with a "weight" (or cost of entry) a distance (from the start or source node) and a pointer to the previous
// node along the shortest path to the source node
// Step 2: Create or leverage a min priority queue that maintains Nodes by their current distance
// Step 3: Implement Dijkstra's algorithm to find the shortest path

@main def challenge1 = {
  val inputFile = "resources/input.txt"
  val inputSize = getNumberOfRowsAndColumns(inputFile)
  val inputGraph = buildGraph(inputFile, inputSize)
  val startNode = inputGraph(0)(0)
  val endNode = inputGraph(inputSize("Rows")-1)(inputSize("Columns")-1)
  val resultNode = findShortestPath(inputGraph, startNode, endNode)

  println(resultNode.distance)
}

def findShortestPath(input: Array[Array[Node]], startingNode: Node, endingNode: Node) = {
  val minPriorityQueue = mutable.PriorityQueue[Node]()(Ordering.by((n: Node) => n.distance)).reverse
  val completedNodes = mutable.Set[Node]()
  minPriorityQueue.addOne(startingNode)
  startingNode.distance = 0

  while(minPriorityQueue.nonEmpty && minPriorityQueue.head != endingNode) {
      val currNode = minPriorityQueue.dequeue
      completedNodes.add(currNode)
      val neighbors = Array[Option[Node]](
      getNeighbor(Array(currNode.row, currNode.column - 1), currNode, input, completedNodes),
      getNeighbor(Array(currNode.row, currNode.column + 1), currNode, input, completedNodes),
      getNeighbor(Array(currNode.row + 1, currNode.column), currNode, input, completedNodes),
      getNeighbor(Array(currNode.row - 1, currNode.column), currNode, input, completedNodes))
      for ((maybeNeighbor) <- neighbors) {
        if (maybeNeighbor.nonEmpty) then {
          val neighbor = maybeNeighbor.get
          val newDistance = currNode.distance + neighbor.weight
          if (newDistance < neighbor.distance) then {
            neighbor.distance = newDistance
            minPriorityQueue.addOne(neighbor)
          }
        }
      }
  }

  if minPriorityQueue.isEmpty then
    null
  else
    minPriorityQueue.dequeue
}

def getNeighbor(checkPos: Array[Int], currNode: Node, input: Array[Array[Node]], completedNodes: mutable.Set[Node]): Option[Node] = {
  val checkRow = checkPos(0); val checkCol = checkPos(1)
  val maxRow = input.size - 1; val maxCol = input.head.size - 1
  if (checkCol >= 0 && checkCol <= maxCol && checkRow >= 0 && checkRow <= maxRow
    && !completedNodes.contains(input(checkRow)(checkCol))) then
    Option(input(checkRow)(checkCol))
  else
    Option.empty
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

class Node(val weight:Int, val row:Int, val column:Int, var distance:Int, var prev:Node ) {
  override def toString() = {
    if distance == Int.MaxValue then
      "-"
    else
      distance.toString
  }
}