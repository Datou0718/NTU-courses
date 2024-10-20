# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent
from pacman import GameState

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState: GameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState: GameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        "*** YOUR CODE HERE ***"
        rawScore = successorGameState.getScore()

        foodScore = 0
        foodList = newFood.asList()
        minFoodDist = float('inf')
        for food in foodList:
            minFoodDist = min(minFoodDist, manhattanDistance(newPos, food))
        foodScore = 10 if minFoodDist == 0 else 1/minFoodDist
        
        ghostScore = 0
        minGhostDist = float('inf')
        minEatableGhostDist = float('inf')
        for ghost in newGhostStates:
            scaredTime = ghost.scaredTimer
            dist = manhattanDistance(newPos, ghost.getPosition())
            if scaredTime == 0:
                minGhostDist = min(minGhostDist, dist)
            else:
                minEatableGhostDist = min(minEatableGhostDist, dist)

        if minGhostDist < 2:
            ghostScore = -500
        elif minEatableGhostDist < 2:
            ghostScore = 200

        return rawScore + foodScore + ghostScore


def scoreEvaluationFunction(currentGameState: GameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """
        "*** YOUR CODE HERE ***"

        def value(state, depth, agentIndex):
            if state.isWin() or state.isLose() or depth == 0:
                return self.evaluationFunction(state)
            if agentIndex == 0:
                return maxValue(state, depth, agentIndex)
            else:
                return minValue(state, depth, agentIndex)
        
        def maxValue(state, depth, agentIndex):
            v = float('-inf')
            for action in state.getLegalActions(agentIndex):
                v = max(v, value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1))
            return v
        
        def minValue(state, depth, agentIndex):
            v = float('inf')
            for action in state.getLegalActions(agentIndex):
                if agentIndex == state.getNumAgents() - 1:
                    v = min(v, value(state.generateSuccessor(agentIndex, action), depth-1, 0))
                else:
                    v = min(v, value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1))
            return v

        bestAction = None
        bestValue = float('-inf')
        for action in gameState.getLegalActions(0):
            v = value(gameState.generateSuccessor(0, action), self.depth, 1)
            if v > bestValue:
                bestValue = v
                bestAction = action
        return bestAction
    
class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        def value(state, depth, agentIndex, alpha, beta):
            if state.isWin() or state.isLose() or depth == 0:
                return self.evaluationFunction(state)
            if agentIndex == 0:
                return maxValue(state, depth, agentIndex, alpha, beta)
            else:
                return minValue(state, depth, agentIndex, alpha, beta)
        
        def maxValue(state, depth, agentIndex, alpha, beta):
            v = float('-inf')
            for action in state.getLegalActions(agentIndex):
                v = max(v, value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1, alpha, beta))
                if v > beta:
                    return v
                alpha = max(alpha, v)
            return v
        
        def minValue(state, depth, agentIndex, alpha, beta):
            v = float('inf')
            for action in state.getLegalActions(agentIndex):
                if agentIndex == state.getNumAgents() - 1:
                    v = min(v, value(state.generateSuccessor(agentIndex, action), depth-1, 0, alpha, beta))
                else:
                    v = min(v, value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1, alpha, beta))
                if v < alpha:
                    return v
                beta = min(beta, v)
            return v
        
        bestAction = None
        bestValue = float('-inf')
        alpha = float('-inf')
        beta = float('inf')
        for action in gameState.getLegalActions(0):
            v = value(gameState.generateSuccessor(0, action), self.depth, 1, alpha, beta)
            if v > bestValue:
                bestValue = v
                bestAction = action
            alpha = max(alpha, bestValue)
        return bestAction

class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the expectimax action using self.depth and self.evaluationFunction

        All ghosts should be modeled as choosing uniformly at random from their
        legal moves.
        """
        "*** YOUR CODE HERE ***"
        def value(state, depth, agentIndex):
            if state.isWin() or state.isLose() or depth == 0:
                return self.evaluationFunction(state)
            if agentIndex == 0:
                return maxValue(state, depth, agentIndex)
            else:
                return expValue(state, depth, agentIndex)
        
        def maxValue(state, depth, agentIndex):
            v = float('-inf')
            for action in state.getLegalActions(agentIndex):
                v = max(v, value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1))
            return v
        
        def expValue(state, depth, agentIndex):
            v = 0
            actions = state.getLegalActions(agentIndex)
            for action in actions:
                if agentIndex == state.getNumAgents() - 1:
                    v += value(state.generateSuccessor(agentIndex, action), depth-1, 0)
                else:
                    v += value(state.generateSuccessor(agentIndex, action), depth, agentIndex+1)
            return v / len(actions)

        bestAction = None
        bestValue = float('-inf')
        for action in gameState.getLegalActions(0):
            v = value(gameState.generateSuccessor(0, action), self.depth, 1)
            if v > bestValue:
                bestValue = v
                bestAction = action
        return bestAction

def betterEvaluationFunction(currentGameState: GameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: betterEvaluationFunction considers the following factors:
    1. rawScore: the raw score of the currentGameState
    2. foodScore: 10 / minFoodDist, where minFoodDist is the Manhattan distance to the nearest food
    3. ghostScore: threatened score + eatable score, where threatened score = -500 / minGhostDist**2, eatable score = 200 / minEatableGhostDist**2
    IF MINIMUM DISTANCE TO A GHOST IS LESS THAN 2, RETURN A SCORE OF -500
    """
    "*** YOUR CODE HERE ***"
    rawScore = currentGameState.getScore()
    scorePerGhost = 200
    scorePerFood = 10
    scoreOfLose = -500

    foodScore = 0
    foodList = currentGameState.getFood().asList()
    minFoodDist = float('inf')
    for food in foodList:
        minFoodDist = min(minFoodDist, manhattanDistance(currentGameState.getPacmanPosition(), food))
    foodScore = scorePerFood/minFoodDist

    ghostScore = 0
    eatableScore = 0
    minGhostDist = float('inf')
    for ghost in currentGameState.getGhostStates():
        scaredTime = ghost.scaredTimer
        dist = manhattanDistance(currentGameState.getPacmanPosition(), ghost.getPosition())
        if scaredTime == 0:
            minGhostDist = min(minGhostDist, dist)
        else:
            eatableScore += scorePerGhost/(dist**2)
    
    if minGhostDist < 2:
        return scoreOfLose
    
    threatScore = scoreOfLose/(minGhostDist**2)
    ghostScore = threatScore + eatableScore

    return rawScore + foodScore + ghostScore

    
  

# Abbreviation
better = betterEvaluationFunction
