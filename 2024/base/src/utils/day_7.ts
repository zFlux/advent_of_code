export const canProduceValue = (target: number, operands: number[], operations: string[]): boolean => {
    const memo: Map<string, boolean> = new Map();
  
    function dfs(index: number, currentValue: number): boolean {
      // Base case: reached the end of operands
      if (index === operands.length) {
        return currentValue === target;
      }
  
      // Memoization key
      const key = `${index},${currentValue}`;
  
      // Check if we've already computed this subproblem
      if (memo.has(key)) {
        return memo.get(key) as boolean;
      }
  
      // Try all operations given
      let add = false;
      let mult = false;
      let concat = false;

      for (let operation of operations) {
        if (operation === '+') {
          add = dfs(index + 1, currentValue + operands[index]);
        } else if (operation === '*') {
          mult = dfs(index + 1, currentValue * operands[index]);
        } else if (operation === '||') {
          concat = dfs(index + 1, parseInt(`${currentValue}${operands[index]}`));
        }
      }
  
      // Store result in memo and return
      const result = add || mult || concat;
      memo.set(key, result);
      return result;
    }
  
    // Start DFS from the first operand
    return dfs(1, operands[0]);
  }