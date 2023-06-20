FROM python:3.5
MAINTAINER PRAVEEN_SAMERLA
COPY . /app
WORKDIR /app
RUN  pip install --upgrade pip\
&& pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
