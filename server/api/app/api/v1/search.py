import json
import os

from flask import abort, jsonify, request
from numpy import dot
from numpy.linalg import norm

from . import api


#######

def load_products():
    with open('/data/products.json') as f:
        data = json.load(f)
        return data


def load_vectors():
    with open('/data/vectors.json') as f:
        data = json.load(f)
        return data


def cos_sim(a, b):
    return dot(a, b) / (norm(a) * norm(b))


@api.route("/search", methods=['POST'])
def search():
    data = request.data
    data_dict = json.loads(data)

    query_vec = data_dict['vec']

    vectors = load_vectors()

    results = []
    for product_id, vectors in vectors.items():
        for vec in vectors:
            results.append((product_id, cos_sim(query_vec, vec)))

    best_product_id, accuracy = sorted(results, key=lambda a: a[1])[-1]

    products = load_products()

    if best_product_id in products:
        result = products[best_product_id]
        result["accuracy"] = accuracy
    else:
        result = None
        abort(404, message="Product not found")

    return jsonify({
        "result": result
    })
