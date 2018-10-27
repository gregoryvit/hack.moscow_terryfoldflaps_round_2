import json

from flask import abort, request

from . import api


@api.route("/rating", methods=['POST'])
def search():
    data = request.data
    data_dict = json.loads(data)

    product_id = data_dict['product_id']
    new_rating = data_dict['rating']

    print(product_id)
    print(new_rating)

    return "OK"
