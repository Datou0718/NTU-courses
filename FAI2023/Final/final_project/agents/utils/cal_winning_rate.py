import random
from functools import reduce
from itertools import groupby
from game.engine.card import Card
from game.engine.hand_evaluator import HandEvaluator
from copy import deepcopy

SUIT_MAP = {2: "C", 4: "D", 8: "H", 16: "S"}
SUIT_MAP_INV = {v: k for k, v in SUIT_MAP.items()}
RANK_MAP = {
    2: "2",
    3: "3",
    4: "4",
    5: "5",
    6: "6",
    7: "7",
    8: "8",
    9: "9",
    10: "T",
    11: "J",
    12: "Q",
    13: "K",
    14: "A",
    }
RANK_MAP_INV = {v: k for k, v in RANK_MAP.items()}
HAND_STRENGTH_MAP = {
        "HIGHCARD": 1,
        "ONEPAIR": 2,
        "TWOPAIR": 3,
        "THREECARD": 4,
        "STRAIGHT": 5,
        "FLASH": 6,
        "FULLHOUSE": 7,
        "FOURCARD": 8,
        "STRAIGHTFLASH": 9,
    }

suits = list(SUIT_MAP.keys())
ranks = list(RANK_MAP.keys())

def gen_deck():
    deck = [Card(suit, rank) for suit in suits for rank in ranks]
    random.shuffle(deck)
    return deck

def cal_winning_rate(hole_card, community_card):
    hole_card = [Card(SUIT_MAP_INV[card[0]], RANK_MAP_INV[card[1]]) for card in hole_card]
    community_card = [Card(SUIT_MAP_INV[card[0]], RANK_MAP_INV[card[1]]) for card in community_card]
    deck = gen_deck()
    for card in hole_card + community_card:
        deck.remove(card)
    wins = 0
    for _ in range(3000):
        this_deck = deepcopy(deck)
        random.shuffle(this_deck)
        opponent_card = [this_deck.pop(), this_deck.pop()]
        wins += check_win(hole_card, opponent_card, community_card)
    return wins / 3000

def check_win(my_card, opponent_card, community_card):
    my_info = HandEvaluator.gen_hand_rank_info(my_card, community_card)
    opponent_info = HandEvaluator.gen_hand_rank_info(opponent_card, community_card)
    my_strength = HAND_STRENGTH_MAP[my_info["hand"]["strength"]]
    opponent_strength = HAND_STRENGTH_MAP[opponent_info["hand"]["strength"]]
    if my_strength > opponent_strength:
        return 1
    elif my_strength < opponent_strength:
        return 0
    else:
        if my_info["hand"]["high"] > opponent_info["hand"]["high"]:
            return 1
        elif my_info["hand"]["high"] < opponent_info["hand"]["high"]:
            return 0
        else:
            if my_info["hand"]["low"] > opponent_info["hand"]["low"]:
                return 1
            elif my_info["hand"]["low"] < opponent_info["hand"]["low"]:
                return 0
            else:
                return 0.5


def test_poker_hand_evaluator():
    test_cases = [
        ([Card(8, 14), Card(8, 13)],[]),
        ([Card(8, 13), Card(8, 11)], [Card(4, 14), Card(2, 14), Card(16, 14)]),
        ([Card(8, 2), Card(4, 6)], [Card(4, 7), Card(2, 5), Card(16, 10)]),
    ]

    for hole_card, community_card in test_cases:
        win_rate = cal_winning_rate(hole_card, community_card)
        hole_cards_str = [f"{SUIT_MAP[card.suit]}{RANK_MAP[card.rank]}" for card in hole_card]
        community_cards_str = [f"{SUIT_MAP[card.suit]}{RANK_MAP[card.rank]}" for card in community_card]
        print(f"Hole Cards: {hole_cards_str}, Community Cards: {community_cards_str}, Win Rate: {win_rate:.2%}")

# test_poker_hand_evaluator()
