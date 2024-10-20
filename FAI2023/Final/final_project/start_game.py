import json
from tqdm import tqdm
from game.game import setup_config, start_poker
from agents.agent import setup_ai as wrd_ra_ai

from baseline.baseline0 import setup_ai as baseline0_ai
from baseline.baseline1 import setup_ai as baseline1_ai
from baseline.baseline2 import setup_ai as baseline2_ai
from baseline.baseline3 import setup_ai as baseline3_ai
from baseline.baseline4 import setup_ai as baseline4_ai
from baseline.baseline5 import setup_ai as baseline5_ai
from baseline.baseline6 import setup_ai as baseline6_ai
from baseline.baseline7 import setup_ai as baseline7_ai

# counter = 0
# for i in tqdm(range(25)):
#     config = setup_config(max_round=20, initial_stack=1000, small_blind_amount=5)
#     # config.register_player(name="baseline0", algorithm=baseline0_ai())
#     # config.register_player(name="baseline1", algorithm=baseline1_ai())
#     # config.register_player(name="baseline2", algorithm=baseline2_ai())
#     # config.register_player(name="baseline3", algorithm=baseline3_ai())
#     config.register_player(name="baseline4", algorithm=baseline4_ai())
#     # config.register_player(name="baseline5", algorithm=baseline5_ai())
#     # config.register_player(name="baseline6", algorithm=baseline6_ai())
#     # config.register_player(name="baseline7", algorithm=baseline7_ai())
#     config.register_player(name="wrd_ra", algorithm=wrd_ra_ai())

#     game_result = start_poker(config, verbose=1)
#     if game_result["players"][0]["stack"] <= game_result["players"][1]["stack"]:
#         counter += 1
# print("winning rate of wrd_ra: ", counter/25)


# Create a list of agents
agents = [
    {"name": "wrd_ra", "algorithm": wrd_ra_ai()}
]

# Create a list of baseline algorithms
baselines = [
    # baseline0_ai, 
    # baseline1_ai, 
    # baseline2_ai, 
    # baseline3_ai,
    baseline4_ai, 
    baseline7_ai,
    # baseline5_ai, 
    # baseline6_ai
]


# Initialize the win rate table
win_rate = [[0 for _ in range(len(baselines))] for _ in range(len(agents))]

# Run the simulations
for agent_idx, agent in enumerate(agents):
    for i in range(len(baselines)):
        for j in tqdm(range(100), desc=f"{agent['name']} vs baseline{i}"):
            config = setup_config(max_round=20, initial_stack=1000, small_blind_amount=5)
            config.register_player(name=f"baseline{i}", algorithm=baselines[i]())
            config.register_player(name=agent["name"], algorithm=agent["algorithm"])
            game_result = start_poker(config, verbose=0)
            if game_result["players"][0]["stack"] <= game_result["players"][1]["stack"]:
                win_rate[agent_idx][i] += 1
        win_rate[agent_idx][i] /= 100
        print(f"Win Rate: {win_rate[agent_idx][i]}")
# Print the final win rates
point = 0
print("Final Win Rates:")
for agent_idx, agent in enumerate(agents):
    print(f"{agent['name']}: {win_rate[agent_idx]}")
    for i in range(1, len(baselines)):
        point += 5 if win_rate[agent_idx][i] >= 0.6 else 1.5 * (win_rate[agent_idx][i]//0.2)
    print(f"Total Point: {point}")