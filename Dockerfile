#Use Python 3.11 as a base image
FROM python:3.11
# Copy contents into image
  COPY requirements.txt .
# install pip dependencies from requirements file
 RUN pip install -r requirements.txt
# Expose correct port
COPY . .
# Create an entrypoint
CMD ["python", "lbg.py"]