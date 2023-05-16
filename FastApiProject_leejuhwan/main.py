import pytz
from fastapi import FastAPI, UploadFile, File, Form, Response
from fastapi.responses import StreamingResponse
from pymongo import MongoClient
from bson import ObjectId
from bson.json_util import dumps
from gridfs import GridFS
import io
import urllib.parse
import datetime as dt
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import document

app = FastAPI()

cred = credentials.Certificate("capstone-7a008-firebase-adminsdk-w07yk-3b89ac655b.json")
firebase_admin.initialize_app(cred)
ref = firestore.client()

client = MongoClient("localhost")

db = client['Cluster0']
col = db['userData']
fs = GridFS(db)


@app.get("/")
async def read_root():
    return {"Hello": "World"}


@app.get("/ping")
async def ping():
    return {"message": "pong"}


# 라즈베리파이에서 받은 영상 mongodb에 저장
@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    file_name = file.filename
    contents = await file.read()
    file_id = fs.put(contents, filename=file_name)
    file_object = fs.find_one({"_id": ObjectId(file_id)})
    string = file_name.split('_')

    name = string[0]
    workout_name = string[1]
    count = string[2].strip(".mp4")

    upload_time = dt.datetime.now()

    doc = {
        "time": upload_time,
        "name": name,
        "workoutName": workout_name,
        "count": count,
        "video_id": str(file_id)
    }

    firestore_document = document.Document(
        dt.datetime.now(tz=pytz.utc), name, workout_name, count, str(file_id))
    upload_time.strftime("%Y_%m_%d")
    user_ref = ref.collection(name).document(upload_time.strftime("%Y_%m_%d"))
    if user_ref.get().exists:
        # 문서가 존재하는 경우 문서를 가져옴
        doc_data = user_ref.get().to_dict()
    else:
        # 문서가 존재하지 않는 경우 처리 로직 수행
        user_ref.set({'foo': 'bar'})
        pass

    workout_ref = user_ref.collection('workout')
    workout_ref.add(firestore_document.to_dict())

    col.insert_one(doc)
    return {"filename": file.filename, "file_id": str(file_id), "file_content": str(file_object.read())}

@app.get("/video/{id}")
async def stream_video(id: str, response: Response):
    try:
        file = fs.find_one({"_id": ObjectId(id)})
        file_data = file.read()
        encoded_filename = file.filename.encode('utf-8')
        headers = {
            'Content-Disposition': f'inline; filename="{encoded_filename}"',
            'Content-Type': 'video/mp4'
        }

        return Response(content=file_data, headers=headers, media_type='video/mp4')

    except Exception as e:
        response.status_code = 404
        return {"error": "Video not found"}


@app.get("/downloadfile/{file_id}")
async def read_upload_file(file_id: str):
    file_object = fs.find_one({"_id": ObjectId(file_id)})
    file_content = file_object.read()
    file_name = file_object.filename
    encoded_file_name = urllib.parse.quote(file_name.encode('utf-8'))
    response = StreamingResponse(io.BytesIO(file_content), media_type='application/octet-stream')
    response.headers["Content-Disposition"] = f"attachment; filename*=UTF-8''{encoded_file_name}"
    return response


if __name__ == "__main__":
    # 호스트 서버의 IP 주소와 포트 번호를 지정
    HOST_IP = '0.0.0.0'
    HOST_PORT = 8000
    import uvicorn

    uvicorn.run(app, host=HOST_IP, port=HOST_PORT)