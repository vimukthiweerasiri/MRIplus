public class Solution {
    public int longestIncreasingPath(int[][] matrix) {
        int[][] dp = new int[matrix.length][matrix[0].length];
        return findPath(matrix, 0, 0, 1, dp);
    }
    private int findPath(int[][] matrix, int x, int y, int length, int[][] dp){
int num = matrix[x][y];
System.out.println(num + ":" + length);
int max = length;
if(x > 0 && matrix[x-1][y] > num) max = dp[x][y] == 0 ? Math.max(max, findPath(matrix, x-1, y, length+1, dp)): dp[x][y];
if(y > 0 && matrix[x][y-1] > num) max = dp[x][y] == 0 ? Math.max(max, findPath(matrix, x, y-1, length+1, dp)): dp[x][y];
if(x < matrix[0].length - 1 && matrix[x+1][y] > num) max = dp[x][y] == 0 ? Math.max(max, findPath(matrix, x+1, y, length+1, dp)): dp[x][y];
if(y < matrix.length - 1 && matrix[x][y+1] > num) max = dp[x][y] == 0 ? Math.max(max, findPath(matrix, x, y+1, length+1, dp)): dp[x][y];
dp[x][y] = max;
return max;
    }
}