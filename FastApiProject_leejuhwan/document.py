class Document(object):
    def __init__(self, time, name, workoutName, count, videoID):
        self.time = time
        self.name = name
        self.workoutName = workoutName
        self.count = count
        self.videoID = videoID

    def from_dict(source):
        doc = Document(source[u'time'], source[u'name'], source[u'workoutName'], source[u'count'], source[u'videoID'])
        return doc

    def to_dict(self):
        doc = {"time": self.time, "name": self.name, "workoutName": self.workoutName,
               "count": self.count, "videoID": self.videoID}
        return doc

    def __repr__(self):
        return f"City(\
                time = {self.time} \
                name={self.name}, \
                workoutName={self.workoutName}, \
                count={self.count}, \
                videoID={self.videoID}\
            )"