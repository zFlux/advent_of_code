import java.io.File

fun main() {
    val inputFileName = "src/main/resources/input.txt"
    val inputIterator = File(inputFileName).readLines().iterator()

    val drawnNumbers = parseDrawnNumbers(inputIterator.next())
    val bingoCards = parseBingoCards(inputIterator)

    findFirstWinningCard(drawnNumbers, bingoCards)
    findLastWinningCard(drawnNumbers, bingoCards)
}

fun findFirstWinningCard(drawnNumbers: List<String>, bingoCards: List<BingoCard>) {
    var winnerIndex = -1
    var winningNumber = -1
    for (number in drawnNumbers) {
        winnerIndex = markAndEvaluateFirstWin(number, bingoCards)
        if (winnerIndex > -1) {
            winningNumber = number.toInt()
            break
        }
    }

    if (winnerIndex > -1) {
        println("First Winning Number: " + winningNumber)
        println("Card Score: " + (winningNumber * bingoCards[winnerIndex].cardScore()))
    }
}

fun findLastWinningCard(drawnNumbers: List<String>, bingoCards: List<BingoCard>) {
    var setOfPreviousWinners = HashSet<Int>()
    var lastWinner = HashSet<Int>()
    var lastWinningNumber = ""
    for (number in drawnNumbers) {
        val setOfWinners = markAndEvaluateAllCards(number, bingoCards, setOfPreviousWinners)
        if (setOfWinners.size > 0 ) {
            setOfPreviousWinners.addAll(setOfWinners)
            println("Winning Card Indexes: " + setOfWinners + " for number: " + number)
            lastWinner = setOfWinners
            lastWinningNumber = number
        }
    }

    println("Last Winning Number: " + lastWinningNumber)
    println("Last Winning Card Indexes: " + lastWinner)
    println("Card Score: " + (lastWinningNumber.toInt() * bingoCards[lastWinner.iterator().next()].cardScore()))
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

fun markAndEvaluateFirstWin(number: String, bingoCards: List<BingoCard>): Int {
    for (i in bingoCards.indices) {
        val bingo = bingoCards[i].markAndEvaluate(number)
        if (bingo) return i
    }
    return -1
}

fun markAndEvaluateAllCards(number: String, bingoCards: List<BingoCard>, setOfPreviousWinners: HashSet<Int>): HashSet<Int> {
    val result = HashSet<Int>()
    for (i in bingoCards.indices) {
        if (!setOfPreviousWinners.contains(i)) {
            val bingo = bingoCards[i].markAndEvaluate(number)
            if (bingo) result.add(i)
        }
    }
    return result
}






