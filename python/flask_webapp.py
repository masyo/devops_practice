#!/bin/python

from flask import Flask, request, render_template
from pymongo import MongoClient

DBNAME = "nosqldb"
COLLECTION_NAME = "birthdays"

app = Flask(__name__)


@app.route("/", methods=["POST", "GET"])
def input():
    """Print input form for First Name, Last Name and Birthdate."""
    if request.method == "POST":
        client = MongoClient()
        db = client[DBNAME]
        list = db[COLLECTION_NAME]
        l_id = list.insert_one({"firstname": request.form["firstname"],
                                "lastname": request.form["lastname"],
                                "birthdate": request.form["birthdate"]})
        return "{name}, your records have been submitted as {id}".format(
            name=request.form["firstname"], id=l_id.inserted_id)

    return '''<form method="POST">
                  First Name: <input type="text" name="firstname"><br>
                  Last Name: <input type="text" name="lastname"><br>
                  Birthdate: <input type="text" name="birthdate"><br>
                  <input type="submit" value="Submit"><br>
              </form>'''


@app.route("/output", methods=["GET"])
def output():
    """Print all the records of birthdays."""
    client = MongoClient()
    db = client[DBNAME]
    list = db[COLLECTION_NAME]
    records = []
    for record in list.find():
        records.append(record)
    return render_template('output.j2', records=records)
