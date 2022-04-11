from flask import Flask, flash, redirect, render_template, request, session, abort
import joblib
import pandas as pd
from sklearn.linear_model import LinearRegression

app = Flask(__name__)

@app.route("/", methods=['GET', 'POST'])
def index():
    return render_template('index.html') 

@app.route("/submit_data", methods=['POST'])
def rec():
    req_data = request.form
    clf = joblib.load("brandy.pkl")
    age = req_data['age']
    weight = req_data['weight']
    x = pd.DataFrame([[age, weight]], columns=["Age", "Weight"])
    prediction = clf.predict(x)[0]
    print(prediction)
    return render_template('index.html', data=prediction) 

if __name__ == "__main__":
    app.run()
    print("Cognac")