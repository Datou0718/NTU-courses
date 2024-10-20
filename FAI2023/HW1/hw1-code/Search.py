# search.py
# ---------------
# Licensing Information:  You are free to use or extend this projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to the University of Illinois at Urbana-Champaign
#
# Created by Michael Abir (abir2@illinois.edu) on 08/28/2018
# Modified by Shang-Tse Chen (stchen@csie.ntu.edu.tw) on 03/03/2022

"""
This is the main entry point for HW1. You should only modify code
within this file -- the unrevised staff files will be used for all other
files and classes when code is run, so be careful to not modify anything else.
"""
# Search should return the path.
# The path should be a list of tuples in the form (row, col) that correspond
# to the positions of the path taken by your search algorithm.
# maze is a Maze object based on the maze from the file specified by input filename
# searchMethod is the search method specified by --method flag (bfs,dfs,astar,astar_multi,fast)

import heapq

def search(maze, searchMethod):
    return {
        "bfs": bfs,
        "astar": astar,
        "astar_corner": astar_corner,
        "astar_multi": astar_multi,
        "fast": fast,
    }.get(searchMethod)(maze)

def bfs(maze):
    """
    Runs BFS for part 1 of the assignment.

    @param maze: The maze to execute the search on.

    @return path: a list of tuples containing the coordinates of each state in the computed path
    """
    
    start = maze.getStart()
    target = maze.getObjectives()

    visited = set()
    queue = [(start, [start], set(target))]

    goal_test = lambda unvisited_targets: len(unvisited_targets) == 0

    while queue:
        pos, path, unvisited_targets = queue.pop(0)
        if pos in visited:
            continue
        visited.add(pos)

        if pos in unvisited_targets:
            unvisited_targets.remove(pos)
            if goal_test(unvisited_targets):
                return path
            queue = [(pos, path, unvisited_targets)]

        for next_pos in maze.getNeighbors(pos[0], pos[1]):
            if next_pos not in visited:
                queue.append((next_pos, path + [next_pos], unvisited_targets))

def astar(maze):
    """
    Runs A star for part 1 of the assignment.

    @param maze: The maze to execute the search on.

    @return path: a list of tuples containing the coordinates of each state in the computed path
    """

    return astar_corner(maze)
        
def astar_corner(maze):
    """
    Runs A star for part 2 of the assignment in the case where there are four corner objectives.

    @param maze: The maze to execute the search on.

    @return path: a list of tuples containing the coordinates of each state in the computed path
    """

    start = maze.getStart()
    targets = maze.getObjectives()

    heuristic = lambda pos, unvisited_targets: min([abs(pos[0] - target[0]) + abs(pos[1] - target[1]) for target in unvisited_targets])
    goal_test = lambda unvisited_targets: len(unvisited_targets) == 0
    visited = set()

    min_heap = [(heuristic(start, set(targets)), start, [start], set(targets))]

    while min_heap:
        _, pos, path, unvisited_targets = heapq.heappop(min_heap)

        unvisited_targets = set(unvisited_targets)
        
        if (pos, tuple(unvisited_targets)) in visited:
            continue

        if pos in unvisited_targets:
            unvisited_targets.remove(pos)
            if goal_test(unvisited_targets):
                return path
        
        visited.add((pos, tuple(unvisited_targets)))

        for next_pos in maze.getNeighbors(pos[0], pos[1]):
            heapq.heappush(min_heap, (len(path) + heuristic(next_pos, unvisited_targets) + 1, next_pos, path + [next_pos], unvisited_targets))

    return []

def astar_multi(maze):
    """
    Runs A star for part 3 of the assignment in the case where there are
    multiple objectives.

    @param maze: The maze to execute the search on.

    @return path: a list of tuples containing the coordinates of each state in the computed path
    """

    start = maze.getStart()
    targets = maze.getObjectives()

    targets_idx_map = {target: i for i, target in enumerate(targets)}

    x, y = maze.getDimensions()
    distance = [[0 for _ in range(len(targets))] for _ in range(x*y)]
    bfs_path = [[[] for _ in range(len(targets))] for _ in range(x*y)]

    # bfs to know the distance from i to every other point in maze.
    for i in range(len(targets)):
        visited = set()
        queue = [(targets[i], [])]
        
        while queue:
            pos, path = queue.pop(0)
            if pos in visited:
                continue
            visited.add(pos)
            distance[pos[0]*y + pos[1]][i] = len(path) - 1
            bfs_path[pos[0]*y + pos[1]][i] = path

            for next_pos in maze.getNeighbors(pos[0], pos[1]):
                if next_pos not in visited:
                    queue.append((next_pos, [next_pos] + path))

    

    # construct a MST using Prim's algorithm
    def heuristic(pos, unvisited):
        total = 0
        unioned = set([pos])
        not_unioned = set(unvisited)
        while not_unioned:
            min_dist = float('inf')
            to_union = None
            for u in unioned:
                for v in not_unioned:
                    if distance[u[0]*y + u[1]][targets_idx_map[v]] < min_dist:
                        min_dist = distance[u[0]*y + u[1]][targets_idx_map[v]]
                        to_union = v
            total += min_dist
            unioned.add(to_union)
            not_unioned.remove(to_union)
            
        return total

    goal_test = lambda unvisited_targets: len(unvisited_targets) == 0

    min_heap = [(heuristic(start, set(targets)), start, [start], set(targets))]
    while min_heap:
        _, pos, path, unvisited_targets = heapq.heappop(min_heap)

        if goal_test(unvisited_targets):
            return path

        for next_pos in unvisited_targets:
            heapq.heappush(min_heap, (len(path) + heuristic(next_pos, unvisited_targets), next_pos, path + bfs_path[pos[0]*y + pos[1]][targets_idx_map[next_pos]], unvisited_targets - {next_pos}))

def fast(maze):
    """
    Runs suboptimal search algorithm for part 4.

    @param maze: The maze to execute the search on.

    @return path: a list of tuples containing the coordinates of each state in the computed path
    """

    start = maze.getStart()
    targets = maze.getObjectives()

    goal_test = lambda unvisited_targets: len(unvisited_targets) == 0

    final_path = []
    
    queue = [(start, [start], set(targets))]
    visited = set()

    while queue:
        pos, path, unvisited_targets = queue.pop(0)
        if pos in visited:
            continue
        visited.add(pos)

        if pos in unvisited_targets:
            unvisited_targets.remove(pos)
            if goal_test(unvisited_targets):
                return final_path + path
            final_path += path + list(reversed(path))[1:-1]

        for next_pos in maze.getNeighbors(pos[0], pos[1]):
            if next_pos not in visited:
                queue.append((next_pos, path + [next_pos], unvisited_targets))