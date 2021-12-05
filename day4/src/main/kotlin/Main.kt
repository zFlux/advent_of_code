import java.io.File

fun main() {
    val inputFileName = "src/main/resources/input.txt"
    val inputIterator = File(inputFileName).readLines().iterator()

    val drawnNumbers = parseDrawnNumbers(inputIterator.next())
    val bingoCards = parseBingoCards(inputIterator)

    var winnerIndex = -1
    var winningNumber = -1
    for (number in drawnNumbers) {
        winnerIndex = markAndEvaluateCards(number, bingoCards)
        if (winnerIndex > -1) {
            winningNumber = number.toInt()
            break
        }
    }

    if (winnerIndex > -1) {
        println(bingoCards[winnerIndex].cardMap())
        println()
        println(bingoCards[winnerIndex].cardResult())
        println("Card Score: " + bingoCards[winnerIndex].cardScore())
        println("Winning Number: " + winningNumber)
        println("Calculated Number: " + (winningNumber * bingoCards[winnerIndex].cardScore()))
    }
}

fun parseDrawnNumbers(input: String): List<String> { return input.split(",") }

fun parseBingoCards(inputLines: Iterator<String>): List<BingoCard> {
    val bingoCards = ArrayList<BingoCard>()
    while (inputLines.hasNext()) {
        inputLines.next()
        bingoCards.add(BingoCard(inputLines))
    }
    return bingoCards
}

fun markAndEvaluateCards(number: String, bingoCards: List<BingoCard>): Int {
    for (i in bingoCards.indices) {
        val bingo = bingoCards[i].markAndEvaluate(number)
        if (bingo) return i
    }
    return -1
}




