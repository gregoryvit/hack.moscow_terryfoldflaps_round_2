from flask import Blueprint, render_template, abort, jsonify

api = Blueprint('api', __name__)


@api.route("/test")
def treasure_list():
    return jsonify([
        {'key': 'value'}
    ])


from .search import *
from .rating import *
