import json
import random

movie_data = [
    {
        # "director": "Frances Herbert",
        # "title": f"Dune {i}",
        "score": round(random.uniform(0, 10), 1),
        "movie_id": i
    }
    for i in range(10, 1011)
]

json_data = {"movie_data": movie_data}

file_path = "dune_movies_with_scores.json"
with open(file_path, "w") as json_file:
    json.dump(json_data, json_file, indent=2)

print(f"Generated JSON file with scores: {file_path}")
