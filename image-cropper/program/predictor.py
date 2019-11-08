from __future__ import print_function

import json
import cv2
import flask, urllib.request
import numpy as np

prefix = '/opt/ml/'

app = flask.Flask(__name__)


def crop_and_resize(img, resize=224):
        #center_crop
        if img.shape[0] > img.shape[1]:
            margin = (img.shape[0] - img.shape[1]) // 2
            img = img[margin:margin + img.shape[1], :]
        else:
            margin = (img.shape[1] - img.shape[0]) // 2
            img = img[:, margin:margin + img.shape[0]]

        #resize
        if img.shape[0] > img.shape[1]:
            newsize = (resize, img.shape[0] * resize // img.shape[1])
        else:
            newsize = (img.shape[1] * resize // img.shape[0], resize)
        img = cv2.resize(img, newsize)
        return img


def parseRequest(content_type, data):
    if content_type == 'application/json':
        try:
            data = json.loads(data)            
            f = urllib.request.urlopen(data['url'])
            data = f.read()
        except:
            ret = 'url open error: '+ str(data)
            raise ValueError(ret)

    #bytearrayをcv2形式に変換してcrop&resize
    try: 
        data = bytearray(data)
        nparr = np.asarray(data, dtype=np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        img = crop_and_resize(img)
        img = cv2.imencode('.jpg', img)[1].tostring()
    except:
        ret = 'image data error: '+ str(data)
        raise ValueError(ret)
    return img


@app.route('/ping', methods=['GET'])
def ping():
    """always 200"""
    status = 200
    return flask.Response(response='\n', status=status, mimetype='application/json')


@app.route('/invocations', methods=['POST'])
def transformation():
    """
    画像のバイト文字列またはURLを受け取ってリサイズして返す
    """
    try:
        payload = parseRequest(flask.request.content_type, flask.request.data)
    except ValueError as e:
        return flask.Response(response=e, status=400, mimetype='text/plain')
    return flask.Response(response=payload, status=200, mimetype='application/x-image')
