package adventOfCode

import scala.collection.mutable

class ShortestPath {

  def findShortestPath(input: Array[Array[Node]], startingNode: Node, endingNode: Node) = {
    val minPriorityQueue = mutable.PriorityQueue[Node]()(Ordering.by((n: Node) => n.distance)).reverse
    val completedNodes = mutable.Set[Node]()
    minPriorityQueue.addOne(startingNode)
    startingNode.distance = 0

    while (minPriorityQueue.nonEmpty && minPriorityQueue.head != endingNode) {
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

}
