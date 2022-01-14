import datetime
import json
import mimetypes
import pathlib
import sqlite3
import time
from typing import List

from flask import Flask, make_response, Response, request

folderPath = pathlib.Path(__file__).parent
dbPath = folderPath.joinpath("nh.db").absolute()

app = Flask(__name__)

@app.route("/addVisitedManga")
def add_visited_manga():
    con = sqlite3.connect(dbPath)
    id = request.args.get("id", str)
    title = request.args.get("title", str)
    first_visit_now = time.time()
    latest_visit_now = first_visit_now
    title = request.args.get("title", str)
    con.cursor().execute("insert OR IGNORE into mangas values (?,?,?,?)", (id,title, first_visit_now, latest_visit_now))
    con.commit()
    con.close()
    return Response(response="added", status=301, mimetype="application/json")

@app.route("/mangas/<int:id>")
def get_manga(id):
    con = sqlite3.connect(dbPath)
    row = con.cursor().execute("select * from mangas where id=?", (id,)).fetchone()
    con.close()
    return Response(response=json.dumps(row), status=200, mimetype="application/json")


def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

@app.route("/mangas")
def get_mangas():
    ids = request.args.get("id").split(",")

    con = sqlite3.connect(dbPath)
    con.row_factory = sqlite3.Row
    questionmarks = ','.join('?' * len(ids))

    rows = con.execute(f'select * from mangas where id in ({questionmarks})', ids).fetchall()
    con.close()

    json_str = json.dumps([dict(row) for row in rows])
    return Response(response=json_str, status=200, mimetype="application/json")


app.run(port=5000, debug=True)

