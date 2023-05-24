from flask import Flask, request, jsonify
import simple_linear_regr
import numpy

app = Flask(__name__)

## Endpoint for training. Saves trained param W,b to current server
##
## CALL
## curl http://localhost:5000/train
##
## RESPONSE
## {"Training Success":true}
##
@app.route('/train', methods=['GET'])
def train():
    res = simple_linear_regr.train_main() #True or False upon training success    
    return jsonify({'Training Success': res})



## Endpoint for single record prediction
##
## CALL
## curl -X POST -H "Content-Type: application/json" -d '{"record": "0.5"}' http://localhost:5000/stream
##
## RESPONSE
## {"prediction":"[138.0802981]"}
##
@app.route('/stream', methods=['POST'])
def stream_prediction():
    payload = request.get_json()
    record = payload['record']

    # string input -> array
    lst = [float(e) for e in record.split(",")]
    arr = numpy.array(lst)

    # prediction array result -> string
    prediction = simple_linear_regr.predict_main(arr)
    res = str(prediction)

    # Return as a JSON response
    return jsonify({'prediction': res})


## Endpoint for batch prediction
##
## CALL
## curl -X POST -H "Content-Type: application/json" -d '{"records": ["0.5", "0.1", "0.3"]}' http://localhost:5000/batch
##
## RESPONSE
## {"predictions":"[[192.54174032215343], [186.90568631371235], [189.7237133179329]]"}
##
@app.route('/batch', methods=['POST'])
def batch_prediction():
    payload = request.get_json()
    records = payload['records']

    lst = [float(e) for e in records]

    #[x,y,z] -> [[x],[y],[z]]
    lst = list(map(lambda x:[x], lst))
    arr = numpy.array(lst)

    # Alternative: Perform prediction logic on each record in the batch
    # predictions = [lr.predict_main(record) for record in records]

    # prediction array result -> list -> string for pretty form
    prediction = simple_linear_regr.predict_main(arr)
    prediction = [l.tolist() for l in prediction]
    res = str(prediction)

    # Return the predictions as a JSON response
    return jsonify({'predictions': res})





if __name__ == '__main__':
    app.run()
