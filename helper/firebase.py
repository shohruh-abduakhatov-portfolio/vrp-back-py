import time
from urllib.error import HTTPError

from google.cloud import firestore
from datetime import datetime

# Add a new document
db = firestore.Client()


class FirebaseApi(object):

    def __init__(self):
        pass


    def _update(self, collection, doc, key, value):
        ok = False
        while not ok:
            try:
                doc_ref = db.collection(collection).document(doc)
                doc_ref.set({
                    key: value
                })
                ok = True
            except HTTPError:
                time.sleep(1)
        return key + " >> updated"


def push_to_firebase(collection, doc, key, value):
    fb = FirebaseApi()
    return fb._update(collection, doc, key, value)


if __name__ == '__main__':
    key = 'update'
    push_to_firebase(key,key,key, datetime.now().timestamp())
