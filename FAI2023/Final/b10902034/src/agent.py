from game.players import BasePokerPlayer
import importlib.util
import sys
from os.path import dirname, join

module_path = join(dirname(__file__), 'utils', 'cal_winning_rate.py')

spec = importlib.util.spec_from_file_location("cal_winning_rate", module_path)
module = importlib.util.module_from_spec(spec)
sys.modules["cal_winning_rate"] = module
spec.loader.exec_module(module)

cal_winning_rate = module.cal_winning_rate


class CallPlayer(BasePokerPlayer): 

    def __init__(self):
        super().__init__()
        self.is_big_blind = False
        self.winning_rate = 0
        self.pot_stack = 0
        self.leverage = 1
        self.threshold_of_fold_to_win = 0
        self.threshold_of_fold_and_lose = 0
        self.threshold_of_call_and_lose = 0

    def take_action(self, valid_actions, action, amount):
        if action == "raise":
            if valid_actions[2]["amount"]["max"] != -1:
                return "raise", min(amount, valid_actions[2]["amount"]["max"])
            else:
                return "call", valid_actions[1]["amount"]
        elif action == "call":
            if self.threshold_of_call_and_lose < 0:
                return "call", valid_actions[1]["amount"]
            else:
                if self.threshold_of_fold_and_lose > 0 or self.winning_rate > 0.8 * self.leverage:
                    return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["max"])
                else:
                    return "fold", 0
        else:
            if self.threshold_of_fold_and_lose > 0:
                return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["max"])
            else:
                return "fold", 0

    def declare_action(self, valid_actions, hole_card, round_state):
        # valid_actions format => [fold_action_info, call_action_info, raise_action_info]
        self.is_big_blind = round_state["big_blind_pos"] == round_state["next_player"]

        # calculate the threshold of fold_to_win
        remain_round = 20 - round_state["round_count"]
        prev_bet = max(round_state["pot"]["main"]["amount"] - self.pot_stack, 0)
        self.pot_stack = round_state["pot"]["main"]["amount"]
        my_stack = round_state["seats"][round_state["next_player"]]["stack"]
        opponent_stack = round_state["seats"][1 - round_state["next_player"]]["stack"]
        bb_amount = round_state["small_blind_amount"] * 2
        winning_threshold = bb_amount * 3 * (remain_round // 2)
        # if threshold_of_fold_to_win > 0, keep folding can win the game
        self.threshold_of_fold_to_win = my_stack - (opponent_stack + self.pot_stack) - winning_threshold
        # if threshold_of_fold_and_lose > 0, fold this round will lose the game
        self.threshold_of_fold_and_lose = opponent_stack + self.pot_stack - my_stack - winning_threshold
        # if threshold_of_call_and_lose > 0, then call and lose this round will lose the game
        self.threshold_of_call_and_lose = opponent_stack + self.pot_stack - my_stack + valid_actions[1]["amount"] * 2 - winning_threshold
        if remain_round % 2 == 1:
            if self.is_big_blind:
                self.threshold_of_fold_to_win -= bb_amount
                self.threshold_of_fold_and_lose -= bb_amount * 2
                self.threshold_of_call_and_lose -= bb_amount * 2
            else:
                self.threshold_of_fold_to_win -= bb_amount * 2
                self.threshold_of_fold_and_lose -= bb_amount
                self.threshold_of_call_and_lose -= bb_amount
                
        # calculate winning rate
        community_card = round_state["community_card"]
        self.winning_rate = cal_winning_rate(hole_card, community_card)
        self.leverage = 0.95 if self.threshold_of_fold_to_win >= -bb_amount * 10 and remain_round < 10 else 1
        # self.leverage = 1 if self.threshold_of_fold_to_win < -bb_amount * 10 else 0.9
        # print(f"winning_rate: {self.winning_rate}")
        # print(f"prev_bet: {prev_bet}")
        # print(f"remain_round: {remain_round}")
        # print(f"threshold_of_fold_to_win: {self.threshold_of_fold_to_win}")
        # print(f"threshold_of_fold_and_lose: {self.threshold_of_fold_and_lose}")
        # print(f"threshold_of_call_and_lose: {self.threshold_of_call_and_lose}")

        # current state
        state = round_state["street"]

        if state == "preflop":
            if self.threshold_of_fold_to_win > 0:
                return self.take_action(valid_actions, "fold", 0)
            elif self.winning_rate > 0.85 * self.leverage:
                if self.pot_stack < bb_amount * 5:
                    return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["min"])
                else:
                    return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            elif self.winning_rate > 0.5 * self.leverage and self.pot_stack < bb_amount * 5 or self.winning_rate > 0.3 and self.pot_stack < bb_amount * 3 or valid_actions[1]["amount"] == 0:
                return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            else:
                return self.take_action(valid_actions, "fold", 0)
        
        elif state == "flop":
            if self.winning_rate > 0.95 * self.leverage or prev_bet == 0 and self.winning_rate > 0.7:
                if self.pot_stack < bb_amount * 15:
                    return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["min"] + bb_amount)
                else:
                    return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            elif self.winning_rate > 0.8 * self.leverage or self.winning_rate > 0.6 and prev_bet < bb_amount * 8:
                return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            else:
                if self.winning_rate > 0.4 * self.leverage and self.pot_stack < bb_amount * 8 or valid_actions[1]["amount"] == 0:
                    return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
                else:
                    return self.take_action(valid_actions, "fold", 0)
        
        elif state == "turn":
            if self.winning_rate > 0.95 * self.leverage or prev_bet == 0 and self.winning_rate > 0.7:
                return self.take_action(valid_actions, "raise", max(valid_actions[2]["amount"]["min"] + bb_amount * 3, self.pot_stack / 2))
            elif self.winning_rate > 0.8 * self.leverage:
                return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["min"] + bb_amount * 3)
            elif self.winning_rate > 0.6 * self.leverage and prev_bet < bb_amount * 8:
                return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            else:
                if self.winning_rate > 0.4 and valid_actions[1]["amount"] < bb_amount * 5 or valid_actions[1]["amount"] == 0:
                    return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
                else:
                    return self.take_action(valid_actions, "fold", 0)
        else:
            if self.winning_rate > 0.97 * self.leverage:
                return self.take_action(valid_actions, "raise", max(valid_actions[2]["amount"]["min"], self.threshold_of_fold_to_win / 2 + bb_amount))
            elif self.winning_rate > 0.8 * self.leverage and prev_bet < bb_amount * 5:
                return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["min"] + bb_amount * 6)
            elif self.winning_rate > 0.5 * self.leverage and prev_bet == 0:
                return self.take_action(valid_actions, "raise", valid_actions[2]["amount"]["min"] + bb_amount * 4)
            elif self.winning_rate > 0.7 * self.leverage  or valid_actions[1]["amount"] < bb_amount * 2:
                return self.take_action(valid_actions, "call", valid_actions[1]["amount"])
            else:
                return self.take_action(valid_actions, "fold", 0)

    def receive_game_start_message(self, game_info):
        pass

    def receive_round_start_message(self, round_count, hole_card, seats):
        pass

    def receive_street_start_message(self, street, round_state):
        pass

    def receive_game_update_message(self, action, round_state):
        pass

    def receive_round_result_message(self, winners, hand_info, round_state):
        pass

def setup_ai():
    return CallPlayer()
